package com.cw.oes.service;

import org.springframework.transaction.annotation.Transactional;

import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseDataForm;



/**
 * @author lansb
 * Service统一入口
 * Transactional 注释事务
 */
public interface IService {
	@Transactional 
	public ResponseDataForm service(RequestDataForm requestDataForm) throws Exception;
}
