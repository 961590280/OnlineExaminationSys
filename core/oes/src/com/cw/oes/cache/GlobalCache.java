package com.cw.oes.cache;

import java.lang.annotation.Annotation;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import net.sf.ehcache.config.CacheConfiguration;
import net.sf.ehcache.config.PersistenceConfiguration;
import net.sf.ehcache.config.PersistenceConfiguration.Strategy;
import net.sf.ehcache.store.MemoryStoreEvictionPolicy;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import com.cw.oes.controller.BaseController;
import com.cw.oes.listener.SpringContextUtil;
/**
 * 
 * @author weimingfj
 *
 */
public class GlobalCache {
	protected static Logger logger = Logger.getLogger(GlobalCache.class);
	
	
	private static CacheManager manage=CacheManager.create();
	
	public static void setCache(String tag,Object obj,long liveTime){
		logger.debug("***************************");
		logger.debug("enter setCache");
		logger.debug("***************************");
		Cache cache=createCache(tag,liveTime);
		manage.addCache(cache);//要先加到CacheManager中否则提示cache is not alive
		Element e=new Element(tag, obj);
		cache.put(e);
	}
	
	//创建缓存
	private static Cache createCache(String tag,long liveTime){
		logger.debug("***************************");
		logger.debug("enter createCache");
		logger.debug("***************************");
		//设置缓存的配置
		CacheConfiguration config=new CacheConfiguration(tag, 20000)
//		.eternal(true)//缓存是否永远不销毁
		.maxEntriesLocalDisk(0)
		.persistence(new PersistenceConfiguration().strategy(Strategy.LOCALTEMPSWAP))
//		.overflowToDisk(false)//当缓存中的数据达到最大值时，是否把缓存数据写入磁盘
		.memoryStoreEvictionPolicy(MemoryStoreEvictionPolicy.LFU);
		if(liveTime>0){
			config.setEternal(false);
			config.setTimeToLiveSeconds(liveTime);
		}else{
			config.setEternal(true);
		}
		return new Cache(config);
	}
	//获取CacheManager中的Cache
	public static Object getCache(Class<?> clazz){
		logger.debug("***************************");
		logger.debug("enter getCache (clazz)");
		logger.debug("***************************");
		Annotation anno=clazz.getAnnotation(Service.class);
		if(anno==null){
			return null;
		}else{
			String tag=((Service)anno).value();
			Cache cache = manage.getCache(tag);
			Object obj=null;
			if(cache!=null){
				if(cache.get(tag)==null){
					try {
						ICacheService i = SpringContextUtil.getBean(tag,ICacheService.class);
						Element e=new Element(tag, i.getCacheContext());
						cache.put(e);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				Element element = cache.get(tag);
				obj=element.getObjectValue();
				
			}
			return obj;
		}
	}
	
	/**
	 * 获取缓存
	 * @param cacheClass 缓存类
	 * @param retultType 返回对象的类型
	 * @return
	 */
	public static <A,T>T getCache(Class<A> cacheClass,Class<T> retrunType){
		logger.debug("***************************");
		logger.debug("enter getCache(cacjeClass,retu)");
		logger.debug("***************************");
		Object obj=getCache(cacheClass);
		return retrunType.cast(obj);
	}
	
	/**
	 * 刷新所有缓存
	 * @param ctx
	 */
	public static void refreshAllCache(WebApplicationContext ctx){
		logger.debug("***************************");
		logger.debug("enter refreshAllCache");
		logger.debug("***************************");
		
		for(String name :manage.getCacheNames()){
			long liveTime = manage.getCache(name).getCacheConfiguration().getTimeToLiveSeconds();
			manage.removeCache(name);
			ICacheService cs = (ICacheService)ctx.getBean(name);
			setCache(name, cs.getCacheContext(),liveTime);
		}
	}
	
	public static void refreshCache(Class<?> clazz){
		logger.debug("***************************");
		logger.debug("enter refreshCache");
		logger.debug("***************************");
		Annotation anno=clazz.getAnnotation(Service.class);
		if(anno!=null){
			String tag=((Service)anno).value();
			ICacheService cs = SpringContextUtil.getBean(tag,ICacheService.class);
			Element e=new Element(tag, cs.getCacheContext());
			Cache cache = manage.getCache(tag);
			if(cache.get(tag)==null){
				cache.put(e);
			}else{
				cache.replace(e);
			}
		}
	}
	
	public static String[] getCacheNames(){
		return manage.getCacheNames();
	}
}
