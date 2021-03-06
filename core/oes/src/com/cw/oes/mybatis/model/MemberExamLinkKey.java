package com.cw.oes.mybatis.model;

public class MemberExamLinkKey extends Model{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String memberPid;

    private String examPid;
    
    private String answer;

    private String createTime;
    
    private int status;
    
    
    public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getMemberPid() {
        return memberPid;
    }

    public void setMemberPid(String memberPid) {
        this.memberPid = memberPid == null ? null : memberPid.trim();
    }

    public String getExamPid() {
        return examPid;
    }

    public void setExamPid(String examPid) {
        this.examPid = examPid == null ? null : examPid.trim();
    }

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime == null ? null : createTime.trim();
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status ;
	}
    
}