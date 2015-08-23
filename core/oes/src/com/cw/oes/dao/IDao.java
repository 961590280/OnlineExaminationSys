package com.cw.oes.dao;

import java.util.List;


import java.util.Map;

import com.cw.oes.pojo.Pojo;
import com.cw.oes.pojo.UrlMap;
/**
 * 通用dao类的接口
 * @author CW
 *
 */
public interface IDao {
	
	/**
	 * 根据sqlId判断要执行的sql语句
	 * 执行语句方法
	 * @param sqlId   sql的id
	 * @param sqlType sql的类型
	 * @param params  sql用到的参数
	 * @return        不同类型返回结果不同
	 * @throws Exception
	 */
	public Object queryBySqlId(String sqlId,String sqlType,Map<String,Object> params) throws Exception;
	
	

}
