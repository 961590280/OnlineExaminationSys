package com.cw.oes.pojo;

import java.io.Serializable;

import com.cw.oes.utils.Environment;

public class Member extends Pojo implements Serializable{
	
	private static final String MAPPER_METHOD_GET_ALL = Environment.MAPPER_PAKAGE+"MemberMapper.getAllMember";
	private static final String MAPPER_METHOD_GET_ONE = Environment.MAPPER_PAKAGE+"MemberMapper.getOneMember";
	
	private String unid;
	private String userName;
	private String userPwd;
	private String userRegTime;
	private String userIsDel;
	public String getUnid() {
		return unid;
	}
	public void setUnid(String unid) {
		this.unid = unid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserRegTime() {
		return userRegTime;
	}
	public void setUserRegTime(String userRegTime) {
		this.userRegTime = userRegTime;
	}
	public String getUserIsDel() {
		return userIsDel;
	}
	public void setUserIsDel(String userIsDel) {
		this.userIsDel = userIsDel;
	}
	@Override
	public String getMapperAllMothod() {
		// TODO Auto-generated method stub
		return MAPPER_METHOD_GET_ALL;
	}
	@Override
	public String getMapperOneMothod() {
		// TODO Auto-generated method stub
		return MAPPER_METHOD_GET_ONE;
	}
	
	
}
