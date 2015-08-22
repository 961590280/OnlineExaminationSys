package com.cw.oes.cache.impl;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cw.oes.cache.ICacheService;
import com.cw.oes.dao.IJdbcDao;
import com.cw.oes.dao.IUrlMapDao;
import com.cw.oes.pojo.UrlMap;



@Service("urlMappingCache")
public class UrlMappingCache implements ICacheService {

	@Resource
	private IJdbcDao jdbcDao;
	@Resource
	private IUrlMapDao dao;
	
	@Autowired(required=false)
	@Qualifier("sysCode")
	private String sysCode;
	
	@Override
	public Map<String, Object> getCacheContext() {
		ConcurrentHashMap<String,Object> resultMap=new ConcurrentHashMap<String, Object>();
		List<UrlMap> list = dao.getAllUrlMap();
		for(UrlMap map : list){
			String flag = String.valueOf(map.getUrlFlag());
			resultMap.put(flag, map);
			
		}
		
		return resultMap;
	}

	@Override
	public long getCacheLiveTime() {
		return 0;
	}

}
