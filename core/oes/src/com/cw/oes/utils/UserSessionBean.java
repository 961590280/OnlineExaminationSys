package com.cw.oes.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cw.oes.mybatis.model.Examination;
import com.cw.oes.mybatis.model.Member;
import com.cw.oes.mybatis.model.MemberExamLinkKey;
import com.cw.oes.mybatis.model.Paper;
import com.cw.oes.mybatis.model.Topic;

public class UserSessionBean {
	
	/**
	 * 会员
	 */
	private Member member;
	/**
	 * 考卷
	 */
	private Paper paper;
	/**
	 * 试题
	 */
	private List<Topic> topics;
	
	private List<String> answer ;
	
	 /**
	  * 测验
	  */
	private Examination exam;
	/**
	  * 个人测验结果
	  */
	private MemberExamLinkKey memberExamLink;
	/**
	 * 多租户登录名称
	 */
	private String userCode;
	/**
	 * 用户ID
	 */
	private String userId;
	/**
	 * 用户名称
	 */
	private String userName;
	/**
	 * 用户密码
	 */
	private String userPassword;
	/**
	 * 用户其他信息
	 */
	private Map<String, Object> userInfo;
	
	private List<String> userPrivIds;
	
	
	
	public List<String> getAnswer() {
		return answer;
	}
	public void setAnswer(List<String> answer) {
		this.answer = answer;
	}
	public Examination getExam() {
		return exam;
	}
	public void setExam(Examination exam) {
		this.exam = exam;
	}
	public List<Topic> getTopics() {
		return topics;
	}
	public void setTopics(List<Topic> topics) {
		this.topics = topics;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Map<String, Object> getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(Map<String, Object> userInfo) {
		this.userInfo = userInfo;
	}
	public List<String> getUserPrivIds() {
		return userPrivIds;
	}
	public void setUserPrivIds(List<String> userPrivIds) {
		this.userPrivIds = userPrivIds;
	}
	public Paper getPaper() {
		return paper;
	}
	public void setPaper(Paper paper) {
		this.paper = paper;
	}
	public MemberExamLinkKey getMemberExamLink() {
		return memberExamLink;
	}
	public void setMemberExamLink(MemberExamLinkKey memberExamLink) {
		this.memberExamLink = memberExamLink;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
}
