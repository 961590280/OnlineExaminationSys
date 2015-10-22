package com.cw.oes.mybatis.model;

public class Member extends Model{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String uuid;

    private String userName;

    private String userPwd;

    private String userRegTime;

    private String userIsDel;
    
    private String userHead;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd == null ? null : userPwd.trim();
    }

    public String getUserRegTime() {
        return userRegTime;
    }

    public void setUserRegTime(String userRegTime) {
        this.userRegTime = userRegTime == null ? null : userRegTime.trim();
    }

    public String getUserIsDel() {
        return userIsDel;
    }

    public void setUserIsDel(String userIsDel) {
        this.userIsDel = userIsDel == null ? null : userIsDel.trim();
    }

	public String getUserHead() {
		return userHead;
	}

	public void setUserHead(String userHead) {
		 this.userHead = userHead == null ? null : userHead.trim();
	}
    
    
}