package com.cw.oes.controller;

import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseData;
import com.cw.oes.form.ResponseDataForm;
import com.cw.oes.listener.SpringContextUtil;
import com.cw.oes.mybatis.model.SysUrlServiceMap;
import com.cw.oes.pojo.UrlMap;
import com.cw.oes.service.IService;
import com.cw.oes.service.impl.CommonService;
import com.cw.oes.utils.MapUtils;
import com.cw.oes.utils.Util;

/**
 * 控制层实现。
 * 包含处理非ajax请求，ajax请求的两个通用方法
 * @author 陈威
 *
 */
@Controller
@RequestMapping("/common")
public class CommonController extends BaseController{
	
	@Resource
	private CommonService commonService;
	
	
	/**
	 * 处理非ajax请求
	 * @param urlFlag url标识
	 * @param request
	 * @param response
	 * @return 如果业务正确返回String,跳转到指定页面。否则返回ResponData。
	 * @throws Exception
	 */
	@RequestMapping("{urlFlag}")
	public Object common(@PathVariable String urlFlag, HttpServletRequest request,
			HttpServletResponse response) {
		System.getProperty("catalina.home"); 
		
		RequestDataForm requestDataForm;
		try {
			requestDataForm = getRequestDataForm(urlFlag, request, response);
			
			SysUrlServiceMap urlMap = requestDataForm.getUrlMap();//获取url映射
			String serviceCommand = urlMap.getServiceCommand();
			String page = urlMap.getPage();
			
			
			if(StringUtils.isNotEmpty(serviceCommand)){//判断是否需要服务方法
				Class<? extends CommonService> clazz = commonService.getClass();
				Method method = clazz.getMethod(serviceCommand, requestDataForm.getClass());
				logger.debug("cdbsmCommand=>" + serviceCommand);
				ResponseDataForm responseDataForm = (ResponseDataForm) method.invoke(commonService, requestDataForm);//调用服务
				request.setAttribute("responseDataForm", responseDataForm);
				page = responseDataForm.getPage();
				if (StringUtils.isEmpty(page))
					page = urlMap.getPage();
				
			}
			
			return page;
		} catch (Exception e) {
			
			e.printStackTrace();
			logger.error(e,e.fillInStackTrace());
			return "index";
		}
	} 
	
	/**
	 * 处理ajax请求
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping({"/ajax/{urlFlag}"})
	 @ResponseBody
	 public Object ajaxCall(@PathVariable String urlFlag, HttpServletRequest request, HttpServletResponse response)
	    throws Exception{
		 
		 RequestDataForm requestDataForm = getRequestDataForm(urlFlag, request, response);
		 ResponseDataForm responseDataForm = null;
		 try{
			SysUrlServiceMap urlMap = requestDataForm.getUrlMap();
			String serviceCommand = urlMap.getServiceCommand();
			Class<? extends CommonService> clazz = commonService.getClass();//获取commonService类
			Method method = clazz.getMethod(serviceCommand, requestDataForm.getClass());//获取CommonService类中的方法
			logger.debug("cdbsmCommand=>" + serviceCommand);
			responseDataForm = (ResponseDataForm) method.invoke(commonService, requestDataForm);
		 }catch (Exception e){
			logger.error(e,e.fillInStackTrace());
			System.out.println(e);
		 }
		 return responseDataForm;//调用服务
	
	  }
	
}
