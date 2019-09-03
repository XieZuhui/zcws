package cn.zcw.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service("MailSenderSrvService")
public class MailSenderSrvServiceImpl implements IMailSenderSrvServices{
    @Autowired
    private JavaMailSenderImpl mailSender;

    /**
     *   JavaMailSenderImpl支持MimeMessages和SimpleMailMessages。
     * MimeMessages为复杂邮件模板，支持文本、附件、html、图片等。
     * SimpleMailMessages实现了MimeMessageHelper，为普通邮件模板，支持文本
     */


    /**
     * 描述：Spring 依赖注入
     * @author wanghaoyu
     * @date
     * @version 1.0
     * @param mailSender
     * @since 1.8
     *
     */
    public void setMailSender(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * 单发
     *
     * @param recipient 收件人
     * @param subject 主题
     * @param content 内容
     */
    @Override
    public void sendEmail(String recipient,String subject,String content) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage,true,"UTF-8");
            messageHelper.setFrom("2314470483@qq.com");//发件人
            messageHelper.setTo(recipient);
            messageHelper.setSubject(subject);
            messageHelper.setText(content,true);//true代表支持html格式
            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            e.printStackTrace();
        }


    }


    @Override
    public void sendHtmlEmail(String recipient,String subject,String content) throws Exception {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage,true,"UTF-8");
            messageHelper.setFrom("xx@qq.com");//发件人
            messageHelper.setTo(recipient);
            messageHelper.setSubject(subject);
            messageHelper.setText(content,true);
            mimeMessage.setRecipients(Message.RecipientType.CC,"xx@qq.com");//抄送人
            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public  void send(String recipient,String validateCode,String username){
        String to = recipient;  //收件人地址
        String subject = "众筹网激活邮件";   //邮件标题
        String content = "亲爱的"+username+",这是一个好网站<br>"+
                "<h2><a  href = 'http://www.zcw.com/validate.do?validateCode="+validateCode+"'>点击这里激活您的众筹网账号,48小时内有效</a></h2><br>" +
                "<h2><a  href = 'http://www.zcw.com/newValidateCode.do?validateCode="+validateCode+"'>若激活失败点击这里</a></h2>";    //邮件内容
        sendEmail(to,subject,content);
    }

    @Override
    public void sendGetBack(String recipient,String validateCode,String username) {
        String to = recipient;  //收件人地址
        String subject = "众筹网找回密码邮件";   //邮件标题
        String content = "亲爱的"+username+",这是一个好网站<br>"+
                "<h2><a  href = 'http://www.zcw.com/getBackPwd.do?validateCode="+validateCode+"'>点击这里找回密码</a></h2><br>" ;
        sendEmail(to,subject,content);
    }

    public void sendRealname(String recipient,String validateCode,String username) {
        String to = recipient;  //收件人地址
        String subject = "众筹网实名验证邮件";   //邮件标题
        String content = "亲爱的"+username+",这是一个好网站<br>"+
                "<h2>您的实名认证验证码为"+validateCode+"，请尽快进行验证</h2><br>" ;
        sendEmail(to,subject,content);
    }



}
