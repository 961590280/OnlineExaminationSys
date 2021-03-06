package com.cw.oes.service;

import com.cw.oes.form.RequestDataForm;
import com.cw.oes.form.ResponseDataForm;



/**
 * @author lansb
 *业务实现回调接口
 */
public interface IServiceCallback {
	/**
	 * service回调函数，执行传统sql xml无法解决的问题，如第三方接口回调等
	 * @param requestDataForm
	 * @param responseDataForm
	 * @throws Exception
	 */
	public ResponseDataForm serviceCallback(RequestDataForm requestDataForm) throws Exception;
}
