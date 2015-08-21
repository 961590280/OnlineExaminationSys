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
			HttpServletResponse response) throws Exception{
		
		
		RequestDataForm requestDataForm = getRequestDataForm(urlFlag, request, response);
		Map<String,Object> urlMap = requestDataForm.getUrlSqlMap();//获取url映射
		String serviceCommand = MapUtils.getString(urlMap, "SERVICE_COMMAND");//获取服务名称（CommonService的方法名）
		String page = (String) urlMap.get("PAGE");//获取要跳转的页面
		Class<? extends CommonService> clazz = commonService.getClass();//获取commonService类
		
		
		if(StringUtils.isNotEmpty(serviceCommand)){//判断是否需要服务
			
			Method method = clazz.getMethod(serviceCommand, requestDataForm.getClass());//获取CommonService类中的方法
			logger.debug("cdbsmCommand=>" + serviceCommand);
			ResponseDataForm responseDataForm = (ResponseDataForm) method.invoke(commonService, requestDataForm);//调用服务
			request.setAttribute("responseDataForm", responseDataForm);
			
			page = responseDataForm.getPage();
			if (StringUtils.isEmpty(page))
				page = (String) urlMap.get("PAGE");
		}
		
		
		return page;
	} 
	
	/**
	 * 处理ajax请求
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping({"/ajax/{id}"})
	 @ResponseBody
	 public Object ajaxCall(@PathVariable String id, HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    ResponseDataForm responseDataForm;
	    RequestDataForm requestDataForm = getRequestDataForm(id, request, response);
	    Map urlSqlMap = requestDataForm.getUrlSqlMap();
	    String service = MapUtils.getString(urlSqlMap, "SERVICE_NAME");
	    requestDataForm.setUrlSqlMap(urlSqlMap);

	    String param = MapUtils.getString(urlSqlMap, "PARAMETERS");
	    if (StringUtils.isNotEmpty(param)) {
	      Map paramsMap = Util.getUrlParam(param);
	      for (Iterator localIterator = paramsMap.entrySet().iterator(); localIterator.hasNext(); ) { Map.Entry entry = (Map.Entry)localIterator.next();
	        requestDataForm.put((String)entry.getKey(), (String)entry.getValue());
	      }

	    }

	    if ((service == null) || ("".equals(service)))
	      service = "ajaxService";
	    try
	    {
	      return ((IService)SpringContextUtil.getBean(service, IService.class)).service(requestDataForm);
	    } catch (Exception e) {
	      e.printStackTrace();
	      responseDataForm = new ResponseDataForm();
	      responseDataForm.setResult("2");
	      responseDataForm.setResultInfo(e.getMessage()); }
	    return responseDataForm;
	  }
	
}
