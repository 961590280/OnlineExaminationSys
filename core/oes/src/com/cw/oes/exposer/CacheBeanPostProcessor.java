package com.cw.oes.exposer;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.cache.ICacheService;

public class CacheBeanPostProcessor implements BeanPostProcessor {

	@Override
	public Object postProcessAfterInitialization(Object arg0, String arg1)
			throws BeansException {
		// TODO Auto-generated method stub
		return arg0;
	}
	/**
	 * BeanPostProcessor接口的方法--
	 */
	@Override
	public Object postProcessBeforeInitialization(Object obj, String arg1)
			throws BeansException {
		//如果加载完的bean是继承ICacheService接口的类则执行
		if(obj instanceof ICacheService){
			ICacheService cs = (ICacheService)obj;
			GlobalCache.setCache(arg1, cs.getCacheContext(),cs.getCacheLiveTime());
		}
		return obj;
	}


}
