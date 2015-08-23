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
@Repository("myDao")
public class MybatisDaoImpl implements IDao {
	
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
	//public static final MybatisDaoImpl<UrlMap> UrlMap_DAO = new MybatisDaoImpl<UrlMap>(new UrlMap());
	//public static final MybatisDaoImpl<Member> Member_DAO = new MybatisDaoImpl<Member>(new Member());
	
	
	@Override
	public Object queryBySqlId(String sqlId, String type,Map<String, Object> params) throws Exception{
		SqlSession session = DaoHelper.getSession();
		
		Object result = null;
		try{
		
			
			if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT)){
				
				throw new SqlTypeIllegalException();//未实现
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT_MAP)){
				throw new SqlTypeIllegalException();//未实现
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT_ONE)){//查询单个记录
				result =  session.selectOne(Environment.MAPPER_PAKAGE+sqlId,params);
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_SELECT_LIST)){//查询一组记录
				
				result = session.selectList(Environment.MAPPER_PAKAGE+sqlId,params);
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_UPDATE)){//更新
				
				result = session.selectOne(Environment.MAPPER_PAKAGE+sqlId,params);
				session.commit();
					
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_DELETE)){//删除
			
				result = session.delete(Environment.MAPPER_PAKAGE+sqlId,params);
				session.commit();
				
			}else if(StringUtils.endsWithIgnoreCase(type, SQL_TYPE_INSERT)){//插入
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

}
