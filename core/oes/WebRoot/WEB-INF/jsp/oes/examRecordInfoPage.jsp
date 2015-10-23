<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
     <!-- 引入top.jsp页面  -->
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/top.jsp"></jsp:include>
    <title>欢迎使用 OES</title>
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
	
	</script>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	
	
	<div class="container-fluid personal-contianer">
		<div class="row">
			
			
			<div class="col-md-3"></div>
			<div class="col-md-6" style="text-align: center;"><h1>xxx测验</h1></div>
			<div class="col-md-3"><h3>时间：xxxx-xx-xx</h3></div>
		
			
		
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-2">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					 <div class="btn-group" role="group" aria-label="...">
					 <div class="btn-group" role="group">
					    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					      <span class="glyphicon glyphicon-th-list"></span>
					      <span class="caret"></span>
					    </button>
					    <ul class="dropdown-menu">
					      <li><a href="#">显示全部题目</a></li>
					      <li><a href="#">显示答错题目</a></li>
					    </ul>
					  </div>
					 </div>
  					
				</div>
			</div>
			<div class="col-md-6"></div>
			<div class="col-md-2">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					 <div class="btn-group" role="group" aria-label="...">
					 	<button type="button" class="btn btn-default">
					 		<span class="glyphicon glyphicon-th-large"></span>
					 	
					 	</button>
					 	<button type="button" class="btn btn-default">
					 		<span class="glyphicon glyphicon-th-large"></span>
					 	</button>
					 </div>
  					
				</div>
			
			</div>
			<div class="col-md-1">
			
			</div>
		</div>
		<!-- 内容部分 -->
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			<div class="row">
			<h3>1.下面哪些是Thread类的方法（）</h3>
			
			<div class="btn-group" role="group" aria-label="...">
		 	<button type="button" class="btn btn-default">
		 		<span class=" glyphicon glyphicon-pencil"></span>
		 	
		 	</button>
			</div>
			<h4>row</h4>
			<h4>row</h4>
			<h4>row</h4>
			<h4>row</h4>
			
			</div>
			
			</div>
			<div class="col-md-2"></div>
			
		</div>


	</div>

<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
<!--  <input type="button" style="float: right;visibility: hidden;" value="刷新url缓存" onclick="refreshUrlCahce();">
  -->
  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
