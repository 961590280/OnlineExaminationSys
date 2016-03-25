package com.cw.oes.mybatis.model;

public class Examination {
	public static final String EXAM_TYPE_PERSONAL = "1";//个人测验
	public static final String EXAM_TYPE_PUBLIC = "2";//公开考试
	
    private String uuid;

    private String examType;

    private String examPaperPid;

    private String examBeginTime;

    private String examEndTime;

    private String examName;
    
    private String applyBeginTime;

    private String applyEndTime;
    
    private String description;
    
    private String location;
    
    private String price;
    
    private String organization;
    
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

	public String getExamName() {
		return examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	public String getApplyBeginTime() {
		return applyBeginTime;
	}

	public void setApplyBeginTime(String applyBeginTime) {
		this.applyBeginTime = applyBeginTime;
	}

	public String getApplyEndTime() {
		return applyEndTime;
	}

	public void setApplyEndTime(String applyEndTime) {
		this.applyEndTime = applyEndTime;
	}

	
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getOrganization() {
		return organization;
	}

	public void setOrganization(String organization) {
		this.organization = organization;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
    
    
}