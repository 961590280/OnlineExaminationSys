package com.cw.oes.mybatis.model;

public class SysUrlServiceMap extends Model{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String urlFlag;

    private String fullUrl;

    private String privId;

    private String tilte;

    private String serviceCommand;

    private String page;

    private String createrPid;

    private String createTime;

    public String getUrlFlag() {
        return urlFlag;
    }

    public void setUrlFlag(String urlFlag) {
        this.urlFlag = urlFlag == null ? null : urlFlag.trim();
    }

    public String getFullUrl() {
        return fullUrl;
    }

    public void setFullUrl(String fullUrl) {
        this.fullUrl = fullUrl == null ? null : fullUrl.trim();
    }

    public String getPrivId() {
        return privId;
    }

    public void setPrivId(String privId) {
        this.privId = privId == null ? null : privId.trim();
    }

    public String getTilte() {
        return tilte;
    }

    public void setTilte(String tilte) {
        this.tilte = tilte == null ? null : tilte.trim();
    }

    public String getServiceCommand() {
        return serviceCommand;
    }

    public void setServiceCommand(String serviceCommand) {
        this.serviceCommand = serviceCommand == null ? null : serviceCommand.trim();
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page == null ? null : page.trim();
    }

    public String getCreaterPid() {
        return createrPid;
    }

    public void setCreaterPid(String createrPid) {
        this.createrPid = createrPid == null ? null : createrPid.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }
}