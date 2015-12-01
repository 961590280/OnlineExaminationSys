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
    <title>OES 注册</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	
	

	<script type="text/javascript">
	//错误提示框
	//rediect index page
	if(window.top != window) window.top.location.href=window.location.href;
	<%if("2".equals(err)){%>
		alert("SESSION超时，请重新登陆！");
	<%}else if (rdf != null && "2".equals(rdf.getResult())) {%>
		alert("<%=rdf.getResultInfo()%>");
	<%}%>
		function submitForm() {
			
			var userEmail = $('#userEmailRegister').val();
			var userPwd = $('#userPwdRegister').val();
			var userPwdComfir = $('#userPwdComfirRegister').val();
			var errorInfo = $("#registerErrorInfo");
			var varified1 = isPasswordComfir('div_input_password','div_input_password_comfir');
			var varified2 = isPasswordValified('div_input_password');
			var varified3 = isEmailValified('div_input_email');
			
			
			if (userEmail=="" || userPwd == "" || userPwdComfir == "") {
				
				  isInputNull("div_input_email");
				  isInputNull("div_input_password");
				  isInputNull("div_input_password_comfir");
				  
				
				
			}else if(!varified1||!varified2||!varified3){
				
				var error = "";
				if(isUsed){
					error+="邮箱已被使用！！<br/>";
				}
				
				if(emailWrong){
					error+="邮箱不合法！！<br/>";
				}
				if(passwordWrong){
					error+="密码不合法！！<br/>";
				}
				if(passwordComWrong){
					error+="确认密码错误！<br/>"
				}
				errorInfo.html(error);
				errorInfo.removeClass("hidden");
				errorInfo.addClass("show");
			}else{
				$.post("${ctxPath}/common/ajax/memberRegister",
						{userEmail:userEmail,userPwd:userPwd},
						function(data){
							
							data = eval("("+data+")");
							if(data["result"] == 1){
								alert("注册成功,请登录邮箱完成验证操作后才能正常使用账号");
								location.href = "${ctxPath}/common/index";
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
	
		var errorInfo = $("#registerErrorInfo");//错误提示框
		errorInfo.removeClass(ALERT_ERROR);
		errorInfo.html("");
	}
	function closeAlert(){
		var errorInfo = $("#registerErrorInfo");//错误提示框s
		errorInfo.removeClass("show");
		errorInfo.addClass("hidden");	
	}

	var isUsed = false;
	var emailWrong = false;
	var passwordWrong = false;
	var passwordComWrong = false;
	function isEmailValified(divId){
		var email = $("#"+divId+" input").val();
		var filter =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		if(email!=""){
			
			
			$.ajax({
				url:"${ctxPath}/common/ajax/memberIsUsed",
				data:{email:email},
				success:function(data){
					data =eval("("+data+")");
					console.log(data);
					if(data["result"] == 1){//成功则邮箱未被使用
						isUsed = false;
					}else{
					
						isUsed = true;
					}
					
				}
			});
		}
		
		
		if(isUsed){
			verifiedError(divId);
			return false;
		}else if(filter.test(email)){
			verifiedCorrect(divId);
			emailWrong = false;
			return true;
		}else{
			verifiedError(divId);
			emailWrong = true;
			return false;
		}
	}

	function isPasswordValified(divId){
		
		var password = $("#"+divId+" input").val();
		var filter =  /^(?=.{6,16}$)[a-zA-Z][0-9a-zA-Z._]+$/;//以字符开头，6~12位，不能全为同一个字母或数字
		if(filter.test(password)){
			verifiedCorrect(divId);
			passwordWrong = false;
			return true;
		}else{
			verifiedError(divId);
			passwordWrong = true;
			return false;
		}
	}

	function isPasswordComfir(divId,divId1){
		var password = $("#"+divId+" input").val();
		var password1 = $("#"+divId1+" input").val();
		
		if(password1==""){
			verifiedError(divId1);
			return false;
		}
		if(password!=password1){
			verifiedError(divId1);
			passwordComWrong = true;
			return false;
		}else{
			verifiedCorrect(divId1);
		}
		return true;
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
			<div class="login-head panel-heading "><h4>欢迎注册 OES 账号</h4></div>
			
			 <div class="panel-body">
			 <form class="form-horizontal" id="memberRgisterForm">
			 
				  <div class="form-group row">
				  <div class="col-md-12">
				    <label for="userCodeRegister" class="col-sm-3 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
				    <div class="col-md-8" id="div_input_email">
				      <input type="email" class="form-control" id="userEmailRegister" name="userEmailRegister" placeholder="Email" onblur="isEmailValified('div_input_email')" onChange="isEmailValified('div_input_email')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
				    </div>
				    </div>
				    <div class="col-md-8 col-md-offset-3  register-info email">
				    	<p><span class="glyphicon glyphicon-info-sign " aria-hidden="false"  ></span> 请输入在使用中的邮箱，以进行验证操作</p>
				    </div>
				  </div>
				  <div class="form-group row">
				   <div class="col-md-12">
				    <label for="userPwdRgister" class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</label>
				    <div class="col-md-8" id="div_input_password">
				      <input type="password" class="form-control" id="userPwdRegister" name="userPwdRegister" placeholder="Password" onblur="isPasswordValified('div_input_password')" onChange="isPasswordValified('div_input_password')">
				      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
				    </div>
				    </div>
				     <div class="col-md-8 col-md-offset-3  register-info password">
				    	<p>
				    	<span class="glyphicon glyphicon-info-sign " aria-hidden="false"  ></span> 
				    	密码以字母开头，由6~12位数字或字母组成，仅能包含._两种符号
				    	</p>
				     </div>
				  </div>
				  <div class="form-group row">
				   <div class="col-md-12">
				    <label for="userPwdComfir" class="col-sm-3 control-label">确认密码</label>
				    <div class="col-md-8" id="div_input_password_comfir">
				      <input type="password" class="form-control" id="userPwdComfir" name="userPwdComfirRegister" placeholder="PasswordComfir" >
				      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
				    </div>
				    </div>
				     <div class="col-md-8 col-md-offset-3 register-info passwordCom">
				    	<p><span class="glyphicon glyphicon-info-sign " aria-hidden="false"  ></span>
				    	请再次输入密码，以确保密码没有输错	
				    	</p> 
				    </div>
				  </div>	
			  		
				  <div class="form-group">
				 
				  	<div class=" col-sm-1"></div>
				    <div class=" col-sm-10"><button type="button" class="btn btn-success btn-block" onclick="submitForm()">注&nbsp; 册</button></div>
				 	<div class=" col-sm-1"></div>
				  </div>
			</form>
			</div>
			
		</div>	
		</div>
		
		
		<div class="col-md-4">
			<div class="col-sm-5 alert alert-danger hidden" role="alert" id="registerErrorInfo" >
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