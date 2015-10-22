package com.cw.oes.mybatis.model;

public class CollectionKey {
    private String userPid;

    private String collectorPid;

    private String collectionType;

    public String getUserPid() {
        return userPid;
    }

    public void setUserPid(String userPid) {
        this.userPid = userPid == null ? null : userPid.trim();
    }

    public String getCollectorPid() {
        return collectorPid;
    }

    public void setCollectorPid(String collectorPid) {
        this.collectorPid = collectorPid == null ? null : collectorPid.trim();
    }

    public String getCollectionType() {
        return collectionType;
    }

    public void setCollectionType(String collectionType) {
        this.collectionType = collectionType == null ? null : collectionType.trim();
    }
}