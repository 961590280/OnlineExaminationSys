package com.cw.oes.mybatis.model;

public class Message {
    private String uuid;

    private String senderPid;

    private String reciverPid;

    private String sendTime;

    private String type;

    private String isRead;
    
    private String content;

    
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }

    public String getSenderPid() {
        return senderPid;
    }

    public void setSenderPid(String senderPid) {
        this.senderPid = senderPid == null ? null : senderPid.trim();
    }

    public String getReciverPid() {
        return reciverPid;
    }

    public void setReciverPid(String reciverPid) {
        this.reciverPid = reciverPid == null ? null : reciverPid.trim();
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime == null ? null : sendTime.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getIsRead() {
        return isRead;
    }

    public void setIsRead(String isRead) {
        this.isRead = isRead == null ? null : isRead.trim();
    }

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
    
}