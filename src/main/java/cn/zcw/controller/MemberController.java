package cn.zcw.controller;

import cn.zcw.bean.AJAXResult;
import cn.zcw.bean.Member;
import cn.zcw.bean.Member_cert;
import cn.zcw.bean.User;
import cn.zcw.service.MemberService;
import cn.zcw.util.MD5Util;
import cn.zcw.util.PageBean;
import cn.zcw.util.UploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;


    @RequestMapping("/reg.do")
    public String doRegist(Member member,Model model){
        memberService.regist(member);
        model.addAttribute("msg","请快去邮箱激活账号");
        model.addAttribute("isSuccess","fail");
        return "/managers/success.jsp";
    }

    @RequestMapping("/newValidateCode.do")
    public String newValidateCode(String validateCode,Model model){
        memberService.registMore(validateCode);
        model.addAttribute("msg","邮件已重新发送，请快去邮箱激活账号");
        model.addAttribute("isSuccess","fail");
        return "/managers/success.jsp";
    }

    @RequestMapping("/validate.do")
    public String validate(String validateCode, Model model){
        int flag = memberService.validate(validateCode);
        if(flag==1){
            System.out.println("激活成功");
            model.addAttribute("msg","恭喜您激活成功");
            model.addAttribute("isSuccess","success");
            return "/managers/success.jsp";
        }
        if (flag==2){
            System.out.println("已经激活了呀");
            model.addAttribute("msg","您已经激活了呀");
            model.addAttribute("isSuccess","success");
            return "/managers/success.jsp";
        }
        System.out.println("激活失败了");
        model.addAttribute("msg","激活失败了，请重试");
        model.addAttribute("isSuccess","fail");
        return "/managers/success.jsp";
    }

    @ResponseBody
    @RequestMapping("/regSelect.do")
    public Object regSelect(String loginacct){
        System.out.println("/regSelect.do");
        AJAXResult result = new AJAXResult();
        int flag = memberService.regSelect(loginacct);
        if(flag!=1){
            //不等于1说明查询到有账号为loginacct的用户存在，则返回success，提醒重新输入进行注册
            result.setSuccess(true);
            return  result;
        }else
        result.setSuccess(false);
        return result;
    }

   /* @RequestMapping("/login.do")
    public String doLogin(User user){
        int flag = memberService.doLogin(user);
        if(flag==-1){
            return "/managers/login.jsp";
        }else {
        return "";
        }
    }*/

    /**
     * 在main页面显示当前登录的用户用户名的ajax方法(main1.html中运用)
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/getUsername.do")
   public Object getUsername(HttpServletRequest request){
        HttpSession session = request.getSession();
       AJAXResult result = new AJAXResult();
       String name = (String)session.getAttribute("logined");
       //System.out.println("2222username:"+name);
        if (name != null) {
            result.setUsername(name);
            result.setSuccess(true);
            return result;
        }
        result.setSuccess(false);
        return result;
   }

   @ResponseBody
   @RequestMapping("/userlogin.do")
   public Object doUserLogin(User user, HttpServletRequest request){
       HttpSession session = request.getSession(true);
       user.setUserpswd(MD5Util.digest(user.getUserpswd()));
       AJAXResult result = new AJAXResult();
       try {
           List<User> userList = memberService.doUserLogin(user);
           if(userList.isEmpty()){
               result.setSuccess(false);
           }else {
               result.setSuccess(true);
               //result.setUsername(userList.get(0).getUsername());
               session.setAttribute("loginedUser",userList.get(0));
               //System.out.println("1111username:"+userList.get(0).getUsername());
           }
       }catch (Exception e){
           e.printStackTrace();
           result.setSuccess(false);
       }
       return result;
   }

    @ResponseBody
    @RequestMapping("/memberlogin.do")
    public Object doMemberLogin(Member member, HttpServletRequest request){
        HttpSession session = request.getSession(true);
        member.setUserpswd(MD5Util.digest(member.getUserpswd()));
        AJAXResult result = new AJAXResult();
        try {
            List<Member> memberList = memberService.doMemberLogin(member);
            if(memberList.isEmpty()){
                result.setSuccess(false);
            }else {
                result.setSuccess(true);
                //result.setUsername(userList.get(0).getUsername());
                session.setAttribute("loginedUser",memberList.get(0));
                //System.out.println("1111username:"+userList.get(0).getUsername());
            }
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

   @ResponseBody
   @RequestMapping("/UserpageQuery.do")
   public Object pageQuery(String querytext,Integer pageno, Integer pageSize) {
        System.out.println("http://localhost/UserpageQuery.do");
        AJAXResult<User> result = new AJAXResult<>();
        PageBean<User> pb = new PageBean<>();
        Integer selectPageno = (pageno-1)*pageSize;
            pb = memberService.getUserList(querytext,selectPageno,pageSize);
            result.setSuccess(true);
            result.setPageBean(pb);

        System.out.println("给点？："+pb.getDatas().toString());
        return result;
   }

    @RequestMapping("/gotoEdit.do")
   public String gotoEdit( HttpServletRequest request)throws Exception{
        //AJAXResult<User> result = new AJAXResult<>();
        System.out.println("gogoggogogogogogg111111");
        //System.out.println(user.getUsername());
        return "redirect:/managers/edit2.html";
    }

    @ResponseBody
    @RequestMapping("/getBackSendMail.do")
    public  Object getBackSendMail(String loginacct){
        AJAXResult ajaxResult = new AJAXResult();
        int flag = memberService.getBackSendMail(loginacct);
        if(flag == 1){
            ajaxResult.setSuccess(true);
        }else {
            ajaxResult.setSuccess(false);
        }
        return ajaxResult;
    }

    @RequestMapping("/getBackPwd.do")
    public String getBackPwd(String validateCode,Model model){
        Member member = memberService.getMemberByValidateCode(validateCode);
        if(member!=null){
            model.addAttribute("memberid",member.getId());
            model.addAttribute("username",member.getUsername());
            return "/managers/getBackPwd.jsp";
        }
        return "/error.jsp";
    }

    @ResponseBody
    @RequestMapping("/updataMemberPwd.do")
    public Object updataMemberPwd(Member member){
        AJAXResult ajaxResult = new AJAXResult();
        member.setUserpswd(MD5Util.digest(member.getUserpswd()));
        int flag = memberService.updateMemberPwd(member);
        if(flag==1){
            ajaxResult.setSuccess(true);
            return ajaxResult;
            //return "redirect:/managers/login.html";
        }
        ajaxResult.setSuccess(false);
        return ajaxResult;
        //return "error.jsp";
    }


    /**
     * 暂时保存上传的实名认证信息到session中
     * @param request
     * @return
     */
    @RequestMapping("/saveCradPhoto.do")
    public String saveCradPhoto(HttpServletRequest request){
        System.out.println("/saveCradPhoto.do");
        Member member = new Member();
        Member_cert member_cert = new Member_cert();
        Map<String, String> map = UploadUtil.upload2(request);
        member.setId(Integer.parseInt(map.get("id")));;
        member.setAccttype(map.get("accttype"));
        member.setCardnum(map.get("cardnum"));
        member.setRealname(map.get("realname"));
        member_cert.setMemberid(Integer.parseInt(map.get("id")));
        member_cert.setCertid(7);
        member_cert.setIconpath(map.get("iconpath"));
        HttpSession session = request.getSession();
        session.setAttribute("waitMember",member);
        session.setAttribute("waitMember_cert",member_cert);
        System.out.println(member.toString());
        System.out.println(member_cert.toString());
        return "redirect:/member/apply-2.jsp";
    }

    @RequestMapping("/realnameEmail.do")
    public String sendValidateRealnameEmail(String email ,int id,String username,Model model){
        Member member = new Member();
        member.setId(id);
        member.setEmail(email);
        member.setUsername(username);
        int flag = memberService.sendValidateRealnameEmail(id,username,email);
        if(flag!=1){
            return "/error.jsp";
        }
        model.addAttribute("realnameMember",member);
        return "/member/apply-3.jsp";
    }

    @RequestMapping("/SaveandDoValidate.do")
    public String SaveandDoValidate(HttpServletRequest request,Member member){

        System.out.println("SaveandDoValidate.do:"+member.toString());
        HttpSession session = request.getSession();
        int flag = memberService.realnameValidate(member.getId(),member.getValidatecode());

        if(flag==1){
            Member waitMember = (Member) session.getAttribute("waitMember");
            Member_cert member_cert = (Member_cert)session.getAttribute("waitMember_cert");
            System.out.println(waitMember.toString());
            System.out.println();
            int saveflag = memberService.saveRealnameMsg(waitMember,member_cert);
            if(saveflag==1){
                return "redirect:/member/member.jsp";
            }
        }
        return "/error.jsp";
    }


}
