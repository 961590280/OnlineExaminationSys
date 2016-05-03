<%@ page language="java" import="java.util.*" import="com.cw.oes.form.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String err = request.getParameter("err");
ResponseDataForm rdf = (ResponseDataForm) request.getAttribute("responseDataForm");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!-- 引入top.jsp页面  -->
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/top.jsp"></jsp:include>
    <title>OES 回归</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 <link href="res/plug-in/bootstrap-switch/css/bootstrap-switch.css" rel="stylesheet">
	
	

	<script type="text/javascript">
	
	//rediect index page
	if(window.top != window) window.top.location.href=window.location.href;
	<%if("2".equals(err)){%>
		alert("SESSION超时，请重新登陆！");
	<%}else if (rdf != null && "2".equals(rdf.getResult())) {%>
		alert("<%=rdf.getResultInfo()%>");
	<%}%>
		function submitForm() {
			
			
			var userEmail = $('#userEmail').val();
			var userPwd = $('#userPwd').val();
			var autoLogin = $("input[name='autoLogin']:checked").val();
			
			if (userEmail=="" || userPwd == "") {
				
				  isInputNull("div_input_username");
				  isInputNull("div_input_password");
				  
				
				
			}else{
				console.log(autoLogin);
				logining();
				$.post("${ctxPath}/common/ajax/memberLogin",
						{userEmail:userEmail,userPwd:userPwd,autoLogin:autoLogin},
						function(data){
							
							data = eval("("+data+")");
							if(data["result"] == 1){
								location.href = "${ctxPath}/common/toPersonalPage";
							}else{
								var errorInfo = $("#loginErrorInfo");//错误提示框
								errorInfo.html(data["resultInfo"]);
								errorInfo.removeClass("hidden");
								errorInfo.addClass("show");	
								
							}
							logined();
						}
					); 
				
				
			}
		 
	}
	//清除提示信息
	function clearErrorInfo(){
	
		var errorInfo = $("#loginErrorInfo");//错误提示框
		errorInfo.removeClass(ALERT_ERROR);
		errorInfo.html("");
	}
	function closeAlert(){
		var errorInfo = $("#loginErrorInfo");//错误提示框s
		errorInfo.removeClass("show");
		errorInfo.addClass("hidden");	
	}
	
	//登录中 特效
	function logining(){
		$('#login-btn').removeClass("btn-info").addClass("btn-logining").html("登&nbsp录&nbsp中&nbsp...").attr("disabled","disabled");
	}
	//移除登录特效
	function logined(){
		$('#login-btn').removeClass("btn-logining").addClass("btn-primary").html("确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认").attr("disabled",false);
	}
	//返回首页
	function backHome(){
		location.href = "${ctxPath}/common/index";
	}
	//打开找回密码模态窗
	function findBackPassword(){
		$('#find-password-modal').modal({});
	}
	//发送找回密码邮件
	function sendEmail(){
		var email = $("#myEmail").val();
		
		if(email == null ||email == ""){
			alert("邮箱不能为空");
			return;
		}
		$.ajax({
			url:"${ctxPath}/common/ajax/sendFindBackPasswordEmail",
			data:{
				myEmail:email
			},
			success:function(json){
				console.log(json);
				
			}
		});
	}
	</script>
	<style type="text/css">
	.panel-default{
		border:none;
		background-color: #ffffff;
		/*IE 7 AND 8 DO NOT SUPPORT BORDER RADIUS*/
		-moz-box-shadow: 0px 0px 17px #000000;
		-webkit-box-shadow: 0px 0px 17px #000000;
		box-shadow: 0px 0px 17px #000000;
		/*IE 7 AND 8 DO NOT SUPPORT BLUR PROPERTY OF SHADOWS*/
		
	}
	</style>
  </head>
  
  <body style="padding-top:100px;background-color: #3D4E64;">
	 	<!-- 导航栏 -->
	<%-- <jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include> --%>

	<div class="container-fluid login-container" >
	<div class="row-fluid"> </div>
	<div class="row-fluid">
		<div class="col-md-4">
		</div>
		<div class="col-md-4 ">
		<div class="col-md-12 ">
		<div class="panel panel-default" >
			<div class="login-head panel-heading " style="background-color:#2C382D">
				
					<h4>欢迎回来 OES   <span class="glyphicon glyphicon-home" style="float:right;margin-right:10px;cursor: pointer;" onclick="backHome()"></span> </h4>
				
			</div>
			
			 <div class="panel-body">
			 <form class="form-horizontal" id="memberLoginForm">
			 
				  <div class="form-group">
				    <label for="userCode" class="col-sm-3 control-label"><span class="glyphicon glyphicon-user" style="font-size: 20px;"></span></label>
				    <div class="col-sm-8" id="div_input_username">
				      <input type="text" class="form-control" id="userEmail" name="userCode" placeholder="UserEmail" onblur="isInputNull('div_input_username')" onChange="isInputNull('div_input_username')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="userPwd" class="col-sm-3 control-label"><span class="glyphicon glyphicon-lock" style="font-size: 20px;"></span></label>
				    <div class="col-sm-8" id="div_input_password">
				      <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="Password" onblur="isInputNull('div_input_password')" onChange="isInputNull('div_input_password')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>
				    </div>
				  </div>
			  	  <div class="form-group">
				    <div class="col-md-offset-1 col-md-10">
				    	<div style="height: 35px;">
						 锁定当前设备： <input   type="checkbox" id="input-checkbox" name="autoLogin" value="true"/> 
						</div>
				    </div>
				  </div>	
				  <div class="form-group">
				  	<div class=" col-sm-1"></div>
				  	<div class="col-sm-10">
					  	<div class="btn-group col-sm-12" role="group" aria-label="...">
						 	<button id="login-btn" type="button" class="btn btn-primary col-md-9 col-sm-9" onclick="submitForm()">确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认</button>
							<button  type="button" class="btn btn-info" onclick="findBackPassword()"
					    		data-toggle="tooltip" data-placement="top" title="找回密码">
					    		<span class="glyphicon glyphicon-ice-lolly-tasted" style="line-height: inherit;"></span>
					    	</button>
						</div>
					</div>
				 	<div class=" col-sm-1"></div>
				  </div>
			</form>
			</div>
			
		</div>
		</div>	
		</div>
		
		
		<div class="col-md-4">
			<div class="col-sm-5 alert alert-danger hidden" role="alert" id="loginErrorInfo" >
				<!-- 登录失败提示信息 -->
			</div>
		</div>
		
		
	</div>
	</div>

 	<!-- footer -->
	<%-- <jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include> --%>
	
	<!-- Modal -->
	<div class="modal fade" id="find-password-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog  " role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">找回钥匙 </h4>
	      </div>
	      <div class="modal-body">
	        <div class="container-fluid">
				 <div class="input-group">
				      <input type="text" id="myEmail" class="form-control" placeholder="接下来的取得钥匙的传送门将发送到你邮箱">
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button" onclick="sendEmail();">
				        	&nbsp;
							<span class="glyphicon glyphicon-share-alt"></span>
							&nbsp;
						</button>
				      </span>
				 </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
  </body>
</html>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
<script src="res/plug-in/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('[data-toggle="tooltip"]').tooltip()
		logined();
		$('[type="checkbox"]').bootstrapSwitch();
	});
</script>

