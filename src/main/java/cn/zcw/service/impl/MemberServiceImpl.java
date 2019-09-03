package cn.zcw.service.impl;

import cn.zcw.bean.*;
import cn.zcw.mapper.MemberMapper;
import cn.zcw.mapper.Member_certMapper;
import cn.zcw.mapper.Member_copyMapper;
import cn.zcw.mapper.UserMapper;
import cn.zcw.service.MemberService;
import cn.zcw.util.IMailSenderSrvServices;
import cn.zcw.util.MD5Util;
import cn.zcw.util.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private Member_certMapper member_certMapper;
    @Autowired
    private IMailSenderSrvServices mailsend;

    public int regist(Member member) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String date = df.format(new Date());// new Date()为获取当前系统时间
        member.setCreatetime(date);
        //将当前系统时间进行MD5加密后生成密钥，用于用户激活操作;
        String validateCode = MD5Util.digest(date);
        member.setValidatecode(validateCode);
        member.setUserpswd(MD5Util.digest(member.getUserpswd()));
        member.setAuthstatus("0");//测试记得修改
        mailsend.send(member.getEmail(),validateCode,member.getUsername());
        return memberMapper.insertSelective(member);
    }

    /**
     * 返回1代表激活成功，0激活失败，2表示已经是激活状态
     * @param validateCode
     * @return
     */
    @Override
    public int validate(String validateCode) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andValidatecodeEqualTo(validateCode);
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if(!memberList.isEmpty()){
            Member member = memberList.get(0);
            if(member.getActivationstatus()==1){
                return 2 ;
            }
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = df.format(new Date());
            try {
                Date dd1 = df.parse(date);
                Date dd2 = df.parse(member.getCreatetime());
                long number = dd1.getTime()- dd2.getTime();
                if(number <= 172800000){//小于48小时可以进行激活
                    //将Activationstatus更新为1,激活成功
                    MemberExample updatamemberExample = new MemberExample();
                    updatamemberExample.createCriteria().andIdEqualTo(member.getId());
                    member.setActivationstatus(1);
                    member.setValidatecode("");//激活成功后将验证码设为空
                    memberMapper.updateByExampleSelective(member,updatamemberExample);
                    return 1;
                }
                System.out.println("时间差为"+number);
            }catch (Exception e){
                e.printStackTrace();
            }
            return 0;
        }
        return 0;
    }

    /**
     *
     * @param user
     * @return
     * -1登录失败，1登录成功
     */
    public List<User> doUserLogin(User user){
        UserExample userExample = new UserExample();
        userExample.createCriteria().andLoginacctEqualTo(user.getLoginacct());
        List<User> list = userMapper.selectByExample(userExample);
        if(list==null){
           // System.out.println("-1");
        return null ;
        }else{
            if(list.get(0).getUserpswd().equals(user.getUserpswd())){
                //System.out.println("1");
                return list;

            }
           // System.out.println("-1");
            return null;
        }
    }

    @Override
    public List<Member> doMemberLogin(Member member) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andLoginacctEqualTo(member.getLoginacct());
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if(memberList.isEmpty()){
            return null;
        }else{
            if(memberList.get(0).getActivationstatus()==1 &&
                    memberList.get(0).getUserpswd().equals(member.getUserpswd())){
                return memberList;
            }
            return null;
        }
    }

    @Override
    public PageBean<User> getUserList(String querytext,Integer pageno, Integer pageSize) {
        UserExample userExample = new UserExample();
        PageBean<User> pb = new PageBean<>();
        pb.setPageno(pageno);
        pb.setPagesize(pageSize);
        if (querytext!=null && querytext.trim()!=""){
           userExample.createCriteria().andUsernameLike(querytext.trim());
           /* userExample.createCriteria().andEmailLike(querytext);
            userExample.createCriteria().andLoginacctLike(querytext);*/
        }
        userExample.setLeftLimit(pb.getPageno());
        userExample.setLimitSize(pb.getPagesize());
        System.out.println(userMapper.selectByExample(userExample).toString());
        pb.setTotalsize(userMapper.countByExample(userExample));
        pb.setDatas(userMapper.selectByExample(userExample));
        return pb;
    }

    @Override
    public int regSelect(String loginacct) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andLoginacctEqualTo(loginacct);
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList.isEmpty()){
            return 1;
        }else
        return 0;
    }

    @Override
    public void registMore(String validateCode) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andValidatecodeEqualTo(validateCode);
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if(!memberList.isEmpty()){
            Member member = memberList.get(0);
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            String date = df.format(new Date());// new Date()为获取当前系统时间
            member.setCreatetime(date);
            //将当前系统时间进行MD5加密后生成密钥，用于用户激活操作;
            String newvalidateCode = MD5Util.digest(date);
            member.setValidatecode(newvalidateCode);
            memberMapper.updateByExampleSelective(member,memberExample);
            mailsend.send(member.getEmail(),newvalidateCode,member.getUsername());
        }
    }

    /**
     * 1表示发送成，0表示失败
     * @param loginacct
     * @return
     */
    @Override
    public int getBackSendMail(String loginacct) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andLoginacctEqualTo(loginacct);
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if(memberList.isEmpty()){
            return 0;
        }else{
            Member member = memberList.get(0);
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            String date = df.format(new Date());// new Date()为获取当前系统时间
            member.setCreatetime(date);
            //将当前系统时间进行MD5加密后生成密钥，用于用户激活操作;
            String newvalidateCode = MD5Util.digest(date);
            member.setValidatecode(newvalidateCode);
            //点击找回密码操作，先将用户的激活状态设置为未激活，等待验证成功重设密码后再设置为激活
            member.setActivationstatus(0);
            memberMapper.updateByExampleSelective(member,memberExample);
            mailsend.sendGetBack(member.getEmail(),newvalidateCode,member.getUsername());
            return 1;
        }
    }

    @Override
    public Member getMemberByValidateCode(String validateCode) {
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andValidatecodeEqualTo(validateCode);
        List<Member> memberList = memberMapper.selectByExample(memberExample);
        if(memberList.isEmpty()){
            return null;
        }else{
            Member member = memberList.get(0);
            if(member.getActivationstatus()==1){
                return null;
            }
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = df.format(new Date());
            try {
                Date dd1 = df.parse(date);
                Date dd2 = df.parse(member.getCreatetime());
                long number = dd1.getTime()- dd2.getTime();
                if(number <= 172800000){//小于48小时可以进行重设密码
                    return member;
                }
                System.out.println("时间差为"+number);
            }catch (Exception e){
                e.printStackTrace();
            }
            return null;
        }
    }

    @Override
    public int updateMemberPwd(Member member) {
        member.setActivationstatus(1);
        member.setValidatecode("");
        int flag = memberMapper.updateByPrimaryKeySelective(member);
        return flag;
    }

    /**
     * 发送实名验证邮件
     * @param id
     * @param email 邮箱号
     * @return
     */
    public int sendValidateRealnameEmail(int id,String username,String email){
        String verifyCode = String
                .valueOf(new Random().nextInt(899999) + 100000);//生成6位验证码
        Member member = new Member();
        MemberExample memberExample = new MemberExample();
        memberExample.createCriteria().andIdEqualTo(id);
        member.setValidatecode(verifyCode);
        int flag = memberMapper.updateByExampleSelective(member,memberExample);
        mailsend.sendRealname(email,verifyCode,username);
        return flag;
    }

    public int realnameValidate(Integer id, String validatecode){
        Member member = memberMapper.selectByPrimaryKey(id);
        if(member.getValidatecode().equals(validatecode)){
            return 1;
        }
        return 0;
    }

    public int saveRealnameMsg(Member waitMember, Member_cert member_cert){
        String accttype =  waitMember.getAccttype();
        if("1".equals(accttype)||"2".equals(accttype)){
            waitMember.setUsertype("0");
        }else{waitMember.setUsertype("1");}
        waitMember.setAuthstatus("1");
        int memberflag = memberMapper.updateByPrimaryKeySelective(waitMember);
        int member_certflag = member_certMapper.insertSelective(member_cert);
        if(memberflag==1&&member_certflag==1){
            return 1;
        }
        return 0;
    }
}
