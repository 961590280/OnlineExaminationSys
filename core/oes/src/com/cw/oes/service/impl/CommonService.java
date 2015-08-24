package com.cw.oes.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.dao.IDao;
import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseData;
import com.cw.oes.form.ResponseDataForm;
import com.cw.oes.pojo.Member;
import com.cw.oes.pojo.Result;
import com.cw.oes.pojo.TestPaper;
import com.cw.oes.pojo.UrlMap;
import com.cw.oes.service.IService;
import com.cw.oes.utils.DateUtil;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.MapUtils;
import com.cw.oes.utils.UserSessionBean;

/**
 * 业务层实现
 * @author 陈威
 *
 */
@Service("commonService")
public class CommonService implements IService{

	@Autowired
	private IDao myDao;
	/**
	 *用户登录
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm userLogin(RequestDataForm requestDataForm)
			throws Exception {
		
		ResponseDataForm rdf = new ResponseDataForm();
		//用getString方法直接有参数名获取参数的值
		String userName = requestDataForm.getString("userCode");// 密码
		String userPwd = requestDataForm.getString("userPwd");// 密码
		UrlMap urlMap = requestDataForm.getUrlMap();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userCode", userName);
		
		Member member = (Member) myDao.queryBySqlId(urlMap.getSqlId(), urlMap.getSqlType(), params);
		if(member != null && userPwd.equals(member.getUserPwd())){
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultInfo("登录成功");
			//设置session
			UserSessionBean session = new UserSessionBean();
			session.setUserId(member.getUnid());
			session.setUserCode(member.getUserName());
			requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, session);
			
		}else{
			
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("账号或密码不正确");
			rdf.setPage("oes/login");
			
		}
		
		return rdf;
	}
	/**
	 * 刷新缓存
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm refreshCache(RequestDataForm requestDataForm)
			throws Exception {

		ResponseDataForm rdf = new ResponseDataForm();
		HashMap<String, String> map=new HashMap<String, String>();
		String cacheName=requestDataForm.getString("cacheName");	
		try{
			Class<?> clazz=Class.forName(cacheName);
			GlobalCache.refreshCache(clazz);
			rdf.setResult(ResponseDataForm.SESSFUL);
			map.put("result", String.valueOf(ResponseDataForm.SESSFUL));
		}catch(Exception e){
			e.printStackTrace();
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("刷新缓存失败："+e.getMessage());
		}
		return rdf;
	}
	/**
	 * 获取考卷
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getTestPaper(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		//判断考试是否结束
		UserSessionBean session = requestDataForm.getUserSession();
		String testPaperPid = session.getUserInfo().get("testPaperPid").toString();
		String userPid = session.getUserInfo().get("userPid").toString();
		Calendar beginTime = DateUtil.getDate(session.getUserInfo().get("beginTime").toString());
		int time = (Integer) session.getUserInfo().get("time");
		Date nowTime =  new Date();
		int finishTime = (int) (time - (nowTime.getTime()-beginTime.getTimeInMillis()));
		if(finishTime<0){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("考试已经结束");
			return rdf;
		}
		
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("testPaperPid", testPaperPid);
		params.put("userPid", userPid);
		
		TestPaper testPaper = (TestPaper) myDao.queryBySqlId("TestPaperMapper.getMembersPaper", "SO", params);
		
		rdf.setResult(ResponseData.SESSFUL);
		Map<String, Object> testPaperInfo = new HashMap<String, Object>();
		testPaperInfo.put("paperTitle", testPaper.getPaperTitle());
		testPaperInfo.put("paperDifficult", testPaper.getPaperDifficulty());
		testPaperInfo.put("paperFinishedTime", testPaper.getPaperFinishedTime());
		testPaperInfo.put("paperQuestionNum", testPaper.getPaperQuestionNum());
		testPaperInfo.put("paperTotalPoint", testPaper.getPaperTotalPoint());
		testPaperInfo.put("paperType", testPaper.getPaperType());
		
		rdf.setResultObj(testPaper);
		
		
		return rdf;
	}
	
	public ResponseDataForm beginTest(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		UrlMap urlMap = requestDataForm.getUrlMap();
		
		//用getString方法直接有参数名获取参数的值
		String userPid = requestDataForm.getUserSession().getUserId();
		String testPaperPid = requestDataForm.getString("testPaperPid");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userPid", userPid);
		params.put("testPaperPid", testPaperPid);
		
		Result r = (Result) myDao.queryBySqlId("ResultMapper.getMembersResult", "SO", params);
		
		if(StringUtils.isEmpty(r.getBeginTime())){
			System.out.println("开始test");
			myDao.queryBySqlId("ResultMapper.beginTest", "U", params);
		}	
		rdf.setResult(ResponseDataForm.SESSFUL);
		rdf.setResultInfo("考试已经开始");
		r = (Result) myDao.queryBySqlId("ResultMapper.getMembersResult", "SO", params);//
		Map<String,Object> userInfo = new HashMap<String, Object>();
		
		Calendar beginTime = DateUtil.getDate(r.getBeginTime());
		
		int time = (int) (r.getFinishTime()-(new Date().getTime() - beginTime.getTimeInMillis()));
		userInfo.put("beginTime", r.getBeginTime());
		userInfo.put("userPid", userPid);
		userInfo.put("testPaperPid", r.getTestPaperPid());
		userInfo.put("time",time);
		requestDataForm.getUserSession().setUserInfo(userInfo);
		rdf.setResultObj(userInfo);
		return rdf;
		
		
	}
	


	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
