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
@RequestMapping("/")
public class IndexController extends BaseController{
	
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
			
			
		
			return "index";
	
	} 
	

	
	  
	
}
