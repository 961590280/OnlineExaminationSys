package com.cw.oes.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.cw.oes.dao.impl.MybatisDaoImpl;
import com.cw.oes.pojo.Member;
import com.cw.oes.pojo.UrlMap;

public class DaoTest {
	public static void main(String[] args) throws Exception {
//		MybatisDaoImpl<Member> mDao = new MybatisDaoImpl<Member>(new Member());
//		List<Member> members =  mDao.getAllBeanList();
//		System.out.println(members.get(0).getUserName());
//		
		
//		MybatisDaoImpl<UrlMap> uDao = new MybatisDaoImpl<UrlMap>(new UrlMap());
//		Map<String,Object> params =new HashMap<String, Object>();
//		params.put("userName","admin");
//		List<UrlMap> urls =  uDao.getBeanByWhere(params);
//		System.out.println(urls);
		
//		UrlMap urlMap = MybatisDaoImpl.UrlMap_DAO.getBeanById("1");
//		System.out.println(urlMap.getUrlFlag());
//		
//		Member member = MybatisDaoImpl.Member_DAO.getBeanById("1");
//		System.out.println(member.getUserName());
//		Map<String,Object> params =new HashMap<String, Object>();
//		params.put("unid", UUID.randomUUID());
//		params.put("urlFlag", "test");
//		params.put("fullUrl", "test");
//		params.put("privId", "test");
//		//params.put("title", "test");
//		params.put("serviceCommand", "test");
//		params.put("page", "test");
//		params.put("createrId", "test");
//		params.put("sqlId", "test");
//		params.put("validation", "test");
//		params.put("sqlType", "test");
//		
//		int r = (Integer) MybatisDaoImpl.UrlMap_DAO.queryBySqlId("SysUrlMapMapper.addUrlMap", "I", params);
//		System.out.println(r);
		
//		Member member = MybatisDaoImpl.Member_DAO.getBeanById("1");
//		System.out.println(member.getUserName());
//		Map<String,Object> params =new HashMap<String, Object>();
//		params.put("unid", "7e4c99dc-4a94-4e64-8a32-cd493b9b6ed");
//		params.put("urlFlag", "test11");
//		params.put("fullUrl", "test");
//		params.put("privId", "test1");
//		params.put("title", "test1");
//		params.put("serviceCommand", "test1");
//		params.put("page", "test");
//		params.put("createrId", "test");
//		params.put("sqlId", "test");
//		params.put("validation", "test");
//		params.put("sqlType", "test");
//		
//		int r = (Integer) MybatisDaoImpl.UrlMap_DAO.queryBySqlId("SysUrlMapMapper.updateUrlMap", "U", params);
//		System.out.println(r);
//		Map<String,Object> params =new HashMap<String, Object>();
//		params.put("unid", "6");
//		int r = (Integer) MybatisDaoImpl.UrlMap_DAO.queryBySqlId("SysUrlMapMapper.deleteUrlMap", "D", params);
//		System.out.println(r);
		String r ="1111+222";
		char[] arr = r.toCharArray();
		StringBuffer[] strArr = new StringBuffer[r.length()];
		int i = 0;
		strArr[i] = new StringBuffer();
		for(char temp : arr ){
		
			if(temp != '+'){
				strArr[i].append(temp);
			}else{
				
				strArr[++i] = new StringBuffer();
				
			}
			
		}
		for(StringBuffer sb : strArr){
			System.out.println(sb==null?"":sb);
			
		}
	}
}
