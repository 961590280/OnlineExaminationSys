
var INPUT_ERROR_ICON_CLASS 	= "glyphicon glyphicon-remove form-control-feedback";//表单检测错误时显示的图标
var INPUT_OK_ICON_CLASS 	= "glyphicon glyphicon-ok form-control-feedback";//表单检测正确时显示的图标
var DIV_ERROR_CLASS 		= "has-error has-feedback";//输入框验证正确时边框显示的class
var DIV_OK_CLASS 			= "has-success has-feedback";//输入框验证错误时边框显示的class
var ALERT_ERROR 			= "alert alert-danger  alert-dismissible";//错误提示框 
var ALERT_SUCCESS 			= "alert alert-success  alert-dismissible";//错误提示框 
var ALERT_WARM 			    = "alert alert-warning  alert-dismissible";//警告提示框 

var LENGTH_1			    = "col-md-1";//
/**
 * 页面跳转区
 */

function toPage(url){
	location.href = url;
	return false;
}



/**
 * 验证区
 */
//检验表单输入是否为空
function isInputNull(divId){
	//alert();
	var input = $("#"+divId+" input");
	var div = $("#"+divId);
	var span = $("#"+divId+" #"+"glyphicon");
	
	if(input.val() != ""){
		
		div.removeClass(DIV_OK_CLASS);
		div.removeClass(DIV_ERROR_CLASS);
		span.removeClass(INPUT_OK_ICON_CLASS);
		span.removeClass(INPUT_ERROR_ICON_CLASS);
	
		div.addClass(DIV_OK_CLASS);
		span.addClass(INPUT_OK_ICON_CLASS);
	}else{
		
		div.removeClass(DIV_OK_CLASS);
		div.removeClass(DIV_ERROR_CLASS);
		span.removeClass(INPUT_OK_ICON_CLASS);
		span.removeClass(INPUT_ERROR_ICON_CLASS);
		
		div.addClass(DIV_ERROR_CLASS);
		span.addClass(INPUT_ERROR_ICON_CLASS);
		return true;
		
	}
	
	return false;
}

/** 数据加载区 **/


/** 个人测验页面 **/


