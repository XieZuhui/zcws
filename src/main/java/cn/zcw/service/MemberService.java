package cn.zcw.service;

import cn.zcw.bean.Member;
import cn.zcw.bean.Member_cert;
import cn.zcw.bean.User;
import cn.zcw.util.PageBean;

import java.util.List;

public interface MemberService {

    int regist(Member member);
    int validate(String validateCode);
    List<User> doUserLogin(User user);
    List<Member> doMemberLogin(Member member);
    PageBean<User> getUserList(String querytext, Integer pageno, Integer pageSize);

    int regSelect(String loginacct);

    void registMore(String validateCode);

    int getBackSendMail(String loginacct);

    Member getMemberByValidateCode(String validateCode);

    int updateMemberPwd(Member member);

    int sendValidateRealnameEmail(int id,String username,String email);

    int realnameValidate(Integer id, String validatecode);

    int saveRealnameMsg(Member waitMember, Member_cert member_cert);
}
