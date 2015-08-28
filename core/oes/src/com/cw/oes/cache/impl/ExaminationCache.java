package com.cw.oes.cache.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.collections4.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cw.oes.cache.ICacheService;
import com.cw.oes.dao.IJdbcDao;


@Service("examinationCache")
public class ExaminationCache implements ICacheService {

	private static Logger logger = Logger.getLogger(ExaminationCache.class);

	
	@Override
	public Map<String, ?> getCacheContext() {
		
		
		return new HashMap<String, Object>();
	}


	@Override
	public long getCacheLiveTime() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public void setCacheContext(){
		
		
	}

}
