package com.cw.oes.dao.impl;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Repository;

import com.cw.oes.dao.IUrlMapDao;
import com.cw.oes.pojo.UrlMap;


@Repository("dao")
public class UrlMapDaoImpl implements IUrlMapDao {

	
	
	
	
	@Override
	public List<UrlMap> getAllUrlMap() {
		// TODO Auto-generated method stub
		
		SqlSession session = DaoHelper.getSession();
		List<UrlMap> urlMaps = null;
		try{
			urlMaps = session.selectList("com.cw.oes.dao.mapping.SysUrlMapMapper.getAllUrlMap");
		}finally{
			session.close();
		}
		
		System.out.println(urlMaps);
		return urlMaps;
	}

	@Override
	public void execUrlMap() {
		// TODO Auto-generated method stub

	}

}
