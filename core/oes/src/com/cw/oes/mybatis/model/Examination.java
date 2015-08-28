package com.cw.oes.mybatis.model;

public class Examination {
	public static final String EXAM_TYPE_PERSONAL = "1";//个人测验
	public static final String EXAM_TYPE_PUBLIC = "2";//公开考试
	
    private String uuid;

    private String examType;

    private String examPaperPid;

    private String examBeginTime;

    private String examEndTime;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType == null ? null : examType.trim();
    }

    public String getExamPaperPid() {
        return examPaperPid;
    }

    public void setExamPaperPid(String examPaperPid) {
        this.examPaperPid = examPaperPid == null ? null : examPaperPid.trim();
    }

    public String getExamBeginTime() {
        return examBeginTime;
    }

    public void setExamBeginTime(String examBeginTime) {
        this.examBeginTime = examBeginTime == null ? null : examBeginTime.trim();
    }

    public String getExamEndTime() {
        return examEndTime;
    }

    public void setExamEndTime(String examEndTime) {
        this.examEndTime = examEndTime == null ? null : examEndTime.trim();
    }
}