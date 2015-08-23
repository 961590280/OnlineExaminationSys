package com.cw.oes.pojo;

import java.io.Serializable;
/**
 * 映射result_tab表
 * @author CW
 *
 */
public class TestPaper extends Pojo implements Serializable{
	private String unid;//成绩编号
	private String paper;//会员id
	private String testPaperPid;//考卷id
	private String resultScore;//成绩分数
	private char isPass;//是否通过
	private String judgingPaperTime;//评审时间
	private String beginTime;//开始考试时间
	
	
	
	

	public String getResultNum() {
		return resultNum;
	}

	public void setResultNum(String resultNum) {
		this.resultNum = resultNum;
	}

	public String getUserPid() {
		return userPid;
	}

	public void setUserPid(String userPid) {
		this.userPid = userPid;
	}

	public String getTestPaperPid() {
		return testPaperPid;
	}

	public void setTestPaperPid(String testPaperPid) {
		this.testPaperPid = testPaperPid;
	}

	public String getResultScore() {
		return resultScore;
	}

	public void setResultScore(String resultScore) {
		this.resultScore = resultScore;
	}

	public char getIsPass() {
		return isPass;
	}

	public void setIsPass(char isPass) {
		this.isPass = isPass;
	}

	public String getJudgingPaperTime() {
		return judgingPaperTime;
	}

	public void setJudgingPaperTime(String judgingPaperTime) {
		this.judgingPaperTime = judgingPaperTime;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	@Override
	public String getMapperAllMothod() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getMapperOneMothod() {
		// TODO Auto-generated method stub
		return null;
	}

}
