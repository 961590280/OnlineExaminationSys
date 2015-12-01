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
	/** 读取用户数据 用户名，头像，标签**/
	function getUserInfo(){
		
		var arr=["primary","success","info","warning","danger"];
		$.ajax({
		
			url:"${ctxPath}/common/ajax/getPersonalInfo",
			success:function(data){
				data = eval("("+data+")");
				//console.log(data);
				$("#user_name").text(data["resultObj"].userName);
				$("#head_img").attr("src","res/personal-img/"+data["resultObj"].userHead);
			}
		
		});
		
		$.ajax({
			
			url:"${ctxPath}/common/ajax/getPersonalTag",
			success:function(data){
				data = eval("("+data+")");
				data = data["resultObj"];
				var html ="";
				console.log(data);
				
				if(data.length==0){
					html="<span ><a>创建</a>个人标签</span>";
					
				}
				for(var key in data){
					html+="<span class='label label-"+arr[key%5]+"'>"+data[key].name+"</span>";
				}
				$("#tags").html(html);
			}
		
		});
	}
	
	//文档加载完后
	$(document).ready(function (){
	
		getUserInfo();
		loadLikeExams();
		getPersonalExamRecords();
	});
//加载【猜你喜欢】 中的测验数据
function loadLikeExams(){
 	var id = "examList";
	
	$.ajax({
		
			url:"${ctxPath}/common/ajax/getExams",
			success:function(data){
				data = eval("("+data+")");
				var html = "";
				for(var temp in data["resultObj"]){
					html +="<tr id = \"examPid_"+data["resultObj"][temp]["uuid"]+"\" ><td class=\"col-md-6 col-xs-12\">"+"<a href='${ctxPath}/common/toExamPage?examPid="+data["resultObj"][temp]["uuid"]+"'>"+data["resultObj"][temp]["examName"]+"</a></td><td class=\"col-md-5 col-xd-10\">";
					html +="</td><td class=\"col-md-1 col-xs-2 personal-star-td\"><a href='javascript:void(0)' onclick='collectionExam("+data["resultObj"][temp]["uuid"]+")'><span class=\"glyphicon glyphicon-star-empty\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"点击收藏\" ></span></a></td></tr>";
				}
				$("#"+id).html(html);
				$('[data-toggle="tooltip"]').tooltip();//在文档充新加载完后执行
			}
		
		});
	
}
/** 收藏测验 **/
function collectionExam(examPid){
	
	$.ajax({
		url:"${ctxPath}/common/ajax/collectionExam",
		data:{examPid:examPid},
		success:function(data){
			data = eval("("+data+")");
			console.log(data)
			if(data["result"] == 2){
				
				alert(data["resultInfo"]);
				
			}else{
				$("tr#examPid_"+examPid+" td.personal-star-td span").removeClass("glyphicon-star-empty").addClass("glyphicon-star").attr("data-original-title","取消收藏");
				$("tr#examPid_"+examPid+" td.personal-star-td a").attr("onclick","unCollectionExam("+examPid+")");
			}
		}
		
	});
	
	
}
/** 取消收藏 **/
function unCollectionExam(examPid){

	$.ajax({
		url:"${ctxPath}/common/ajax/unCollectionExam",
		data:{examPid:examPid},
		success:function(data){
			data = eval("("+data+")");
			console.log(data)
			if(data["result"] == 2){
				
				alert(data["resultInfo"]);
				
			}else{
			
				$("tr#examPid_"+examPid+" td.personal-star-td span").removeClass("glyphicon-star").addClass("glyphicon-star-empty").attr("data-original-title","点击收藏");
				$("tr#examPid_"+examPid+" td.personal-star-td a").attr("onclick","collectionExam("+examPid+")");
			}
		}
		
	});

	
}
/** 加载个人测验记录  分页**/
var pageNum = 0;
var pageSize = 5;
function getPersonalExamRecords(){
	
	$.ajax({
		
			url:"${ctxPath}/common/ajax/getPersonalExamRecordList",
			data:{pageNum:pageNum},
			success:function(data){
				
				
				
				data = eval("("+data+")");
				console.log(data);
				var html = "";
				for(var temp in data["resultObj"]){
					
					
					html +="<tr ><td class=\"col-md-1 \"><a href=\"javascript:void(0)\" onclick=\"alert();\" class=\"remove-record-btn\" style=\"display:none;\"><span class=\"glyphicon glyphicon-minus-sign\"></span></a> </td><td style=\"text-align:center;\"  class=\"col-md-7\">  <a href=\"${ctxPath}/common/toExamRecordInfoPage?createTime="+data["resultObj"][temp]["createTime"]+"&examPid="+data["resultObj"][temp]["examPid"]+"\">"+data["resultObj"][temp]["examName"]+"</a></td><td class=\"col-md-4\">"+data["resultObj"][temp]["createTime"]+"</td></tr>";
					
				}
				if(pageNum == 0){
					
					$("#examRecordList").html(html);
				}else{
					$("#more-records").remove();
					$("#examRecordList").append(html);
				}
				if(data["resultObj"] == null||data["resultObj"].length<5){
					$("#examRecordList").append("<tr style=\"background-color: white;\"  id=\"more-records\"><td  class=\"col-md-12 no-more-record\" colspan=\"3\"> 没有更多 </td></tr>")
				}else{
					$("#examRecordList").append("<tr style=\"background-color: white;\" id=\"more-records\"><td  class=\"col-md-12 \" colspan=\"3\"> <button  type=\"button\" class=\"btn btn-default  btn-sm btn-block\" onclick=\"getPersonalExamRecords()\">更多 <span class=\"glyphicon glyphicon-menu-down\"></span></button></td></tr>")
					
				}
				
				pageNum ++;
				
			}
		
		});
}

