package com.cw.oes.websocket;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.socket.WebSocketSession;

/**
 * 保存websocket链接
 * @author CW
 *
 */
public abstract class WebSocketCache {
	private static final HashMap<String,WebSocketSession> memberSessions;//会员websocket连接集合
	private static final HashMap<String,WebSocketSession> monitorSessions;//视频监控websocket连接集合	
    static {
    	memberSessions = new HashMap<String,WebSocketSession>();
    	monitorSessions = new HashMap<String,WebSocketSession>();
    }
    
    
    /**
     * 返回会员websocket连接
     * @param memberId  用户id
     * @return
     */
    public static WebSocketSession getMonitorSession(String memberId){
    	return memberSessions.get(memberId);
    }
    /**
     * 添加会员websocket连接
     * @param memberId 用户id
     * @return
     */
    public static WebSocketSession putMemberSession(String memberId,WebSocketSession session){
    	return memberSessions.put(memberId,session);
    }
    /**
     * 移除会员websocket连接
     * @param session  用户id
     * @return
     */
    public static WebSocketSession removeMemberSession(WebSocketSession session){
    	return memberSessions.remove(session);
    }
    
    
    ////////////////////////////
    
    /**
     * 返回监控websocket连接
     * @param memberId 用户id
     * @return
     */
    public static WebSocketSession getMemberSession(String memberId){
    	return monitorSessions.get(memberId);
    }
    /**
     * 添加监控websocket连接
     * @param memberId  用户id
     * @return
     */
    public static WebSocketSession putMonitorSession(String memberId,WebSocketSession session){
    	return monitorSessions.put(memberId,session);
    }
    /**
     * 移除监控websocket连接
     * @param session  用户id
     * @return
     */
    public static WebSocketSession removeMonitorSession(WebSocketSession session){
    	return monitorSessions.remove(session);
    }
}
