<%@ page language="java" import="java.util.*" import="com.cw.oes.form.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String err = request.getParameter("err");
ResponseDataForm rdf = (ResponseDataForm) request.getAttribute("responseDataForm");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html style="height:100%;">
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	//rediect index page
	if(window.top != window) window.top.location.href=window.location.href;
	<%if("2".equals(err)){%>
		alert("SESSION超时，请重新登陆！");
	<%}else if (rdf != null && "2".equals(rdf.getResult())) {%>
		alert("<%=rdf.getResultInfo()%>");
	<%}%>
		function submitForm() {
		if (!$('#userCode').val()) {
			alert("用户名不能为空！");
			return false;
		} else if (!$('#userPwd').val()) {
			alert("密码不能为空！");
			return false;
		} else {
		
			$('#formLogin').submit();
		}
	}

	
	</script>
  </head>
  
  <body style="padding: 0;margin: 0;height:100%;">
  	<div style="margin: 0;height:100%;text-align: center;">
  	<div style="margin: 0 ;height:30%;text-align: center;">
  	<br/>
  	<br/>
  	<h1 style="margin: 0;">在线考试系统</h1>
  	</div>
  	<div >
	 <form id="formLogin" action="${ctxPath }/common/memberLogin" method="post">
	 
		 用户名:<input type="text" id="userCode" name="userCode"/><br/>
		 &nbsp;密&nbsp;码&nbsp;:<input type="text" id="userPwd" name="userPwd"/><br/>
	 	<input type="button" value="登录" onclick="submitForm()"/>
	 </form>
	 </div>
	 </div>
  </body>
</html>
