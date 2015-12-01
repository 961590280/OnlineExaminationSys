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
    <title>OES 登录</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	

	<script type="text/javascript">
	//rediect index page
	if(window.top != window) window.top.location.href=window.location.href;
	<%if("2".equals(err)){%>
		alert("SESSION超时，请重新登陆！");
	<%}else if (rdf != null && "2".equals(rdf.getResult())) {%>
		alert("<%=rdf.getResultInfo()%>");
	<%}%>
		function submitForm() {
			
			var userCode = $('#userCode').val();
			var userPwd = $('#userPwd').val();
			var autoLogin = $("input[name='autoLogin']:checked").val();
			
			
			if (userCode=="" || userPwd == "") {
				
				  isInputNull("div_input_username");
				  isInputNull("div_input_password");
				  
				
				
			}else{
				$.post("${ctxPath}/common/ajax/memberLogin",
						{userCode:userCode,userPwd:userPwd,autoLogin:autoLogin},
						function(data){
							var errorInfo = $("#loginErrorInfo");//错误提示框
							data = eval("("+data+")");
							if(data["result"] == 1){
								location.href = "${ctxPath}/common/toPersonalPage";
							}else{
								errorInfo.html(data["resultInfo"]);
								errorInfo.removeClass("hidden");
								errorInfo.addClass("show");	
							}
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
	
	</script>
	<style type="text/css">
	
	body { padding-top: 70px; }
	</style>
  </head>
  
  <body >
	 	<!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>

	<div class="container-fluid login-container" >
	<div class="row-fluid">
		<div class="col-md-4">
		</div>
		<div class="col-md-4 ">
		<div class="panel panel-default">
			<div class="login-head panel-heading "><h4>欢迎登录 OES</h4></div>
			
			 <div class="panel-body">
			 <form class="form-horizontal" id="memberLoginForm">
			 
				  <div class="form-group">
				    <label for="userCode" class="col-sm-3 control-label">用  户  名</label>
				    <div class="col-sm-8" id="div_input_username">
				      <input type="text" class="form-control" id="userCode" name="userCode" placeholder="UserName" onblur="isInputNull('div_input_username')" onChange="isInputNull('div_input_username')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="userPwd" class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</label>
				    <div class="col-sm-8" id="div_input_password">
				      <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="Password" onblur="isInputNull('div_input_password')" onChange="isInputNull('div_input_password')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>
				    </div>
				  </div>
			  	  <div class="form-group">
				    <div class="col-md-offset-2 col-md-10">
				    	<label class="checkbox-inline">
						  <input  type="checkbox" id="input-checkbox" name="autoLogin" value="true"/> 未来 1 周自动登录
						</label>
				    </div>
				  </div>	
			  		
				  <div class="form-group">
				 
				  	<div class=" col-sm-1"></div>
				    <div class=" col-sm-10"><button type="button" class="btn btn-info btn-block" onclick="submitForm()">登&nbsp; 录</button></div>
				 	<div class=" col-sm-1"></div>
				  </div>
			</form>
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
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
  </body>
</html>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
