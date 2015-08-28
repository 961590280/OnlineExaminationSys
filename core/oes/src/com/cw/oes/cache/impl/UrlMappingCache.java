package com.cw.oes.cache.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;












import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cw.oes.cache.ICacheService;
import com.cw.oes.dao.IJdbcDao;
import com.cw.oes.dao.IUrlMapDao;
import com.cw.oes.dao.impl.DaoHelper;
import com.cw.oes.dao.impl.MybatisDaoImpl;
import com.cw.oes.mybatis.dao.SysUrlServiceMapMapper;
import com.cw.oes.mybatis.model.SysUrlServiceMap;
import com.cw.oes.pojo.Pojo;
import com.cw.oes.pojo.UrlMap;



@Service("urlMappingCache")
public class UrlMappingCache implements ICacheService {


	@Autowired(required=false)
	@Qualifier("sysCode")
	private String sysCode;
	@Autowired
	private MybatisDaoImpl myDao;
	
	@Override
	public Map<String, Object> getCacheContext() {
		ConcurrentHashMap<String,Object> resultMap=new ConcurrentHashMap<String, Object>();
		SqlSession session = DaoHelper.getSession();
		List<SysUrlServiceMap> list;
		try {
			SysUrlServiceMapMapper mapper = session.getMapper(SysUrlServiceMapMapper.class);
			list = mapper.selectAll();
			for(SysUrlServiceMap map : list){
				String flag = String.valueOf(map.getUrlFlag());
				resultMap.put(flag, map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			session.close();
		}
		
		
		return resultMap;
	}

	@Override
	public long getCacheLiveTime() {
		return 0;
	}

}
