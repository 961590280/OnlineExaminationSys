package com.cw.oes.model.impl;

import java.util.List;

/**
 * 测验试卷model
 * @author CW
 *
 */
public class ExamPaperModel {
	private String uuid;
	private String paperTitle;//试卷名称
	private List<TopicModel> topics;//题目集合
	
	
	
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getPaperTitle() {
		return paperTitle;
	}
	public void setPaperTitle(String paperTitle) {
		this.paperTitle = paperTitle;
	}
	public List<TopicModel> getTopics() {
		return topics;
	}
	public void setTopics(List<TopicModel> topics) {
		this.topics = topics;
	}
	
	
	
}
