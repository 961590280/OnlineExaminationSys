package com.cw.oes.websocket.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.ServerEndpoint;

import net.sf.json.JSONObject;

import org.springframework.cglib.core.Constants;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cw.oes.form.RequestDataForm;
import com.cw.oes.service.impl.CommonService;
import com.cw.oes.service.impl.WebSocketService;
import com.cw.oes.utils.JsonUtil;
import com.cw.oes.websocket.WebSocketCache;
import com.google.gson.Gson;
/**
 * 处理消息的socket
 * @author CW
 *
 */
public class PublishMessageSocket  implements WebSocketHandler {
	@Resource
	private WebSocketService webSocketService;
	
   
	/**
	 * 会话关闭
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus arg1)
			throws Exception {
		
		WebSocketCache.removeMemberSession(session);
	}
	/**
	 * 连接成功
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		
		// TODO Auto-generated method stub
		
		System.out.println(session);
		
		Map<String,String> select = new HashMap<String, String>();
		String userId = (String) session.getAttributes().get("userId");
		String userPwd = (String) session.getAttributes().get("userPwd");
		select.put("userId", userId);
		select.put("userPwd", userPwd);
		String result = webSocketService.getNewMessage(select);
        session.sendMessage( new TextMessage(result.toString()));
        WebSocketCache.putMemberSession(select.get("userId"),session);
        
		
	}
	/**
	 * 处理会话
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String,String> select = JsonUtil.jsonToMap(message.getPayload().toString()); 
		String result = webSocketService.getNewMessage(select);
        session.sendMessage( new TextMessage(result.toString()));
        WebSocketCache.putMemberSession(select.get("userId"),session);
	}
	/**
	 * 会话抛出异常
	 */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable arg1)
			throws Exception {
		// TODO Auto-generated method stub
		if(session.isOpen()){
            session.close();
        }
		 WebSocketCache.removeMemberSession(session);
	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}  
	
	
}
