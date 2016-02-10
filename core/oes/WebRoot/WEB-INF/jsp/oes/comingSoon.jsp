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
    <title>OES 敬请期待</title>
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
		<div class="col-md-4">
		</div>
		
		
		<div class="col-md-4 ">
		<h1>功能开发中，敬请期待</h1>
		</div>
		
		
		<div class="col-md-4">
			
		</div>
		
		
	</div>
	</div>

 	<!-- footer -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
  </body>
</html>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
