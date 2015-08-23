<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	function refreshUrlCahce(){
		$.ajax({
		url:"${ctxPath}/common/ajax/refreshCache",
		data:{cacheName:"com.cw.oes.cache.impl.UrlMappingCache"},
		success:function(data){
			data =eval ("(" + data + ")");//将json 转为js对象
			if(data.result=='1'){
				alert("刷新成功");
			}else{
				alert(data.resultInfo);
				
			}
			console.log(data.result);
		},
		error:function(){
			alert("刷新失败");
		}
		});
		
		
		
	
	}
	
	</script>
  </head>
  
  <body>
Welecome your personPage

<a href="${ctxPath}/common/toExaminationPage">去考试</a><br/>
<input type="button" style="float: right;" value="刷新url缓存" onclick="refreshUrlCahce();">
  </body>
</html>
