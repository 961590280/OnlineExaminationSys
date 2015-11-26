package com.cw.oes.model.impl;

import java.util.List;
/**
 * 题目model
 * @author CW
 *
 */
public class TopicModel {
	private String uuid;
	private String topicTitle;//题目
	private String correctAnswer;//正确答案序号
	private List<String> options;//选项列表
	
	
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getTopicTitle() {
		return topicTitle;
	}
	public void setTopicTitle(String topicTitle) {
		this.topicTitle = topicTitle;
	}
	public String getCorrectAnswer() {
		return correctAnswer;
	}
	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}
	public List<String> getOptions() {
		return options;
	}
	public void setOptions(List<String> options) {
		this.options = options;
	}
	
	
}
