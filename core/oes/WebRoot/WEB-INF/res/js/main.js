
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
 * 判断ajax返回的error的全局函数
 */
$(document).ajaxError(function (event, xhr, settings){
	
	
	if(xhr.status == 60000){//60000自定义状态code 未登陆
		window.location= ctxPath+"/common/toLoginPage";
	}
	
});
/*$(document).ajaxSuccess(function (event, xhr, settings){
	alert(1);
	console.log(xhr.getResponseHeader("request_failed"));
	if(xhr.getResponseHeader("request_failed")=="true"){
		window.location= ctxPath+"/common/toLoginPage";
	}
	
});
$(document).ajaxComplete(function (event, xhr, settings){
	alert(2);
	console.log(xhr);
	if(xhr.getResponseHeader("request_failed")=="true"){
		window.location= ctxPath+"/common/toLoginPage";
	}
	
})

$(document).ajaxComplete(function (event, xhr, settings){
	alert("3");
	console.log(event);
	console.log(xhr);
	console.log(settings);
})*/

$(document).ajaxStop(function (event, xhr, settings){
	/*alert("4");
	console.log(event);
	console.log(xhr);
	console.log(settings);*/
})


/* 显示警告框
 * 1 danger 
 * 2 success
 * 3 info
 *  */
function showAlert($e,info,type){
	if(type!=null){
		$e.addClass(type);
	}
	
	$e.removeClass("hidden");
	$e.addClass("show");
	$e.html(info);
	
}
/* 关闭警告框 */
function hideAlert($e){
	$e.removeClass("show");
	$e.addClass("hidden");
	$e.html("");
	
}

/**
 * 验证区
 */
//检验表单输入是否为空
function isInputNull(divId){
	//alert();
	var input = $("#"+divId+" input");
	
	if(input.val() != ""){
		
		verifiedCorrect(divId);
	}else{
		verifiedError(divId);
		
		return true;
		
	}
	
	return false;
}
function verifiedCorrect(divId){
	var div = $("#"+divId);
	var span = $("#"+divId+" #"+"glyphicon");
	div.removeClass(DIV_OK_CLASS);
	div.removeClass(DIV_ERROR_CLASS);
	span.removeClass(INPUT_OK_ICON_CLASS);
	span.removeClass(INPUT_ERROR_ICON_CLASS);

	div.addClass(DIV_OK_CLASS);
	span.addClass(INPUT_OK_ICON_CLASS);
	
}
function verifiedError(divId){
	var div = $("#"+divId);
	var span = $("#"+divId+" #"+"glyphicon");

	div.removeClass(DIV_OK_CLASS);
	div.removeClass(DIV_ERROR_CLASS);
	span.removeClass(INPUT_OK_ICON_CLASS);
	span.removeClass(INPUT_ERROR_ICON_CLASS);
	
	div.addClass(DIV_ERROR_CLASS);
	span.addClass(INPUT_ERROR_ICON_CLASS);
	
}

/** 数据加载区 **/


/** 个人测验页面 **/


