package com.cw.oes.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.map.CaseInsensitiveMap;
import org.apache.commons.lang.StringUtils;

import com.cw.oes.mybatis.model.SysUrlServiceMap;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.UserSessionBean;
import com.cw.oes.web.httpobjects.HttpRequestObject;
import com.cw.oes.web.utils.RequestUtils;



/**
 * 
 * @author lansb
 *请求信息form
 */
public class RequestDataForm {
	
	/**
	 * 域 <code>MultipleRequestMap</code>
	 * map,请参看HttpRequestObject类定义
	 */
	private CaseInsensitiveMap<String, List<HttpRequestObject>> multipleRequestMap;
	private Map<String,String> params ;
	/**
	 * 域 <code>urlSqlMap</code>
	 */
	private SysUrlServiceMap urlMap;
	//用户session Bean
	private UserSessionBean userSession;
	private HttpServletRequest request;
	private HttpServletResponse response;
	/**
	 * 域 <code>uriId</code>
	 * url的唯一ID
	 */
	private String uriId;
	
	private boolean ajaxRequest;//是否是ajax请求
	
	private RequestDataForm(){
		multipleRequestMap=new CaseInsensitiveMap<String, List<HttpRequestObject>>();
	}
	
	public static RequestDataForm create(HttpServletRequest request) throws Exception{
		return create(request,null);
	}
	
	public static RequestDataForm create(HttpServletRequest request,HttpServletResponse response) throws Exception{
		RequestDataForm rdf=new RequestDataForm();
		rdf.setRequest(request);
		rdf.setResponse(response);
		rdf.setUserSession((UserSessionBean) request.getSession().getAttribute(Environment.SESSION_USER_LOGIN_INFO));
		RequestUtils.getRequestDataForm(rdf);
		return rdf;
	}
	
	public String getUriId() {
		return uriId;
	}
	public void setUriId(String uriId) {
		this.uriId = uriId;
	}
//	
//	public Map<String, Object> getUrlMap() {
//		return urlMap;
//	}
//	
//	public void setUrlMap(Map<String, Object> urlMap) {
//		this.urlMap = urlMap;
//	}
	
	
	public boolean isAjaxRequest() {
		return ajaxRequest;
	}



	public Map<String, String> getParams() {
		return params;
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}

	

	public SysUrlServiceMap getUrlMap() {
		return urlMap;
	}

	public void setUrlMap(SysUrlServiceMap urlMap) {
		this.urlMap = urlMap;
	}

	public void setAjaxRequest(boolean ajaxRequest) {
		this.ajaxRequest = ajaxRequest;
	}
	public UserSessionBean getUserSession() {
		return userSession;
	}
	public void setUserSession(UserSessionBean userSession) {
		this.userSession = userSession;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	public String getString(String key,String def){
		String value=def;
		if(multipleRequestMap!=null && !multipleRequestMap.isEmpty()){
//			CaseInsensitiveMap map=new CaseInsensitiveMap(multipleRequestMap);
			if(multipleRequestMap.containsKey(key)) {
				List<HttpRequestObject> list = multipleRequestMap.get(key);
				if(list!=null && !list.isEmpty()){
					try {
						value=new String(list.get(0).getValue(),Environment.ENCODING);
						value=value.trim();
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return value;
	}

	public String getString(String key){
		return getString(key,"");
	}
	
	public Integer getInteger(String key,Integer def){
		Double d=getDouble(key);
		if(d==null){
			return def;
		}
		return d.intValue();
	}
	
	public Integer getInteger(String key){
		return getInteger(key,null);
	}
	
	public Double getDouble(String key,Double def){
		String str=getString(key);
		if(StringUtils.isEmpty(str)){
			return def;
		}
		Double value=def;
		try{
			value=Double.valueOf(str);
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	
	public Double getDouble(String key){
		return getDouble(key,null);
	}
	
	public List<String> getStringList(String key){
		ArrayList<String> arr=new ArrayList<String>();
		if(multipleRequestMap!=null && !multipleRequestMap.isEmpty()){
			if(multipleRequestMap.containsKey(key)) {
				List<HttpRequestObject> list = multipleRequestMap.get(key);
				if(list!=null && !list.isEmpty()){
					for(HttpRequestObject hro:list){
						try {
							arr.add(new String(hro.getValue(),Environment.ENCODING));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return arr;
	}
	
	public byte[] getByte(String key){
		byte[] b=null;
		if(multipleRequestMap!=null && !multipleRequestMap.isEmpty()){
			if(multipleRequestMap.containsKey(key)) {
				List<HttpRequestObject> list = multipleRequestMap.get(key);
				if(list!=null && !list.isEmpty()){
					b=list.get(0).getValue();
				}
			}
		}
		return b;
	}
	
	public void setParamMap(Map<String,String> param){
		if(multipleRequestMap==null){
			multipleRequestMap=new CaseInsensitiveMap<String, List<HttpRequestObject>>();
		}
		for(Map.Entry<String, String> entry:param.entrySet()){
			HttpRequestObject hro = new HttpRequestObject();
			hro.setName(entry.getKey());
			hro.setParamType("param");
			try {
				hro.setValue(entry.getValue().getBytes(Environment.ENCODING));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			List<HttpRequestObject> list = new LinkedList<HttpRequestObject>();
			list.add(hro);
			multipleRequestMap.put(entry.getKey(), list);
		}
	}
	
	public void putString(String key,String value){
		HttpRequestObject hro = new HttpRequestObject();
		hro.setName(key);
		hro.setParamType("param");
		try {
			value=null == value ? "" : value;
			hro.setValue(value.getBytes(Environment.ENCODING));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<HttpRequestObject> list = new LinkedList<HttpRequestObject>();
		list.add(hro);
		multipleRequestMap.put(key, list);
	}
	
	public void put(String key,List<HttpRequestObject> list){
		if(multipleRequestMap==null){
			multipleRequestMap=new CaseInsensitiveMap<String, List<HttpRequestObject>>();
		}
		if(multipleRequestMap.containsKey(key)){
			multipleRequestMap.get(key).addAll(list);
		}else{
			multipleRequestMap.put(key, list);
		}
	}
	
	public void put(String key,String value){
		this.putString(key,value);
	}
	
	public void remove(String key){
		multipleRequestMap.remove(key);
	}
	
	public HttpRequestObject get(String key){
		HttpRequestObject hro=null;
		List<HttpRequestObject> list = this.multipleRequestMap.get(key);
		if(list!=null && !list.isEmpty()){
			hro=list.get(0);
		}else{
			hro=new HttpRequestObject();
			hro.setFilename("");
			hro.setName(key);
			hro.setParamType("param");
			hro.setValue("".getBytes());
		}
		return hro;
	}

}
