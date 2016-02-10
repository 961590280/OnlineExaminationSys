package com.cw.oes.websocket.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.ServerEndpoint;

import jdk.internal.jfr.events.FileWriteEvent;
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
import com.cw.oes.utils.ExamVideoStreamUtil;
import com.cw.oes.utils.JsonUtil;
import com.cw.oes.websocket.WebSocketCache;
import com.google.gson.Gson;
/**
 * 视频监控的socket
 * @author CW
 *
 */
public class VideoMonitoringSocket  implements WebSocketHandler {
	@Resource
	private WebSocketService webSocketService;
	
	private static Map<String,FileWriter> outCache = new HashMap<String,FileWriter>();
	/**
	 * 会话关闭
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus arg1)
			throws Exception {
		String userId  = (String) session.getAttributes().get("userId");
		WebSocketCache.removeMemberSession(session);
		FileWriter out =  outCache.get(userId);
		if(out != null){
			System.out.println("--");
			out.flush();
			out.close();
		}
		System.out.println("连接关闭");
		
	}
	/**
	 * 连接成功
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		
		// TODO Auto-generated method stub
		System.out.println("连接成功");
		String userId  = (String) session.getAttributes().get("userId");
		String examId  = (String) session.getAttributes().get("examId");
		
		
		
		
		System.out.println(userId);
		System.out.println(examId);
		
		WebSocketCache.putMonitorSession(userId,session);
		File file = new File(ExamVideoStreamUtil.VIDEOS_PATH+"/"+examId+"/"+userId+".oes");
		file.createNewFile();
		FileWriter out = new FileWriter(file, true); //打开文件连接,追加形式
		
		
		outCache.put(userId, out);
		
	}
	/**
	 * 处理会话
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message)
			throws Exception {
		String userId  = (String) session.getAttributes().get("userId");
		System.out.println(userId);
		FileWriter out = outCache.get(userId);
		if(out != null){ 
			out.write(message.getPayload().toString());
			System.out.println("--");
		}
		
	}
	/**
	 * 会话抛出异常
	 */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable arg1)
			throws Exception {
		// TODO Auto-generated method stub
		String userId  = (String) session.getAttributes().get("userId");
		System.out.println(userId);
		FileWriter out = outCache.get(userId);
		if(session.isOpen()){
            session.close();
            out.close();
        }
	}

	@Override
	public boolean supportsPartialMessages() {
		// TODO Auto-generated method stub
		return false;
	}  
	
	
}
