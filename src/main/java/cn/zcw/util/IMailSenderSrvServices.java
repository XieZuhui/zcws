package cn.zcw.util;

import org.springframework.transaction.annotation.Transactional;
import javax.mail.MessagingException;

public interface IMailSenderSrvServices {
    /*普通格式发送
     * @recipient 收件人地址
     * @subject 主题
     * @content 正文
     * */
    @Transactional
    void sendEmail(String recipient,String subject,String content);

    /*带抄送
     * */
    void sendHtmlEmail(String recipient,String subject,String content) throws MessagingException, Exception;
    void send(String recipient,String validateCode,String username);

    void sendGetBack(String recipient,String validateCode,String username);
    void sendRealname(String recipient,String validateCode,String username);
}