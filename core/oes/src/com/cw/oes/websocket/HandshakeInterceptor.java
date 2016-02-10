package com.cw.oes.websocket;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

/**
 * socket 握手拦截
 * @author CW
 *
 */
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{
	    @Override  
	    public boolean beforeHandshake(ServerHttpRequest request,  
	            ServerHttpResponse response, WebSocketHandler wsHandler,  
	            Map<String, Object> attributes) throws Exception {  
	        System.out.println("Before Handshake");  
	        ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
	        HttpServletRequest  httpServletRequest = servletRequest.getServletRequest();
            if (httpServletRequest != null) {
            	Enumeration  e = httpServletRequest.getParameterNames();
            	while( e.hasMoreElements())   {    //遍历参数，放到attributes中
            	    String name=(String)e.nextElement();  
            	    attributes.put(name,httpServletRequest.getParameter(name));
            	}   
            }
	        
	        return super.beforeHandshake(request, response, wsHandler, attributes);  
	    }  
	  
	    @Override  
	    public void afterHandshake(ServerHttpRequest request,  
	            ServerHttpResponse response, WebSocketHandler wsHandler,  
	            Exception ex) {  
	        System.out.println("After Handshake");  
	        super.afterHandshake(request, response, wsHandler, ex);  
	    }  
}
