package com.cw.oes.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.dao.IDao;
import com.cw.oes.dao.impl.DaoHelper;
import com.cw.oes.email.EmailFindPassword;
import com.cw.oes.email.EmailVerify;
import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseData;
import com.cw.oes.form.ResponseDataForm;
import com.cw.oes.model.impl.ExamPaperModel;
import com.cw.oes.model.impl.PersonalExamRecordModel;
import com.cw.oes.model.impl.TopicModel;
import com.cw.oes.mybatis.dao.CollectionMapper;
import com.cw.oes.mybatis.dao.ExamNoteMapper;
import com.cw.oes.mybatis.dao.ExaminationMapper;
import com.cw.oes.mybatis.dao.MemberExamLinkMapper;
import com.cw.oes.mybatis.dao.MemberMapper;
import com.cw.oes.mybatis.dao.PaperMapper;
import com.cw.oes.mybatis.dao.PaperTopicLinkMapper;
import com.cw.oes.mybatis.dao.TagMapper;
import com.cw.oes.mybatis.dao.TagOtherLinkMapper;
import com.cw.oes.mybatis.dao.TopicMapper;
import com.cw.oes.mybatis.model.Collection;
import com.cw.oes.mybatis.model.ExamNote;
import com.cw.oes.mybatis.model.Examination;
import com.cw.oes.mybatis.model.Member;
import com.cw.oes.mybatis.model.MemberExamLinkKey;
import com.cw.oes.mybatis.model.Paper;
import com.cw.oes.mybatis.model.Tag;
import com.cw.oes.mybatis.model.TagOtherLinkKey;
import com.cw.oes.mybatis.model.Topic;
import com.cw.oes.security.CookiesUtil;
import com.cw.oes.security.PasswordMD5;
import com.cw.oes.service.IService;
import com.cw.oes.utils.AnswerUtil;
import com.cw.oes.utils.AutoIdenticonUtil;
import com.cw.oes.utils.DateUtil;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.ImgUtil;
import com.cw.oes.utils.UserSessionBean;

/**
 * 业务层实现
 * @author 陈威
 *
 */
@Service("commonService")
public class CommonService implements IService{
	//保存考试期间提交的答案
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
			String userEmail = requestDataForm.getString("userEmail");// 登陆邮箱
			String userPwd = requestDataForm.getString("userPwd");// 密码
			String autoLogin =  requestDataForm.getString("autoLogin");
			
			//密码加密后比较
			String userPwdMD5 = PasswordMD5.passwordEncrypt(userPwd);
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userCode", userEmail);
			
			Member member = memberMapper.selectByEmail(userEmail);
			if(member != null && userPwdMD5.equals(member.getUserPwd())){
				
				if("N".equals(member.getIsVerified())){
					rdf.setResult(ResponseDataForm.FAULAIE);
					rdf.setResultInfo("未验证邮箱，请登录邮箱进行验证");
					
					return rdf;
					
				}
				rdf.setResult(ResponseDataForm.SESSFUL);
				rdf.setResultInfo("登录成功");
				//设置session
				UserSessionBean userSession = new UserSessionBean();
				userSession.setUserId(member.getUuid());
				userSession.setUserCode(member.getUserName());
				userSession.setMember(member);
				requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, userSession);
				
