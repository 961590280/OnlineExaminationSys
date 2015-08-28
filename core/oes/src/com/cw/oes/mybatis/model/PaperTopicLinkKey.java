package com.cw.oes.mybatis.model;

public class PaperTopicLinkKey extends Model{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String paperPid;

    private String topicPid;
    private int sort;

    public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getPaperPid() {
        return paperPid;
    }

    public void setPaperPid(String paperPid) {
        this.paperPid = paperPid == null ? null : paperPid.trim();
    }

    public String getTopicPid() {
        return topicPid;
    }

    public void setTopicPid(String topicPid) {
        this.topicPid = topicPid == null ? null : topicPid.trim();
    }
}