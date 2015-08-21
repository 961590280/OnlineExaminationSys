package com.cw.oes.cache.impl;

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


@Service("dictCache")
public class DictCache implements ICacheService {

	private static Logger logger = Logger.getLogger(DictCache.class);
	@Autowired
	private IJdbcDao jdbcDao;
	
	@Override
	public Map<String, ?> getCacheContext() {
//		String sql="select * from sys_dict_tab where is_valid='Y' order by dict_type,sort";
//		List<Map<String, Object>> list = jdbcDao.queryForList(sql, null);
//		ConcurrentHashMap<String,Map<String, Map<String, Object>>> resultMap=new ConcurrentHashMap<String, Map<String, Map<String, Object>>>();
//		for(Map<String, Object> map : list){
//			String tmpType=MapUtils.getString(map, "DICT_TYPE");
//			if(!resultMap.containsKey(tmpType)){
//				resultMap.put(tmpType, new LinkedHashMap<String, Map<String, Object>>());
//			}
//			String value=MapUtils.getString(map, "DICT_VALUE");
//			resultMap.get(tmpType).put(value, map);
//		}
		logger.debug("加载数据字典表完成");
		return null;
	}


	@Override
	public long getCacheLiveTime() {
		// TODO Auto-generated method stub
		return 0;
	}

}
