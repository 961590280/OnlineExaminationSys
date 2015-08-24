package com.cw.oes.pojo;

import java.io.Serializable;
/**
 * 映射result_tab表
 * @author CW
 *
 */
public class TestPaper extends Pojo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String unid;//成绩编号
	private String paperTitle;//标题
	private String paperType;//考卷类型
	private String paperSerialNum;//考卷编号
	private int paperQuestionNum;//考题总数
	private int paperTotalPoint;//总分
	private String paperDifficulty;//开始考试时间
	private int paperFinishedTime;//考试所需时间
	private String paperEditTime;//考卷最近修改时间
	private String paperCreateTime;//考卷生成时间
	public String getUnid() {
		return unid;
	}
	public void setUnid(String unid) {
		this.unid = unid;
	}
	public String getPaperTitle() {
		return paperTitle;
	}
	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}
	public String getPaperType() {
		return paperType;
	}
	public void setPaperType(String paperType) {
		this.paperType = paperType;
	}
	public String getPaperSerialNum() {
		return paperSerialNum;
	}
	public void setPaperSerialNum(String paperSerialNum) {
		this.paperSerialNum = paperSerialNum;
	}
	public int getPaperQuestionNum() {
		return paperQuestionNum;
	}
	public void setPaperQuestionNum(int paperQuestionNum) {
		this.paperQuestionNum = paperQuestionNum;
	}
	public int getPaperTotalPoint() {
		return paperTotalPoint;
	}
	public void setPaperTotalPoint(int paperTotalPoint) {
		this.paperTotalPoint = paperTotalPoint;
	}
	public String getPaperDifficulty() {
		return paperDifficulty;
	}
	public void setPaperDifficulty(String paperDifficulty) {
		this.paperDifficulty = paperDifficulty;
	}
	public int getPaperFinishedTime() {
		return paperFinishedTime;
	}
	public void setPaperFinishedTime(int paperFinishedTime) {
		this.paperFinishedTime = paperFinishedTime;
	}
	public String getPaperEditTime() {
		return paperEditTime;
	}
	public void setPaperEditTime(String paperEditTime) {
		this.paperEditTime = paperEditTime;
	}
	public String getPaperCreateTime() {
		return paperCreateTime;
	}
	public void setPaperCreateTime(String paperCreateTime) {
		this.paperCreateTime = paperCreateTime;
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
