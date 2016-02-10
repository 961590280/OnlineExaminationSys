package com.cw.oes.email;
/**
 * 邮箱验证类
 * @author CW
 *
 */
public class EmailVerify {
	private static String HOST = "smtp.163.com";
	private static String PORT = "25";
	private static Boolean VALIDATE = true;
	private static String USER_NAME = "oes_admin@163.com";
	private static String USER_PASSWORD = "hdall92389";
	private static String FROM_ADDRESS = "oes_admin@163.com";
	private static String SUBJECT = "oes 邮箱激活";
	private static String CONTENT = "请点击下方链接进行验证后方可激活oes账号 <br/><a target='_blank' href='url'>去激活账号</a>";
	
	public static boolean sendVarifyEmail(String toAddress,String url){
		boolean sendSuccess ;
		try{
			//设置邮件参数  
			  SendMail mail = new SendMail();  
			  mail.setMailServerHost(HOST); //这里填发送者的邮箱服务器，我以qq举个例子  
			  mail.setMailServerPort(PORT);  
			  mail.setValidate(VALIDATE);  
			  mail.setUserName(USER_NAME);  
			  mail.setPassword(USER_PASSWORD);
			  mail.setFromAddress(FROM_ADDRESS);
			  mail.setToAddress(toAddress);  
			  mail.setSubject(SUBJECT);
			  mail.setContent(CONTENT.replace("url", url));  
			  
			  //发送邮件  
			  MailSender sms = new MailSender();  
			  sendSuccess =  sms.sendHtmlMail(mail);
		}catch(Exception e){
			sendSuccess =  false;
		}
		return sendSuccess;
	}
	
	public static void main(String[] args) {
		//设置邮件参数  
		  SendMail mail = new SendMail();  
		  mail.setMailServerHost(HOST); //这里填发送者的邮箱服务器，我以qq举个例子  
		  mail.setMailServerPort(PORT);  
		  mail.setValidate(VALIDATE);  
		  mail.setUserName(USER_NAME);  
		  mail.setPassword(USER_PASSWORD);
		  mail.setFromAddress(FROM_ADDRESS);  
		  mail.setToAddress("438171439@qq.com");  
		  mail.setSubject("oes 注册验证邮件");
		  mail.setContent("请点击下方链接 进行验证后方可登录oes网站");  
		  
		  //发送邮件  
		  MailSender sms = new MailSender();  
		  sms.sendTextMail(mail);//发送文体格式  
		  sms.sendHtmlMail(mail);//发送html格式  
	}
	
}
