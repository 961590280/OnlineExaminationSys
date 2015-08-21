package com.cw.oes.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.cache.impl.UrlMappingCache;
import com.cw.oes.exception.CustomException;
import com.cw.oes.form.RequestDataForm;

/**
 * 
 * @author weimingfj
 *
 */
public abstract class BaseController {
	protected static Logger logger = Logger.getLogger(BaseController.class);
	
	/**
	 * 通过传入url的标识还有request和response获取 <code>RequestDataForm</code>
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	protected RequestDataForm getRequestDataForm(String urlFlag,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("***************************");
		logger.debug("enter topic");
		logger.debug("***************************");
		// 权限
		// 查找对应的URL处理参数
//		Map<String, Object> urlSqlMap = jdbcDao.queryForMap(
//				"select * from sys_url_tab t where t.url_id=?",
//				new Object[] { id });
		Map<String, Object> urlSqlMap = null;
		//根据UrlMappingCache类从全局缓存中去出对应的UrlMappingCache缓存（缓存为Map类型）
		Map<String, Object> urlCache = GlobalCache.getCache(UrlMappingCache.class, Map.class);
		//若url标识不存缓存中在则抛出异常
		if (!urlCache.containsKey(urlFlag)) {
			throw new CustomException(
					"error! url["+urlFlag+"] undefined");
		}else{
			//
			urlSqlMap=(Map<String, Object>) urlCache.get(urlFlag);
		}
		
		RequestDataForm requestDataForm = RequestDataForm.create(request,response);
		requestDataForm.setUriId(urlFlag);
		requestDataForm.setUrlSqlMap(urlSqlMap);  
		requestDataForm.setResponse(response);
		requestDataForm.setRequest(request);
		return requestDataForm;
	}
}
