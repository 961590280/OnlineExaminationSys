package com.cw.oes.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.dao.IDao;
import com.cw.oes.dao.impl.DaoHelper;
import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseData;
import com.cw.oes.form.ResponseDataForm;
import com.cw.oes.mybatis.dao.CollectionMapper;
import com.cw.oes.mybatis.dao.ExaminationMapper;
import com.cw.oes.mybatis.dao.MemberExamLinkMapper;
import com.cw.oes.mybatis.dao.MemberMapper;
import com.cw.oes.mybatis.dao.PaperMapper;
import com.cw.oes.mybatis.dao.PaperTopicLinkMapper;
import com.cw.oes.mybatis.dao.SysUrlServiceMapMapper;
import com.cw.oes.mybatis.model.Collection;
import com.cw.oes.mybatis.model.CollectionKey;
import com.cw.oes.mybatis.model.Examination;
import com.cw.oes.mybatis.model.Member;
import com.cw.oes.mybatis.model.MemberExamLinkKey;
import com.cw.oes.mybatis.model.Paper;
import com.cw.oes.mybatis.model.PaperTopicLinkKey;
import com.cw.oes.mybatis.model.SysUrlServiceMap;
import com.cw.oes.mybatis.model.Topic;
import com.cw.oes.pojo.TestPaper;
import com.cw.oes.service.IService;
import com.cw.oes.utils.AnswerUtil;
import com.cw.oes.utils.DateUtil;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.UserSessionBean;

/**
 * 业务层实现
 * @author 陈威
 *
 */
@Service("commonService")
public class CommonService implements IService{
	
	private static Map<String,Object> ANSWER_CACHE =  new HashMap<String, Object>();
	
