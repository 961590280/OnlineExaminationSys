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
	<script src="res/plug-in/ace-admin/assets/js/ace-extra.min.js"></script>
	<style type="text/css">

	#tags span{ margin-left:5px;line-height: 2;}
	
	.exam-info-panel{
		
	}
	.exam-info-panel .panel {
		border-radius: 0px;
	}
	.exam-info-panel .panel-heading{
		text-align: center;
		height: 55px;
		line-height: 55px;
		padding: 0px;
		font-size: 16px;
		border-radius: 0px;
	}
	.exam-info-panel .panel-footer{
		padding:5px;
		border-radius: 0px;
	}
	.exam-info-panel .panel-footer button{
		border-radius: 0px;
	}
	.panel-info{
	}
	.bg-info{
		background-color: #d9edf7;
	}
	/* success */
	.panel-success .panel-footer{
		background-color: #5cb85c;
		border-color: #5cb85c;
	}
	.panel-success > .panel-heading {
	    color: #fff;
	    background-color: #5cb85c;
		border-color: #5cb85c;
	}
	/* primary */
	.panel-primary .panel-footer{
		background-color: #337ab7;
		border-color: #337ab7;
	}
	.panel-primary > .panel-heading {
	    color: #fff;
	    background-color: #337ab7;
		border-color: #337ab7;
	}
	/* info */
	.panel-info .panel-footer{
		background-color: #5bc0de;
		border-color: #5bc0de;
	}
	.panel-info > .panel-heading {
	    color: #fff;
	    background-color: #5bc0de;
		border-color: #5bc0de;
	}
	/* warning */
	.panel-warning .panel-footer{
		background-color: #f0ad4e;
		border-color: #f0ad4e;
	}
	.panel-warning > .panel-heading {
	    color: #fff;
	    background-color: #f0ad4e;
		border-color: #f0ad4e;
	}
	/* danger */
	.panel-danger .panel-footer{
		background-color: #d9534f;
		border-color: #d9534f;
	}
	.panel-danger > .panel-heading {
	    color: #fff;
	    background-color: #d9534f;
		border-color: #d9534f;
	}
	
	.price{
		height: 20px;
		line-height: 20px;
		font-size: 20px;
		text-align: center;
		font-family: 'Open Sans';
	}
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
					<img id="head_img" src=""  class="img-rounded" style="width: 100%;height: 150px;">
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
							<div class="col-md-12" style="margin-top:5px;">
								<button class="btn btn-sm btn-default btn-block" onclick="setTag()" data-toggle="tooltip" data-placement="bottom" title="标签">管理个人标签</button>
							</div>
						</div>
					</div>
					
				
			</div>
			<div class="col-xs-12 col-md-10">
				<div class="row-fluid">
				<!-- 加标签 tab -->
				<ul class="nav nav-tabs personal-tab">
				  <li role="presentation" class="active tab1"><a href="javascript:void(0)" onclick="personalExamTab();">个人测验</a></li>
				  <li role="presentation" class="tab2"><a href="javascript:void(0)" onclick="examInfoTab();">考试信息</a></li>
				  <li role="presentation" class="tab3"><a href="javascript:void(0)" onclick="subscriptionMaterialTab();">订阅资料</a></li>
				  <li role="presentation" class="tab4"><a href="javascript:void(0)" onclick="myCircleTab();">我的圈子</a></li>
				</ul>
				</div>
				
				
				
				<!-- 标签内容div  -->
				<!-- 标签页 个人测验 -->
				<div class="row-fluid tab-container tab1">
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
						  	
						  	<a style="float:right;color: white;" href="javascript:refleshLike();" ><span class="glyphicon glyphicon-refresh"></span></a>
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
						   			
						   		
						   			</td>
						   		</tr>
						   		</tbody>
						  </table>
						</div>
					</div>
				
				</div>
				
				
				<!-- 标签页  考试信息-->
				<div class="row-fluid tab-container tab2">
					<div class="col-md-12" >
						<div class="form-group col-md-12" style="margin: 20px 0 20px 0;">
					      <input id="searchExam" type="text" class="form-control" autocomplete="off" onfocus="searchAutoComplete(this)" onblur="removeAutoComplete()" placeholder="请输入一个关键字，让我们帮你查找" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"/>
					      <ul id="autocomplete-ul" class="dropdown-menu" style="margin-left: 15px;width: 300px;">
					      	 <li class="dropdown-header"><i>无搜索结果</i></li>
					      </ul>
					    </div>
					</div>
					<div class="col-md-12" id="exams-list">
						<div id="search-error">
							<p style="min-height: 300px;line-height: 300px;font-size: 40px;text-align: center;"> 还不知道客官您的喜好，请手动搜索一下吧  </p>
							<p style="font-size: 40px;text-align: right;">≥﹏≤</p>
						</div>
						<div class="col-md-6 exam-info-panel " id="exam-list-1">
						</div>
						
						<div class="col-md-6 exam-info-panel " id="exam-list-2">
						</div>
						
					</div>
				</div>
				<!-- 标签页  订阅资料-->
				<div class="row-fluid tab-container tab3">
					
				</div>
				<!-- 标签页  我的圈子-->
				<div class="row-fluid tab-container tab4">
					<h1>敬请期待...</h1>
				</div>
					
			
			</div>
		</div>
	
	</div>
