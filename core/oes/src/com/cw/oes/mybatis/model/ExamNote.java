package com.cw.oes.mybatis.model;

public class ExamNote {
    private String uuid;

    private String memberPid;

    private String topicPid;

    private String content;

    private String createTime;

    private String updateTime;

    private String isImport;
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }

    public String getMemberPid() {
        return memberPid;
    }

    public void setMemberPid(String memberPid) {
        this.memberPid = memberPid == null ? null : memberPid.trim();
    }

    public String getTopicPid() {
        return topicPid;
    }

    public void setTopicPid(String topicPid) {
        this.topicPid = topicPid == null ? null : topicPid.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }

	public String getIsImport() {
		return isImport;
	}

	public void setIsImport(String isImport) {
		this.isImport = isImport == null ? null : isImport.trim();;
	}
    
    
}