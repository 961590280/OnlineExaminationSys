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



@Service("urlMappingCache")
public class UrlMappingCache implements ICacheService {

	@Resource
	private IJdbcDao jdbcDao;
	
	@Autowired(required=false)
	@Qualifier("sysCode")
	private String sysCode;
	
	@Override
	public Map<String, Object> getCacheContext() {
		String sql="select * from sys_url_map_tab ";
		Object[] params=null;
		
		List<Map<String, Object>> list = jdbcDao.queryForList(sql, params);
		ConcurrentHashMap<String,Object> resultMap=new ConcurrentHashMap<String, Object>();
		for(Map<String,Object> map : list){
			//注意从数据库获取的是为大写
			String flag=String.valueOf(map.get("URL_FLAG"));
			resultMap.put(flag,map);
		}
		return resultMap;
	}

	@Override
	public long getCacheLiveTime() {
		return 0;
	}

}
