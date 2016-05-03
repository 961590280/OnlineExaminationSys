<%@ page language="java" import="java.util.*" import="com.cw.oes.form.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String err = request.getParameter("err");
ResponseDataForm rdf = (ResponseDataForm) request.getAttribute("responseDataForm");
String verifyCode = request.getParameter("verifyCode");
if(verifyCode == null ){
	verifyCode = "";
}else{
	verifyCode = verifyCode.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "").replaceAll(" ", "").replaceAll("\\s", "");

}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!-- 引入top.jsp页面  -->
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/top.jsp"></jsp:include>
    <title>OES 找回钥匙</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	

	<script type="text/javascript">

	
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
		<div class="col-md-3">
		</div>
		<div class="col-md-6 ">
		 <h1 class="text" style="font-size:30px;font-weight: bold; text-align: center;">重新设置您的密码</h1>
		 <form class="form-horizontal" id="memberLoginForm" >
			<div class="form-group">
			    <label for="userCode" class="col-sm-3 control-label">
			    	新密码：
			    </label>
			    <div class="col-sm-8" id="div-input-password1">
			      <input type="text" autocomplete="off"  class="form-control" id="user-password1" name="userPassword"  placeholder="new" onblur="isInputNull('div-input-password1')" onChange="isInputNull('div-input-password1')">
			      <span class="" aria-hidden="false" id="glyphicon" ></span>			    
			    </div>
			  </div>
			  <div class="form-group">
			   <label for="userCode" class="col-sm-3 control-label">
			    	确认一遍：
			    </label>
			    <div class="col-sm-8" id="div-input-password2">
			      <input type="password" class="form-control" id="user-password2"  name="userPwdComfirRegister" placeholder="sure?" >
			      <span class="" aria-hidden="false" id="glyphicon" ></span>
			    </div>
			  </div>
			  
	    	  <div class="form-group">
			  	<div class=" col-sm-8"></div>
			    <div class=" col-sm-2"><button type="button" class="btn btn-success btn-block" onclick="resetPassword()">确&nbsp; 认</button></div>
			  </div>
		</form>
		</div>
		
		
		<div class="col-md-3" style="padding-top: 100px;">
			<div class="col-sm-5 alert alert-danger hidden" role="alert" id="error-info" >
			
			</div>
			<div class="col-sm-5 alert alert-success hidden" role="alert" id="success-info" >
			
			</div>
		</div>
		
		
	</div>
	</div>

 	<!-- footer -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
	<script>
	var verifyCode = "<%= verifyCode%>";
	var passwordWrong = false;
	function resetPassword(){
		console.log("1");
		if(verifyCode == ""){
			alert("当前页面已失效");
		}else{
			if(!isPasswordValified("div-input-password1")){
				$("#error-info").removeClass("hidden").text("非法密码");
				return;
			}
			var password1 = $("#user-password1").val();
			var password2 = $("#user-password2").val();
			console.log(password1);
			console.log(password2);
			if(password1 != password2){
				$("#error-info").removeClass("hidden").text("请重新确认");
				$("#success-info").addClass("hidden");
				return;
			}
			
			
			$.ajax({
				url:"${ctxPath}/common/ajax/resetPassword",
				data:{
					verifyCode:verifyCode,
					password:password1
				},
				success:function(json){
					json = eval("("+json+")");
					console.log(json);
					if(json.result == 1){
						$("#error-info").addClass("hidden");
						$("#success-info").removeClass("hidden").text("修改成功");
					}else{
						alert(json.resultInfo);
					}
				}
			});
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
	</script>
  </body>
</html>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
