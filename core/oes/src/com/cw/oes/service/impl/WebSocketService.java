package com.cw.oes.service.impl;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.dao.IDao;
import com.cw.oes.dao.impl.DaoHelper;
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
import com.cw.oes.mybatis.dao.MessageMapper;
import com.cw.oes.mybatis.dao.PaperMapper;
import com.cw.oes.mybatis.dao.PaperTopicLinkMapper;
import com.cw.oes.mybatis.dao.TagOtherLinkMapper;
import com.cw.oes.mybatis.model.Collection;
import com.cw.oes.mybatis.model.ExamNote;
import com.cw.oes.mybatis.model.Examination;
import com.cw.oes.mybatis.model.Member;
import com.cw.oes.mybatis.model.MemberExamLinkKey;
import com.cw.oes.mybatis.model.Message;
import com.cw.oes.mybatis.model.Paper;
import com.cw.oes.mybatis.model.Tag;
import com.cw.oes.mybatis.model.Topic;
import com.cw.oes.security.CookiesUtil;
import com.cw.oes.security.PasswordMD5;
import com.cw.oes.service.IService;
import com.cw.oes.utils.AnswerUtil;
import com.cw.oes.utils.AutoIdenticonUtil;
import com.cw.oes.utils.DateUtil;
import com.cw.oes.utils.Environment;
import com.cw.oes.utils.ImgUtil;
import com.cw.oes.utils.JsonUtil;
import com.cw.oes.utils.UserSessionBean;
import com.google.gson.Gson;

/**
 * 业务层实现
 * @author 陈威
 *
 */
@Service("webSocketService")
public class WebSocketService implements IService{
	//保存考试期间提交的答案
	private static Map<String,Object> ANSWER_CACHE =  new HashMap<String, Object>();
	
	@Autowired
	private IDao myDao;
	
	
	
	
	/**
	 * 读取最新消息
	 * @param message
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public String getNewMessage(Map<String,String> select)
			throws Exception {
		String jsonStr = "";
		SqlSession session = DaoHelper.getSession();
		try{
			MessageMapper messageMapper = session.getMapper(MessageMapper.class);
			
			
			List<Message> messages = messageMapper.getNewMessage(select);
			jsonStr = JsonUtil.objectToJsonStr(messages);
		}finally{
			session.close();
		}
		
		
		return jsonStr;
	}

	@Override
	public ResponseDataForm service(RequestDataForm requestDataForm)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
}
