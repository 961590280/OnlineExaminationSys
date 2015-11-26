package com.cw.oes.model.impl;

import java.util.List;
import java.util.Map;

/**
 * 个人测验记录model
 * @author CW
 *
 */
public class PersonalExamRecordModel {
	private String uuid;
	private String examTitle;//测验名称
	private ExamPaperModel examPaper;//测验试卷
	private Map<String,String> answers;//答案
	private String date;//测验日期
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getExamTitle() {
		return examTitle;
	}
	public void setExamTitle(String examTitle) {
		this.examTitle = examTitle;
	}
	public ExamPaperModel getExamPaper() {
		return examPaper;
	}
	public void setExamPaper(ExamPaperModel examPaper) {
		this.examPaper = examPaper;
	}
	public Map<String,String> getAnswers() {
		return answers;
	}
	public void setAnswers(Map<String,String> answers) {
		this.answers = answers;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}
