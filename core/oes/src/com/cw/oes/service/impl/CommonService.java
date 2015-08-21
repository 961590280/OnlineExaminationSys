package com.cw.oes.service.impl;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cw.oes.cache.GlobalCache;
import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseData;
import com.cw.oes.form.ResponseDataForm;
import com.cw.oes.service.IService;
import com.cw.oes.utils.MapUtils;

/**
 * 业务层实现
 * @author 陈威
 *
 */
@Service("commonService")
public class CommonService implements IService{

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
		
		
		String userName = requestDataForm.getString("userCode");// 密码
		String userPwd = requestDataForm.getString("userPwd");// 密码
		if(StringUtils.equals(userName, "cw")&&StringUtils.equals(userPwd, "123")){
			System.out.println("登录成功");
			rdf.setResult(ResponseDataForm.SESSFUL);
			rdf.setResultInfo("登录成功");
		}else{
			System.out.println("登录失败");
			rdf.setResult(ResponseDataForm.FAULAIE);
			rdf.setResultInfo("登录失败");
			rdf.setPage("oes/login");
			
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
