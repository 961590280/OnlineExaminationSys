package com.cw.oes.mybatis.model;

public class MessageKey {
    private String senderPid;

    private String reciverPid;

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
}