package com.cw.oes.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cw.oes.dao.IDao;
import com.cw.oes.exception.SqlTypeIllegalException;
import com.cw.oes.pojo.Member;
import com.cw.oes.pojo.Pojo;
import com.cw.oes.pojo.UrlMap;
import com.cw.oes.utils.Environment;


/**
 * 通过创建dao对象时传入pojo对象作为参数
 * 确定dao是哪个pojo对象服务
 * @author CW
 *
 * @param <T>
 */
public class MybatisDaoImpl<T extends Pojo> implements IDao {
	private T t;
	//sql语句的类型名称静态常量
	private static final String SQL_TYPE_SELECT = "S";
	private static final String SQL_TYPE_SELECT_LIST = "SL";
	private static final String SQL_TYPE_SELECT_MAP = "SM";
	private static final String SQL_TYPE_SELECT_ONE = "SO";
	private static final String SQL_TYPE_DELETE = "D";
	private static final String SQL_TYPE_UPDATE = "U";
	private static final String SQL_TYPE_INSERT = "I";
	
	//对应每个pojo的dao实例的静态常量
	/**
	 * UrlMap的dao
	 */
	public static final MybatisDaoImpl<UrlMap> UrlMap_DAO = new MybatisDaoImpl<UrlMap>(new UrlMap());
	public static final MybatisDaoImpl<Member> Member_DAO = new MybatisDaoImpl<Member>(new Member());
	
	
	private MybatisDaoImpl(T t) {
		this.t = t;
	}
	
	
	@Override
	public List<T> getAllBeanList() {
		SqlSession session = DaoHelper.getSession();
		List<T> beans = null;
		try{
			beans = session.selectList(t.getMapperAllMothod());
		}finally{
			session.close();
		}
		return  beans;
	}

	@Override
	public List<T> getBeanByWhere(Map<String,Object> params) {
		SqlSession session = DaoHelper.getSession();
		List<T> beans = null;
		try{
			beans = session.selectList(t.getMapperAllMothod(),params);
		}finally{
			session.close();
		}
		return  beans;
	}

	@Override
	public void exec() {
		// TODO Auto-generated method stub

	}
	
	@Override
	public Object queryBySqlId(String sqlId, String type,Map<String, Object> params) throws Exception{
		SqlSession session = DaoHelper.getSession();
		
		Object result = null;
		try{
		
			
			if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT)){
				
				throw new SqlTypeIllegalException();//未实现
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT_MAP)){
				throw new SqlTypeIllegalException();//未实现
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT_LIST)){
				result = session.selectList(t.getMapperAllMothod(),params);//返回
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_UPDATE)){
				try{
					result = session.selectOne(Environment.MAPPER_PAKAGE+sqlId,params);
					session.commit();
					
				}catch(Exception e){
					result = 0;
				}
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_DELETE)){
				try{
					result = session.delete(Environment.MAPPER_PAKAGE+sqlId,params);
					session.commit();
					
				}catch(Exception e){
					result = 0;
				}
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_INSERT)){
				try{
					result = session.update(Environment.MAPPER_PAKAGE+sqlId,params);
					session.commit();
					
				}catch(Exception e){
					result = 0;
				}
			}else{
				
				throw new SqlTypeIllegalException();
			}
			
			
			
		}finally{
			session.close();
		}
		return  result;
	}

	@Override
	public T getBeanById(String unid) {
		SqlSession session = DaoHelper.getSession();
		T bean = null;
		try{
			bean = session.selectOne(t.getMapperOneMothod(),unid);
		}finally{
			session.close();
		}
		return  bean;
	}

}