	@Autowired
	private IDao myDao;
	/**
	 *用户登录
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm memberLogin(RequestDataForm requestDataForm)
			throws Exception {
			ResponseDataForm rdf = new ResponseDataForm();
			SqlSession session = DaoHelper.getSession();
			MemberMapper memberMapper = session.getMapper(MemberMapper.class); 
		try{
			
			//用getString方法直接有参数名获取参数的值
			String userName = requestDataForm.getString("userCode");// 密码
			String userPwd = requestDataForm.getString("userPwd");// 密码
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userCode", userName);
			
			Member member = memberMapper.selectByCode(userName);
			if(member != null && userPwd.equals(member.getUserPwd())){
				rdf.setResult(ResponseDataForm.SESSFUL);
				rdf.setResultInfo("登录成功");
				//设置session
				UserSessionBean userSession = new UserSessionBean();
				userSession.setUserId(member.getUuid());
				userSession.setUserCode(member.getUserName());
				userSession.setMember(member);
				requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, userSession);
				
			}else{
				
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("账号或密码不正确");
				rdf.setPage("oes/login");
				
			}
		}finally{
			session.close();
		}
		return rdf;
	}
	/**
	 * 安全退出
	 * @param requestDataForm
	 * @return
	 */
	@Transactional
	public ResponseDataForm memberSignOut(RequestDataForm requestDataForm){
		ResponseDataForm rdf = new ResponseDataForm();
		requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, null);
		return rdf;
	}
	/**
	 * 获取感兴趣的测验
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm getLikeExams(RequestDataForm requestDataForm)
			throws Exception {

		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			List<Examination> exams = examMapper.selectExams();
			
			if(exams.size()>0){
				
				rdf.setResult(ResponseDataForm.SESSFUL);
				rdf.setResultObj(exams);
				
			}else{
				
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("记录为空！");
			}
			
		}finally{
			
			session.close();
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
	 * 开始个人测验
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm beginExamByPersonal(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();	
		SqlSession session = DaoHelper.getSession();
		try{
			/*dao*/
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			MemberExamLinkMapper memberExamMapper = session.getMapper(MemberExamLinkMapper.class);
			PaperMapper paperMapper = session.getMapper(PaperMapper.class);
			/*页面参数*/
			String examPid = requestDataForm.getString("examPid");//获取考试id
			Member member = requestDataForm.getUserSession().getMember();//获取session中的会员
			Examination exam = examMapper.selectByPrimaryKey(examPid);//根据id查询测验
		
			if(exam == null
					||!exam.getExamType().equals(Examination.EXAM_TYPE_PERSONAL)){	//判断测验是否存在,不存在则返回
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("要参加的测验不存在！！");
				return rdf;
			}
			MemberExamLinkKey record = new MemberExamLinkKey();
			record.setExamPid(examPid);
			record.setMemberPid(member.getUuid());
			record.setCreateTime(DateUtil.getCurrDateStr());
			memberExamMapper.beginExam(record);//插入
			MemberExamLinkKey memberExam = record;
			requestDataForm.getUserSession().setMemberExamLink(memberExam);

			ANSWER_CACHE.put(member.getUuid()+memberExam.getExamPid(),new HashMap<String, Object>());
			//读取考卷
			Paper paper = paperMapper.selectByPrimaryKey(exam.getExamPaperPid());
			requestDataForm.getUserSession().setPaper(paper);
			
			//读取所有题目
			PaperTopicLinkMapper paperTopicMapper = session.getMapper(PaperTopicLinkMapper.class);
			List<Topic> topics = paperTopicMapper.selectPaperTopic(paper.getUuid());
			requestDataForm.getUserSession().setTopics(topics);
			requestDataForm.getUserSession().setExam(exam);
			
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultInfo("测验开始");
			rdf.setResultObj(paper);
			session.commit();
		}finally{
			session.close();
		}	
		return rdf;
	}
	/**
	 * 读取题目
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getTopic(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		int topicSort =  Integer.parseInt(requestDataForm.getString("topicSort"));
		Paper paper = requestDataForm.getUserSession().getPaper();
		Member member = requestDataForm.getUserSession().getMember();
		Examination exam = requestDataForm.getUserSession().getExam();
		
		
		Map<String,Object> memberAnswer = (Map<String, Object>)ANSWER_CACHE.get(member.getUuid()+exam.getUuid());
		Object answer = memberAnswer.get(topicSort+"");
		
		
		try{
			List<Topic> topics = requestDataForm.getUserSession().getTopics();
			Topic topic = topics.get(topicSort-1);
			if(topic == null){//若题目为空则为返回空
				return null;
			}else{
				rdf.setResult(ResponseDataForm.SESSFUL);
				Map<String, Object> obj = new HashMap<String,Object>();
				obj.put("topic", topic);
				
				obj.put("answer", answer);
				
				rdf.setResultObj(obj);
				
			}
		}finally{
			session.close();
		}
		return rdf;
		
	}
	/**
	 * 保存一个答案
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm saveAnswerOne(RequestDataForm requestDataForm)
			throws Exception {
			ResponseDataForm rdf = new ResponseDataForm();
			Member member = requestDataForm.getUserSession().getMember();
			
			Paper paper = requestDataForm.getUserSession().getPaper();
			Examination exam = requestDataForm.getUserSession().getExam();
			String topicSort = requestDataForm.getString("topicSort");
			String answer = requestDataForm.getString("answer");
		
		try{
			Map<String,Object> memberAnswer = (Map<String, Object>) ANSWER_CACHE.get(member.getUuid()+exam.getUuid());
			memberAnswer.put(topicSort+"", answer);
			rdf.setResult(ResponseDataForm.SESSFUL);
		}catch(Exception e){
			e.printStackTrace();
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("保存答案失败");
		}
		return rdf;		
	}
	/**
	 * 提交考卷
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm commitExam(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		
		Member member = requestDataForm.getUserSession().getMember();
		Examination exam = requestDataForm.getUserSession().getExam();
		List<Topic> topics = requestDataForm.getUserSession().getTopics();
		Map<String, Object> answer = (Map<String, Object>) ANSWER_CACHE.get(member.getUuid()+exam.getUuid());
		try{
			MemberExamLinkMapper memberExamMapper = session.getMapper(MemberExamLinkMapper.class);//
			MemberExamLinkKey memberExam = requestDataForm.getUserSession().getMemberExamLink();
			if(answer.size()==0){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("你的答案为空,提交失败");
				return rdf;
			}
			memberExam.setAnswer(AnswerUtil.coverIntoString(answer));
			
			int scor = judgingPaper(topics,answer);
			int result = memberExamMapper.commitAnswer(memberExam);
			if(result == 0){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("提交失败,请重新提交");
				
			}
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultObj(scor);
			session.commit();
		}finally{
			
			session.close();
		}
		return rdf;
	}
	/** 计算答题结果**/
	public int judgingPaper(List<Topic> topics, Map<String, Object> answer){
		int scor = 0;
		for(int i = 0;i<topics.size();i++){
			if(topics.get(i).getAnswer().equals(answer.get(i+1+""))){
				scor ++;
			}
			
		}
		return scor;
	}
	
	/**
	 * 返回用户个人信息
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getPersonalInfo(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		Member member = requestDataForm.getUserSession().getMember();
		rdf.setResultObj(member);
		
		return rdf;
		
	}
	/**
	 * 读取个人测验记录列表
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getPersonalExamRecordList(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		List<Map<String,Object>> resultList =  new ArrayList<Map<String,Object>>();
		
		SqlSession session = DaoHelper.getSession();
		Member member = requestDataForm.getUserSession().getMember();
		
		MemberExamLinkMapper memberExamMapper = session.getMapper(MemberExamLinkMapper.class);
		ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
		List<MemberExamLinkKey> memberExamList =  memberExamMapper.personalExamRecords(member);
		
		if(memberExamList.size()>0){
			for(MemberExamLinkKey temp : memberExamList){
				Map<String,Object> record = new HashMap<String,Object>();
				Examination exam = examMapper.selectByPrimaryKey(temp.getExamPid());
				
				record.put("examPid", temp.getExamPid());
				record.put("createTime", temp.getCreateTime());
				record.put("examName", exam.getExamName());
				resultList.add(record);
			}
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultObj(resultList);
			
		}else{
			
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("记录为空！");
		}
		return rdf;
		
	}
	/**
	 * 收藏测验
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	
	public ResponseDataForm collectionExam(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		List<Map<String,Object>> resultList =  new ArrayList<Map<String,Object>>();
		SqlSession session = DaoHelper.getSession();
		try{
			Member member = requestDataForm.getUserSession().getMember();
			CollectionMapper collectionMapper = session.getMapper(CollectionMapper.class);
			
			String examPid = requestDataForm.getString("examPid");
			
			Collection collection = new Collection();
			collection.setCollectionType("0");
			collection.setCollectorPid(examPid);
			collection.setUserPid(member.getUuid());
			collection.setCreateTime(DateUtil.getCurrDateStr());
			if(collectionMapper.selectByPrimaryKey(collection)!= null){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("已收藏");
			}else{
				collectionMapper.insert(collection);
				rdf.setResult(ResponseDataForm.SESSFUL);
			}
			
			
			session.commit();
			
		}finally{
			session.close();
		}
		return rdf;
		
	}
	
	/**
	 * 取消收藏测验
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	
	public ResponseDataForm unCollectionExam(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		List<Map<String,Object>> resultList =  new ArrayList<Map<String,Object>>();
		SqlSession session = DaoHelper.getSession();
		try{
			Member member = requestDataForm.getUserSession().getMember();
			CollectionMapper collectionMapper = session.getMapper(CollectionMapper.class);
			
			String examPid = requestDataForm.getString("examPid");
			
			Collection collection = new Collection();
			collection.setCollectionType("0");
			collection.setCollectorPid(examPid);
			collection.setUserPid(member.getUuid());
			if(collectionMapper.selectByPrimaryKey(collection) == null){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("未收藏");
			}else{
				collectionMapper.deleteByPrimaryKey(collection);
				rdf.setResult(ResponseDataForm.SESSFUL);
			}
			
			
			session.commit();
			
		}finally{
			session.close();
		}
		return rdf;
		
	}
	
	public ResponseDataForm (RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		List<Map<String,Object>> resultList =  new ArrayList<Map<String,Object>>();
		SqlSession session = DaoHelper.getSession();
		try{
			Member member = requestDataForm.getUserSession().getMember();
			CollectionMapper collectionMapper = session.getMapper(CollectionMapper.class);
			
			String examPid = requestDataForm.getString("examPid");
			
			Collection collection = new Collection();
			collection.setCollectionType("0");
			collection.setCollectorPid(examPid);
			collection.setUserPid(member.getUuid());
			if(collectionMapper.selectByPrimaryKey(collection) == null){
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("未收藏");
			}else{
				collectionMapper.deleteByPrimaryKey(collection);
				rdf.setResult(ResponseDataForm.SESSFUL);
			}
			
			
			session.commit();
			
		}finally{
			session.close();
		}
		return rdf;
		
	}
	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
