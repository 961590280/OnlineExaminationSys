package com.cw.oes.pojo;

import java.io.Serializable;

import com.cw.oes.utils.Environment;

public class UrlMap extends Pojo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String MAPPER_METHOD_GET_ALL = Environment.MAPPER_PAKAGE+"SysUrlMapMapper.getAllUrlMap";
	private static final String MAPPER_METHOD_GET_ONE = Environment.MAPPER_PAKAGE+"SysUrlMapMapper.getOneUrlMap";
	
	
	private String unid;
	private	String urlFlag;
	private String fullUrl;
	private String privId;
	private String title;
	private String serviceCommand;
	private String page;
	private String createTime;
	private String sqlId;
	private String validationId;
	private String sqlType;
	
	
	public String getSqlType() {
		return sqlType;
	}
	public void setSqlType(String sqlType) {
		this.sqlType = sqlType;
	}
	public String getUnid() {
		return unid;
	}
	public void setUnid(String unid) {
		this.unid = unid;
	}
	public String getUrlFlag() {
		return urlFlag;
	}
	public void setUrlFlag(String urlFlag) {
		this.urlFlag = urlFlag;
	}
	
	public String getPrivId() {
		return privId;
	}
	public void setPrivId(String privId) {
		this.privId = privId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getServiceCommand() {
		return serviceCommand;
	}
	public void setServiceCommand(String serviceCommand) {
		this.serviceCommand = serviceCommand;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	
	public String getFullUrl() {
		return fullUrl;
	}
	public void setFullUrl(String fullUrl) {
		this.fullUrl = fullUrl;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getSqlId() {
		return sqlId;
	}
	public void setSqlId(String sqlId) {
		this.sqlId = sqlId;
	}
	public String getValidationId() {
		return validationId;
	}
	public void setValidationId(String validationId) {
		this.validationId = validationId;
	}
	@Override
	public String getMapperAllMothod() {
		// TODO Auto-generated method stub
		return MAPPER_METHOD_GET_ALL;
	}
	@Override
	public String getMapperOneMothod() {
		// TODO Auto-generated method stub
		return MAPPER_METHOD_GET_ONE;
	}

	
	

}
