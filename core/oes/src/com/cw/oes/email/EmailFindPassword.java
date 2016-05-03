package com.cw.oes.email;
/**
 * 邮箱验证类
 * @author CW
 *
 */
public class EmailFindPassword {
	private static String HOST = "smtp.163.com";
	private static String PORT = "25";
	private static Boolean VALIDATE = true;
	private static String USER_NAME = "oes_admin@163.com";
	private static String USER_PASSWORD = "hdall92389";
	private static String FROM_ADDRESS = "oes_admin@163.com";
	private static String SUBJECT = "oes 找回钥匙";
	private static String CONTENT = "请点击<a target='_blank' href='_url'>传送门</a>找回钥匙";
	
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
			  mail.setContent(CONTENT.replace("_url", url));  
			  
			  //发送邮件  
			  MailSender sms = new MailSender();  
			  sendSuccess =  sms.sendHtmlMail(mail);
		}catch(Exception e){
			sendSuccess =  false;
		}
		return sendSuccess;
	}
	
	public static void main(String[] args) {
		
	}
	
}