<div >

</div>


	<!-- Modal -->
	<div class="modal fade" id="tags-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog  " role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">创建标签</h4>
	      </div>
	      <div class="modal-body">
	        <div class="container-fluid">
				<!-- 搜索div -->
				<div class="row">
					<div class="input-group">
				     <input type="text" id="search-tag-key" class="form-control" placeholder="请输入关键字">
				      <span class="input-group-btn">
				        <button class="btn btn-default" type="button" onclick="searchTags();">
				        	&nbsp;
							<span class="glyphicon glyphicon-search"></span>
							&nbsp;
						</button>
				      </span>
				    </div>
				</div>
				<!-- <div class="row" style="margin-top: 10px;" id="my-tags">
					<div >
					
						<h4>我的标签:</h4> <button type="button" class="btn btn-default btn-xs">java</button>
					</div>
				</div> -->
				<!-- 搜索结果 -->
				
				<div class="row" style="margin-top: 10px;">
					<div class="col-md-12 well center-block" id="search-tags-resualt">
						<div class="col-sm-5 alert alert-danger hidden" role="alert" id="serach-tag-error-info" >
							<!-- 登录失败提示信息 -->
						</div>
					</div>	 
				</div>
					
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
<script type="text/javascript" src="res/js/personal.js"></script>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
<script type="text/javascript">
function searchTags(){
	$("#serach-tag-error-info").addClass("hidden");
	var key = $("#search-tag-key").val();
	if(key!= null && key != ""){
		$.ajax({
			url:"${ctxPath}/common/ajax/searchTags",
			data:{key:key},
			success:function(json){
				json =eval("("+json+")");
				console.log(json);
				if(json.result == 1){
					var html = "";
					if(json.resultObj.length >0 ){
						var tags =  json.resultObj;
						for(var i in tags){
							html +="<button type=\"button\" class=\"btn btn-default btn-xs\" onclick=\"addTag('"+tags[i].uuid+"')\">"+tags[i].name+"</button> \n";
						}
					}else{
						html = "搜索\""+key+"\"关键字结果为空";
					}
					$("#search-tags-resualt").html(html);
				}else{
					$("#serach-tag-error-info").removeClass("hidden").text(json.resultInfo);
				}
			}
		});
	}
	return;
}
function addTag(tagId){
	$.ajax({
		url:"${ctxPath}/common/ajax/addTag",
		data:{
			tagId:tagId
		},
		success:function(json){
			json = eval("("+json+")");
			console.log(json);
			if(json.result == 1){
				
				alert("添加成功");
			}else{
				alert(json.resultInfo);
			}
		}
	})
}
</script>

  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
