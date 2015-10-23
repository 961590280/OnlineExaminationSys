package com.cw.oes.mybatis.model;

public class TagOtherLinkKey {
    private String tagPid;

    private String other;

    public String getTagPid() {
        return tagPid;
    }

    public void setTagPid(String tagPid) {
        this.tagPid = tagPid == null ? null : tagPid.trim();
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other == null ? null : other.trim();
    }
}