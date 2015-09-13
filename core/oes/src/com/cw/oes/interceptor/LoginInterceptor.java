package com.cw.oes.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

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
		String reqUrl = request.getServletPath();
		if(reqUrl.contains("/common/")){
			//登录页面和登录请求不进行过滤
			if("/common/toLoginPage".equals(reqUrl) || "/common/memberLogin".equals(reqUrl)||"/common/index".equals(reqUrl)||"/common/ajax/memberLogin".equals(reqUrl)) {
				return true;
			}
			
			String returnUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/common/toLoginPage?err=2"; //返回页
			UserSessionBean usb = (UserSessionBean) session.getAttribute(Environment.SESSION_USER_LOGIN_INFO);  //获取用户会话信息
			if(usb == null) {
				response.sendRedirect(returnUrl);
				return false;
			}
		}	
		return true;
	}

}
