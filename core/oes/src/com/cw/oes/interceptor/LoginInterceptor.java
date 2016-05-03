package com.cw.oes.interceptor;

import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.cw.oes.security.*;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.UserSessionBean;

public class LoginInterceptor implements HandlerInterceptor{
	
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		HttpSession session = request.getSession();
		String path = request.getContextPath();
		String reqUrl = request.getServletPath();//请求的url
		
		
		if(reqUrl.contains("/common/")){//对需要用户登录的请求进行拦截
			
			
			
			
			String returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/common/toLoginPage?err=2"; //返回页
			UserSessionBean usb = (UserSessionBean) session.getAttribute(Environment.SESSION_USER_LOGIN_INFO);  //获取用户会话信息
			
			
			
			
			if("/common/toLoginPage".equals(reqUrl)){
				//如果已经登陆
				if(usb != null){
					returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/common/index";
					response.sendRedirect(returnUrl);
					return false;
				}
			}
			
			//登录页面和登录请求不进行过滤
			if("/common/toLoginPage".equals(reqUrl)||"/common/autoLogin".equals(reqUrl) || "/common/memberLogin".equals(reqUrl)||"/common/index".equals(reqUrl)
					||"/common/ajax/memberLogin".equals(reqUrl)||"/common/toRegisterPage".equals(reqUrl)||"/common/ajax/memberRegister".equals(reqUrl)
					||"/common/ajax/memberIsUsed".equals(reqUrl)||"/common/verifyEmail".equals(reqUrl)||"/common/varifySuccess".equals(reqUrl)
					||"/common/ajax/sendFindBackPasswordEmail".equals(reqUrl)||"/common/findBackPasswordPage".equals(reqUrl)||"/common/ajax/resetPassword".equals(reqUrl)
					||"/common/comingSoon".equals(reqUrl)) {
				
				
				return true;
			}
			
			if(usb == null) {
				
				/**
				 * 尝试读取cookie自动登录
				 */
				Cookie[] cookies = request.getCookies();
		        if(cookies != null){
		            for(Cookie cookie : cookies)
		            {
		                if(cookie.getName().equals("oes-cookie"))
		                {
		                	returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/common/autoLogin?cookie="+cookie.getValue()+"&reqUrl="+request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path; 
		                	returnUrl +=	CookiesUtil.requestURLEncode(request);
		                	response.sendRedirect(returnUrl);
		                    return true;
		                }
		            }
		        }
		        
		        if(reqUrl.contains("/ajax/")){//判断是否是ajax请求
					
					response.setStatus(60000);
					return false;
				}else{
					response.sendRedirect(returnUrl);
					return false;
				}
			}
		}	
		return true;
	}

}
