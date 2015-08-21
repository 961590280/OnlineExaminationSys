package com.cw.oes.exposer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import com.cw.oes.utils.DateUtil;



/**
 * @author lansb
 * 设置启动参数变量：
 * 设置变量ctxPath为项目根路径
 * 设置变量resRoot为指向静态资源根目录的变量（根据不同的启动时间会有不同的值）--
 */
public class InitPathExposer implements ServletContextAware {
	private ServletContext sc; 

	public String resRoot;

	public void setServletContext(ServletContext arg0) {
		// 实现如下:
		sc = arg0;
	}
	//初始化参数
	public void init() {
		resRoot = "/res-" + DateUtil.getCurrDateStr("yyyyMMddHHmmss");
		sc.setAttribute("ctxPath", sc.getContextPath());
		sc.setAttribute("resRoot", sc.getContextPath() + resRoot);
	}

}