				if(autoLogin!=null&&"true".equals(autoLogin)){//设置cookie
					Cookie cookie = new Cookie("oes-cookie",URLEncoder.encode(CookiesUtil.encryption(userEmail+","+userPwd), "utf-8"));
					cookie.setPath(requestDataForm.getRequest().getContextPath( ));
					cookie.setMaxAge(1000*60*60*24*7);
					requestDataForm.getResponse().addCookie(cookie);
				}else if(autoLogin ==null || "".equals(autoLogin)){//销毁cookie
					//注销cookie
					Cookie[] cookies = requestDataForm.getRequest().getCookies();
					for(Cookie  cookie: cookies){
						if(cookie.getName().equals("oes-cookie")){
							
							cookie.setPath(requestDataForm.getRequest().getContextPath( ));
							cookie.setMaxAge(0);
							requestDataForm.getResponse().addCookie(cookie);
						}
					}
				}
			
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
	 * 用户注册
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm memberRegister(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			String email = requestDataForm.getString("userEmail");
			String password = requestDataForm.getString("userPwd");
			//密码加密后保存
			password = PasswordMD5.passwordEncrypt(password);
			
			MemberMapper memeberMapper = session.getMapper(MemberMapper.class);
			Member record = new Member();
			record.setUserEmail(email);
			record.setUserName(email);
			record.setUserPwd(password);
		
			HttpServletRequest  request = requestDataForm.getRequest();
			String code = URLEncoder.encode(CookiesUtil.encryption(email), "utf-8");

			
			String url = request.getScheme()
					+"://"+request.getServerName()
					+":"+request.getServerPort()+request.getContextPath()
					+"/common/verifyEmail?verifyCode="
					+code;
			EmailVerify.sendVarifyEmail(email,url);
			
			AutoIdenticonUtil iden = new AutoIdenticonUtil();
			String imgName = UUID.randomUUID().toString()+".png";
			iden.createAndSave(email, imgName);
			
			rdf.setResult(ResponseData.SESSFUL);
			
			record.setUserHead(imgName);
			memeberMapper.register(record);
			session.commit();
		}finally{
			session.close();
		}
		return rdf;
	}
	/**
	 * 判断邮箱是否被使用
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm memberIsUsed(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
            String email = requestDataForm.getString("email");
            MemberMapper memberMapper = session.getMapper(MemberMapper.class);
            if(memberMapper.emailIsUsed(email)!=1){
                rdf.setResult(ResponseData.SESSFUL);
            }else{
                rdf.setResult(ResponseData.FAULAIE);
            }
		}finally{
			session.close();
		}
		return rdf;
	}
	/**
	 * 邮箱验证
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm verifyEmail(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			String verifyCode = requestDataForm.getString("verifyCode");
			System.out.println(URLDecoder.decode(verifyCode, "UTF-8"));
			String email = CookiesUtil.dencryption(URLDecoder.decode(verifyCode, "UTF-8"));
			MemberMapper memberMapper = session.getMapper(MemberMapper.class);
			
			Member member =  memberMapper.selectByEmail(email);
			member.setIsVerified("Y");
			memberMapper.updateByPrimaryKey(member);
			session.commit();
			HttpServletRequest request = requestDataForm.getRequest();
			String url = request.getScheme()
					+"://"+request.getServerName()
					+":"+request.getServerPort()+request.getContextPath()
					+"/common/varifySuccess?userEmail="+member.getUserEmail();
			requestDataForm.getResponse().sendRedirect(url);
		}finally{
			session.close();
		}
		return rdf;
	}
	/**
	 * 自动登录
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm autoLogin(RequestDataForm requestDataForm)
			throws Exception {
			ResponseDataForm rdf = new ResponseDataForm();
			SqlSession session = DaoHelper.getSession();
			MemberMapper memberMapper = session.getMapper(MemberMapper.class); 
		try{
			String cookie = requestDataForm.getString("cookie");
			String reqUrl = requestDataForm.getString("reqUrl");
			
			reqUrl = URLDecoder.decode(reqUrl, "UTF-8"); 
			String[] strs = CookiesUtil.dencryption(cookie).split(",");
        	String userEmail = strs[0];
        	String userPwd = PasswordMD5.passwordEncrypt(strs[1]);
			
			
			
			/*Map<String, Object> params = new HashMap<String, Object>();
			params.put("userEmail", userEmail);*/
			
			Member member = memberMapper.selectByEmail(userEmail);
			if(member != null && userPwd.equals(member.getUserPwd())){
				rdf.setResult(ResponseDataForm.SESSFUL);
				rdf.setResultInfo("自动登录成功");
				//设置session
				UserSessionBean userSession = new UserSessionBean();
				userSession.setUserId(member.getUuid());
				userSession.setUserCode(member.getUserName());
				userSession.setMember(member);
				requestDataForm.getRequest().getSession().setAttribute(Environment.SESSION_USER_LOGIN_INFO, userSession);
				requestDataForm.getResponse().sendRedirect(reqUrl);
				
			}else{
				
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("自动登录失败");
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
		
		//注销cookie
		Cookie[] cookies = requestDataForm.getRequest().getCookies();
		for(Cookie  cookie: cookies){
			if(cookie.getName().equals("oes-cookie")){
				
				cookie.setPath(requestDataForm.getRequest().getContextPath( ));
				cookie.setMaxAge(0);
				requestDataForm.getResponse().addCookie(cookie);
			}
		}
		
		
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
			List<Examination> exams = examMapper.selectExamsPernal();
			
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
	 * 返回测验信息
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getExamInfo(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		String examPid = requestDataForm.getString("examPid");
		try{
			
			
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			Examination exam = examMapper.selectByPrimaryKey(examPid);
			rdf.setResultObj(exam);
		}finally{
			session.close();
		}
		return rdf;
		
	}
	/**
	 * 返回用户标签
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	public ResponseDataForm getPersonalTag(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		Member member = requestDataForm.getUserSession().getMember();
		try{
			
			
			TagOtherLinkMapper linkMapper = session.getMapper(TagOtherLinkMapper.class); 
			List<Tag> tags = linkMapper.getPersonalTags(member.getUuid());
			
			
			rdf.setResultObj(tags);
			
			
		}finally{
			session.close();
		}
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
		SqlSession session = null;
		
		
		try{
			List<Map<String,Object>> resultList =  new ArrayList<Map<String,Object>>();
			
			Integer pageNum = requestDataForm.getInteger("pageNum");
			Integer pageSize = requestDataForm.getInteger("pageSize");
			if(pageNum==null){
				pageNum=0;
				
			}
			if(pageSize==null){
				pageSize=5;
			}
			session = DaoHelper.getSession();
			Member member = requestDataForm.getUserSession().getMember();
			
			MemberExamLinkMapper memberExamMapper = session.getMapper(MemberExamLinkMapper.class);
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			Map<String,Object> pramMap = new HashMap<String, Object>();
			
			Integer begin = pageNum*pageSize;
			Integer end   = pageSize;
			
			pramMap.put("uuid", member.getUuid());
			pramMap.put("begin", begin);
			pramMap.put("end",end);
			List<MemberExamLinkKey> memberExamList =  memberExamMapper.personalExamRecords(pramMap);
			
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
		}finally{
			session.close();
		}
		return rdf;
		
	}
	
	/**
	 * 保存题目笔记
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm saveTopicNote(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			String content = URLDecoder.decode(requestDataForm.getString("content"), "UTF-8");
			
			System.out.println(requestDataForm.getString("content"));
			System.out.println(content);
			System.out.println(URLDecoder.decode(content, "UTF-8"));
			
			String topicId = requestDataForm.getString("topicId");
			ExamNoteMapper examNoteMapper = session.getMapper(ExamNoteMapper.class);
			Member member = requestDataForm.getUserSession().getMember();
			ExamNote note = new ExamNote();
			note.setMemberPid(member.getUuid());
			note.setTopicPid(topicId);
			note.setContent(content);
			if(examNoteMapper.getNoteByPid(note) != null){
				examNoteMapper.updateByPrimaryKeySelective(note);
			}else{
				examNoteMapper.insert(note);
			}
			rdf.setResultInfo(ResponseDataForm.SESSFUL);
			session.commit();
		}finally{
			session.close();
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
	
	/**
	 * 获取个人测验详细信息
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	
	public ResponseDataForm getPersonalExamRecordInfo(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			String examPid = requestDataForm.getString("examPid");
			String createTime = requestDataForm.getString("createTime");
			String memberPid = requestDataForm.getUserSession().getUserId();
			
			MemberExamLinkMapper memberExamLinkMapper = session.getMapper(MemberExamLinkMapper.class);
			ExaminationMapper examinationMapper =session.getMapper(ExaminationMapper.class);
			PaperMapper paperMapper = session.getMapper(PaperMapper.class);
			PaperTopicLinkMapper paperTopicMapper = session.getMapper(PaperTopicLinkMapper.class);
			
			MemberExamLinkKey memberExamLinkKey= new MemberExamLinkKey();
			memberExamLinkKey.setMemberPid(memberPid);
			memberExamLinkKey.setExamPid(examPid);
			memberExamLinkKey.setCreateTime(createTime);
			MemberExamLinkKey memberExamLink = memberExamLinkMapper.selectByMemberIdExamIdCreateTime(memberExamLinkKey);
			
			ExamNoteMapper examNote = session.getMapper(ExamNoteMapper.class);
			
			Examination exam = examinationMapper.selectByPrimaryKey(memberExamLink.getExamPid());
			
			Paper paper = paperMapper.selectByPrimaryKey(exam.getExamPaperPid());
			
			List<Topic> topics = paperTopicMapper.selectPaperTopic(paper.getUuid());
			
			Map<String,String> answers =  AnswerUtil.coverIntoMap(memberExamLink.getAnswer());
			
			List<TopicModel> topicList = new ArrayList<TopicModel>();
			for(Topic topic:topics){
				TopicModel topicModel = new TopicModel();
				topicModel.setCorrectAnswer(topic.getAnswer());
				List<String> options = new ArrayList<String>();
				options.add(topic.getOpn1());
				options.add(topic.getOpn2());
				options.add(topic.getOpn3());
				options.add(topic.getOpn4());
				options.add(topic.getOpn5());
				options.add(topic.getOpn6());
				options.add(topic.getOpn7());
				topicModel.setOptions(options);
				topicModel.setUuid(topic.getUuid());
				topicModel.setTopicTitle(topic.getContent());
				
				ExamNote note = new ExamNote();
				note.setTopicPid(topic.getUuid());
				note.setMemberPid(memberPid);
				note =  examNote.getNoteByPid(note);
				if(note!=null){//如果不存在笔记记录则设置笔记内容为空和重点为N
					topicModel.setTopicNote(note.getContent());
					topicModel.setIsImport(note.getIsImport());
				}else{
					topicModel.setTopicNote("");
					topicModel.setIsImport("N");
				}
				
				topicList.add(topicModel);
			}
			
			ExamPaperModel examPaperModel = new ExamPaperModel();
			examPaperModel.setTopics(topicList);
			examPaperModel.setUuid(paper.getUuid());
			
			PersonalExamRecordModel personalExamRecordModel = new PersonalExamRecordModel();
			personalExamRecordModel.setDate(memberExamLink.getCreateTime());
			personalExamRecordModel.setExamPaper(examPaperModel);
			personalExamRecordModel.setExamTitle(exam.getExamName());
			personalExamRecordModel.setUuid(examPid);
			personalExamRecordModel.setAnswers(answers);
			
			rdf.setResultObj(personalExamRecordModel);
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			session.close();
		}
		return rdf;
		
	}
	/**
	 * 上传头像
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	
	public ResponseDataForm uploadHeadImg(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		
		try{
			MemberMapper memberMapper = session.getMapper(MemberMapper.class);
			Member member = requestDataForm.getUserSession().getMember();
			String data = requestDataForm.getString("data");
		
			
			String fileName = new ImgUtil().img64BaseSave(data,"/res/personal-img/");//将字符串图片数据转为文件保存
			
			member.setUserHead(fileName);
			memberMapper.updateByPrimaryKey(member);
			
			Map<String, Object> resultObj = new HashMap<String, Object>();
			resultObj.put("fileName", fileName);
			rdf.setResultObj(resultObj);
			rdf.setResultInfo(ResponseDataForm.SESSFUL);
			
			session.commit();
		}finally{
			session.close();
		}
		return rdf;
	}
	
	/**
	 * 保存账号设置
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm countSettingSave(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		try{
			MemberMapper memberMapper = session.getMapper(MemberMapper.class);
			Member member = requestDataForm.getUserSession().getMember();
			String userName = requestDataForm.getRequest().getParameter("userName");
			member.setUserName(userName);
			memberMapper.updateByPrimaryKey(member);
			
			rdf.setResultInfo(ResponseDataForm.SESSFUL);
			session.commit();
		}finally{
			session.close();
		}
		return rdf;
	}
	
	
	/**
	 * 设置重点
	 * @param requestDataForm
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResponseDataForm setImport(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		String topicId = requestDataForm.getString("topicId");
		String isImport = requestDataForm.getString("isImport");
		String noteId = requestDataForm.getString("noteId");
		String userId = requestDataForm.getUserSession().getUserId();
		try{
			TopicMapper topicMapper = session.getMapper(TopicMapper.class);
			
			Topic topic = new Topic();
			topic.setUuid(topicId);
			if(topicMapper.isExistedById(topicId) > 0){
				ExamNoteMapper noteMapper = session.getMapper(ExamNoteMapper.class);
				
				ExamNote note = new ExamNote();
				note.setMemberPid(userId);
				note.setTopicPid(topicId);
				note = noteMapper.getNoteByPid(note);
				
				
				if(note == null){
					//若记录为空则插入新的记录
					note = new ExamNote();
					note.setUuid(UUID.randomUUID().toString());
					note.setMemberPid(userId);
					note.setTopicPid(topicId);
					note.setIsImport(isImport);
					noteMapper.insertSelective(note);
				}else{
					note.setIsImport(isImport);
					noteMapper.updateByPrimaryKeySelective(note);
				}
				
				rdf.setResult(ResponseDataForm.SESSFUL);
				session.commit();
			}else{
				rdf.setResultInfo("题目不存在");
				rdf.setResult(ResponseDataForm.FAULAIE);
				
			}
		
		}finally{
			session.close();
		}
		return rdf;
		
	}
	
	/**
	 * 搜索考试信息自动补全考试名称
	 * @param requestDataForm
	 * @return ResponseDataForm
	 * @throws Exception    
	 * @throws
	 */
	public ResponseDataForm searchExamAutoComplete(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		String key = requestDataForm.getString("key");
		try{
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			
			key = "%"+key+"%";
			List<String> names = examMapper.selectExamsNameByKey(key);
			rdf.setResultObj(names);
			rdf.setResult(ResponseDataForm.SESSFUL);
			
		}finally{
			session.close();
		}
		
		return rdf;
		
		
	}
	/**
	 * 搜索考试信息
	 * @param requestDataForm
	 * @return  ResponseDataForm 
	 * @throws Exception  
	 * @throws
	 */
	public ResponseDataForm searchExamInfoByKey(RequestDataForm requestDataForm)
			throws Exception {
		ResponseDataForm rdf = new ResponseDataForm();
		SqlSession session = DaoHelper.getSession();
		String key = "%"+requestDataForm.getString("key")+"%";
		try{
			ExaminationMapper examMapper = session.getMapper(ExaminationMapper.class);
			List<Examination> exams = examMapper.selectExamsInfoByKey(key);
			rdf.setResultObj(exams);
			rdf.setResult(ResponseDataForm.SESSFUL);
			
		}finally{
			if(session != null){
				session.close();
			}
		}
		
		return rdf;
	}

	public ResponseDataForm sendFindBackPasswordEmail(RequestDataForm requestDataForm) throws UnsupportedEncodingException{
		ResponseDataForm rdf = new ResponseDataForm();
		String email = requestDataForm.getString("myEmail");
		if(StringUtils.isNotBlank(email)){
			SqlSession session = DaoHelper.getSession();
			try{
				MemberMapper memberMapper = session.getMapper(MemberMapper.class);
				Member member = memberMapper.selectByEmail(email);
				if(member == null){
					rdf.setResult(ResponseDataForm.FAULAIE);
					rdf.setResultInfo("邮箱不存在");
				}else{
					HttpServletRequest  request = requestDataForm.getRequest();
					String code = URLEncoder.encode(CookiesUtil.encryption(email), "utf-8");
					String url = request.getScheme()
							+"://"+request.getServerName()
							+":"+request.getServerPort()+request.getContextPath()
							+"/common/findBackPasswordPage?verifyCode="+code+"&email="+email;
					
					EmailFindPassword.sendVarifyEmail(email, url);
					rdf.setResult(ResponseDataForm.SESSFUL);
				}
				
			}finally{
				if(session != null){
					session.close();
				}
			}
		}else{
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("邮箱不能为空");
		}
		
		
		return rdf;
	}
	@Transactional
	public ResponseDataForm resetPassword(RequestDataForm requestDataForm) throws UnsupportedEncodingException{
		ResponseDataForm rdf = new ResponseDataForm();
		String verifyCode = requestDataForm.getString("verifyCode");
		String password =  requestDataForm.getString("password");
		if(StringUtils.isBlank(password)){
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("密码不能为空");
		}
		
		
		if(StringUtils.isNotBlank(verifyCode)){
			SqlSession session = DaoHelper.getSession();
			try{
				String email = CookiesUtil.dencryption(URLDecoder.decode(verifyCode, "UTF-8"));
				MemberMapper memberMapper = session.getMapper(MemberMapper.class);
				Member member = memberMapper.selectByEmail(email);
				password = PasswordMD5.passwordEncrypt(password);
				member.setUserPwd(password);
				memberMapper.updateByPrimaryKey(member);
				rdf.setResult(ResponseDataForm.SESSFUL);
				
				
				session.commit();
			}finally{
				if(session != null){
					session.close();
				}
			}
		}else{
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("非法操作");
		}
		return rdf;
	}
	
	public ResponseDataForm searchTags(RequestDataForm requestDataForm){
		ResponseDataForm rdf = new ResponseDataForm();
		String key = requestDataForm.getString("key");
		if(StringUtils.isNotBlank(key)){
			SqlSession session = DaoHelper.getSession();
			TagMapper tagMapper = session.getMapper(TagMapper.class);
			List<Tag> tags =  tagMapper.selectByKeyword("%"+key+"%");
			
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultObj(tags);
		}else{
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("关键字不能为空");
		}
		return rdf;
	}
	public ResponseDataForm addTag(RequestDataForm requestDataForm){
		ResponseDataForm rdf = new ResponseDataForm();
		String tagId = requestDataForm.getString("tagId");
		if(StringUtils.isNotBlank(tagId)){
			SqlSession session = DaoHelper.getSession();
			TagMapper tagMapper = session.getMapper(TagMapper.class);
			Tag tag = tagMapper.selectByPrimaryKey(tagId);
			if(tag!=null){
				TagOtherLinkMapper tagOtherMapper = session.getMapper(TagOtherLinkMapper.class);
				TagOtherLinkKey tagOther = new TagOtherLinkKey();
				tagOther.setTagPid(tagId);
				Member member = requestDataForm.getUserSession().getMember();
				tagOther.setOther(member.getUuid());
				int count = tagOtherMapper.selectByPrimaryKey(tagOther);
				if(count == 0){
					tagOtherMapper.insert(tagOther);
					rdf.setResult(ResponseDataForm.SESSFUL);
					session.commit();
				}else{
					rdf.setResult(ResponseDataForm.FAULAIE);
					rdf.setResultInfo("已拥有此标签");
				}
			}else{
				rdf.setResult(ResponseDataForm.FAULAIE);
				rdf.setResultInfo("标签不存在");
			}
			
		
		}else{
			
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultObj("添加标签失败");
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
