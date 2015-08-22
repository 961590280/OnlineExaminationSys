package com.cw.oes.dao.impl;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
/**
 * 在这里实现mybatis的sqlSessionFactory的单例
 * @author CW
 *
 */
public class DaoHelper {
	private static SqlSessionFactory sqlSessionFactory = null;//私有访问修饰符实现了工厂类的单例
	
	//在静态快中实例化工厂类
	static
	{
		String resource = "mybatis-conf.xml";//这里调用配置文件
		try{
		   //*?*
		   Reader reader = Resources.getResourceAsReader(resource);
		   sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		}catch (IOException e){
		   System.out.println("创建SqlSessionFactory实例失败");
		}
	}
	//获取工厂单例
	public static SqlSessionFactory getSqlSessionFactory()
	 {
	  return sqlSessionFactory;
	 }
	//获取session
	public static SqlSession getSession(){
		
		return sqlSessionFactory.openSession();
	}
}