/* 刷新测验记录列表  */
function refleshRecords(){
	pageNum = 0;
	getPersonalExamRecords();
}
/* 编辑测验记录 */
function editRecords(){
	/* $(".remove-record-btn").each(function(){
		$(this).css("display","block");
	}); */
}
/* 刷新猜你喜欢列表  */
function refleshLike(){
	pageNum = 0;
	loadLikeExams();
}
	</script>
	<style type="text/css">

	#tags span{ margin-left:5px;line-height: 2;}
	</style>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	
	
	<div class="container-fluid personal-contianer">
		<div class="row">
			<div class="col-xs-12 col-md-2" style="margin-bottom: 20px;">
				<!-- 头像 -->
					<div class="col-xs-6 col-md-12">
					<img id="head_img" src=""  class="img-rounded" style="width: 100%;border: 1px solid #A5A5A5;">
					</div>
				
					<!-- 用户昵称 -->
					<div class="col-xs-6 col-md-12">
						<div class="col-xs-12">
						<h2 id="user_name"></h2>
						</div>
						<div class="col-xs-12">
						<!-- 标签区 -->
							<span class="glyphicon glyphicon-tags"></span>
							<div id="tags" class="col-md-12">
							
							</div>
							
							
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
				  <li role="presentation"><a href="#">我的圈子</a></li>
				</ul>
				</div>
				
				<!-- 加个面板 -->
				<div class="col-md-6" style="margin-top:20px;">
					<div class="panel panel-info personal-panel ">
					  <div class="panel-heading">
					  	<span class="glyphicon glyphicon-tasks"></span> &nbsp; 测验记录
					  	  <div  class="btn-group panel-menu-group" role="group">
						    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="caret"></span></button>
						    <ul class="dropdown-menu">
						      <li><a href="javascript:void(0)" onclick="refleshRecords()">刷新</a></li>
						      <li><a href="javascript:void(0)" onclick="editRecords()">编辑</a></li>
						    </ul>
						  </div>
					  </div>
					  <div class="panel-body">
						    <h4>测验按照从近到远的时间顺序排列</h4>
					  </div>
					   <table class="table personal-like-table table-hover" >
					   <tbody id="examRecordList" >
					   		<tr><td>暂无记录</td></tr>
					   		
					   </tbody>
					  </table>
					</div>
				</div>
				
				<div class="col-md-6" style="margin-top:20px;">
					<div class="panel panel-danger personal-panel">
					  <div class="panel-heading">
					  	<span class="glyphicon glyphicon-heart"></span> &nbsp; 猜你喜欢
					  	
					  	<a style="float:right;color:#A94442;" href="javascript:refleshLike();" ><span class="glyphicon glyphicon-refresh"></span></a>
					  </div>
					  <div class="panel-body">
					  	 <h4>通过您给自己添加的标签与平时的收藏，我们会为您推荐您感兴趣的测验</h4>
					  </div>
					  <table class="table personal-like-table table-hover" >
					   <tbody id="examList" >
					   		<tr style="background-color: white;"><td>
					   			<div class="well well-lg error-well" >
					   			暂无推荐<br/>您可以在 <a href="#" ><strong>测验资源</strong></a> 查看各种分类的资源或者直接在导航栏中进行站内<a href=""><strong>搜索</strong></a>您想要的内容
					   			</div>
					   			
					   		
					   		</td></tr>
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

  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
