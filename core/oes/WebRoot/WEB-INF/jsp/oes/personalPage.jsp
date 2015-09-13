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
	$(function () {
	  $('[data-toggle="tooltip"]').tooltip();
	})
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
	/**读取用户可参加的测验**/
	$(document).ready(function (){
		$.ajax({
		
			url:"${ctxPath}/common/ajax/getExams",
			success:function(data){
				isInputNull(1);
				data = eval("("+data+")");
				loadLikeExams(data,"examList","${ctxPath}/common/toExamPage?examPid=");
			}
		
		});
	
	});
	//加载【猜你喜欢】 中的测验数据
function loadLikeExams(data,id,url){
	var html = "";
	for(var temp in data["resultObj"]){
		html +="<tr><td class=\"col-md-6 col-xs-12\">"+"<a href='"+url+data["resultObj"][temp]["uuid"]+"'>"+data["resultObj"][temp]["examName"]+"</a></td><td class=\"col-md-5 col-xd-10\">";
		html +="</td><td class=\"col-md-1 col-xs-2 personal-star-td\"><span class=\"glyphicon glyphicon-star-empty\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"点击收藏\" ></span></td></tr>";
	}
	$("#"+id).html(html);
	$('[data-toggle="tooltip"]').tooltip();//在文档充新加载完后执行
	
}
	</script>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	
	
	<div class="container-fluid personal-contianer">
		<div class="row">
			<div class="col-xs-12 col-md-2" style="margin-bottom: 20px;">
				<!-- 头像 -->
					<div class="col-xs-6 col-md-12">
					<img src="res/testimg.png" alt="..." class="img-rounded" style="width: 100%;">
					</div>
				
					<!-- 用户昵称 -->
					<div class="col-xs-6 col-md-12">
						<div class="col-xs-12">
						<h2>easyLife</h2>
						</div>
						<div class="col-xs-12">
							<span class="glyphicon glyphicon-tags"></span>
							
							
						</div>
					</div>
					
				
			</div>
			<div class="col-xs-12 col-md-10">
				<div class="row-fluid">
				<!-- 加标签 tab -->
				<ul class="nav nav-tabs personal-tab">
				  <li role="presentation" class="active"><a href="#">个人测验</a></li>
				  <li role="presentation"><a href="#">考试信息</a></li>
				  <li role="presentation"><a href="#">订阅资料</a></li>
				</ul>
				</div>
				
				<!-- 加个面板 -->
				<div class="row-fluid" style="margin-top:20px;">
					<div class="panel panel-info personal-panel">
					  <div class="panel-heading">
					  	<span class="glyphicon glyphicon-tasks"></span> &nbsp; 测验记录
					  </div>
					  <div class="panel-body">
						    <h4>测验按照从近到远的时间顺序排列</h4>
					  </div>
					   <table class="table personal-like-table" >
					   <tbody id="oidExamList">
					   		<tr><td>暂无记录</td></tr>
					   </tbody>
					  </table>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="panel panel-danger personal-panel">
					  <div class="panel-heading">
					  	<span class="glyphicon glyphicon-heart"></span> &nbsp; 猜你喜欢
					  </div>
					  <div class="panel-body">
					  	 <h4>通过您给自己添加的标签与平时的收藏，我们会为您推荐您感兴趣的测验</h4>
					  </div>
					  <table class="table personal-like-table" >
					   <tbody id="examList" >
					   		<tr><td>暂无推荐<br/>您可以在 <a href="#" ><strong>测验资源</strong></a> 查看各种分类的资源或者直接在导航栏中进行站内<a href=""><strong>搜索</strong></a>您想要的内容</td></tr>
					   		<!-- <tr><td class="col-md-3 col-xs-5">xxx测验</td><td class="col-md-7 col-xs-6"> <span class="label label-danger personal-like-label">java</span> <span class="label label-default personal-like-label">编程语言</span> <span class="label label-success personal-like-label">面向对象编程</span>  </td><td class="col-md-1 col-xs-1 personal-star-td"><span class="glyphicon glyphicon-star-empty" data-toggle="tooltip" data-placement="bottom" title="点击收藏"></span></td></tr>
					  		<tr><td class="col-md-6">xxx测验</td><td class="col-md-3"></td><td class="col-md-1 personal-star-td"><span class="glyphicon glyphicon-star"></span></td></tr> -->
					   </tbody>
					  </table>
					</div>
				</div>
				
				
				
					
			
			</div>
		</div>
	
	</div>
<div >

</div>

<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
<!--  <input type="button" style="float: right;visibility: hidden;" value="刷新url缓存" onclick="refreshUrlCahce();">
  -->
  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
