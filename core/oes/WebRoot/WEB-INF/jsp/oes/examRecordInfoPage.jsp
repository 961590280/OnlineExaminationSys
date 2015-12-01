<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String examPid = request.getParameter("examPid");
String createTime = request.getParameter("createTime");

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
	var examPid = '<%=examPid%>';
	var createTime = '<%=createTime%>';
	var indexArr = ['A','B','C','D','E','F','G','H'];//选项序号
	
	$(function () {
		  getExamRecord();
		  $('[data-toggle="tooltip"]').tooltip();//工具提示要调用tooltip方法
	})
	/* 读取测验记录  */
	function getExamRecord(){
		$.ajax({
			url:"${ctxPath}/common/ajax/getPersonalExamRecordInfo",
			data:{examPid:examPid,createTime:createTime},
			success:function(data){
				data = eval("("+data+")");
				data = data.resultObj;
				
				
				
				console.log(data);
				var html = '';
				
				
				$("#examTitle").html(data.examTitle);//测验名称
				$("#date").html(data.date);//考试时间
				var topicsHtml = '';//题目html
				for(var key in data.examPaper.topics){
					var topic = data.examPaper.topics[key];
					var answer = data.answers[parseInt(key)+1];//回答
					//alert()
					//console.log(parseInt(key)+1);
					topicsHtml+="<div class=\"row";
					if(answer==null){
						topicsHtml+=" f-null-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<a href=\"javascript:void(0)\"><span class=\" glyphicon glyphicon-question-sign options-empty\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"没有作答的题目\" ></span></a>";
						
					}else if(answer == topic.correctAnswer){
						topicsHtml+=" f-correct-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<a href=\"javascript:void(0)\"><span class=\" glyphicon glyphicon-ok-sign options-correct\"  ></span></a>";
					}else{
						topicsHtml+=" f-error-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<a href=\"javascript:void(0)\"><span class=\" glyphicon glyphicon-remove-sign options-error\"  ></span></a>";
					}
					topicsHtml += topic.topicTitle+"</h3>";
					
					
					for(var optKey in topic.options){
						if(topic.options[optKey]==null){
							break;
						}
						topicsHtml+="<div class=\"col-md-12 record-options\" ><div class=\"col-md-1\">";
						topicsHtml+="</div><div class=\"col-md-10 options-content ";
						if((parseInt(optKey)+1)==topic.correctAnswer){//如果选项为正确答案则显示正确图标
							
							topicsHtml+="content-correct ";
						}else if(answer ==(parseInt(optKey)+1)&&(parseInt(optKey)+1)!=topic.correctAnswer){//如果选项为正确答案则显示正确图标
							topicsHtml+="content-error ";						
						}
						
						topicsHtml+="\">"+indexArr[optKey]+'.'+topic.options[optKey]+"</div></div>";
					}
					topicsHtml+="</div><div class=\"col-md-4\"><div class=\"col-md-12\">";
					topicsHtml+="<div class=\"btn-group\" role=\"group\" aria-label=\"...\">";
					topicsHtml+="<button  type=\"button\" class=\"btn btn-default record-note\" > <span class=\" glyphicon glyphicon-edit\"></span> 笔记</button>";
					topicsHtml+="<button  type=\"button\" class=\"btn btn-default record-note\" > <span class=\" glyphicon glyphicon-star-empty\"></span> 重点</button>";
					topicsHtml+="</div></div><div class=\"col-md-12\" style=\"margin-top: 20px;\"> <textarea class=\"form-control textarea-note\" rows=\"4\"></textarea></div></div></div>";
				}
				
				$("#topics").html(topicsHtml);
				
			}
		});
	}
	/* 题目显示  */
	function showErrorTopics(){
		$("#topics .row").each(function(){
			if(!$(this).hasClass("f-error-topics")){
				$(this).hide();
			}
			if($(this).hasClass("f-error-topics")){
				alert();
				$(this).show();
			};
		});
		
	}
	function showNullTopics(){
		$("#topics .row").each(function(){
			if(!$(this).hasClass("f-null-topics")){
				$(this).hide();
			}
			if($(this).hasClass("f-null-topics")){
				$(this).show();
			};
		});
	}
	function showAllTopics(){
		$("#topics .row").each(function(){
			$(this).show();
		});
		
	}
	
	</script>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	<div class="exam-record-header">
	<div class="row exam-record-title" >
			
			
			<div class="col-md-3"></div>
			<div class="col-md-6" style="text-align: center;"><h1 id="examTitle"></h1></div>
			<div class="col-md-3"><h4 id="date"></h4></div>
		
			
		
	</div>
	<div class="row menu-bar">
			<div class="col-md-1"></div>
			<div class="col-md-3">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					 <div class="btn-group" role="group" aria-label="...">
					 <div class="btn-group" role="group">
					    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					      <span class="glyphicon glyphicon-th-list"></span>
					      <span class="caret"></span>
					    </button>
					    <ul class="dropdown-menu">
					      <li><a href="javascript:void(0)" onclick="showAllTopics()">显示全部题目</a></li>
					      <li><a href="javascript:void(0)" onclick="showErrorTopics()">显示答错题目</a></li>
					      <li><a href="javascript:void(0)" onclick="showNullTopics()">显示没有答题题目</a></li>
					    </ul>
					    
					    
					    
					  </div>
					  
					  <div class="btn-group" role="group">
					    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					      备用
					      <span class="caret"></span>
					    </button>
					    <ul class="dropdown-menu">
					      <li><a href="#">Dropdown link</a></li>
					      <li><a href="#">Dropdown link</a></li>
					    </ul>
					  </div>
					 </div>
  					
				</div>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-3">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					 <div class="btn-group" role="group" aria-label="...">
					 	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="通过邮件分享给好友">
					 		<span class=" glyphicon glyphicon-share"> </span> 分享
					 	
					 	</button>
					 	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="导出Word文件">
					 		<span class="glyphicon glyphicon-download-alt"> </span> 导出
					 	</button>
					 	<button type="button" class="btn btn-primary" >
					 		<span class="glyphicon glyphicon-print"> </span> 打印
					 	</button>
					 </div>
  					
				</div>
			
			</div>
			<div class="col-md-1">
			
			</div>
		</div>
		</div>
	
	<div class="container-fluid exam-record-contianer">
		
		
		<!-- 内容部分 -->
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10" id="topics">
			<div class="row"  >
				
				
			</div>
			
			
			
			
			</div>
			<div class="col-md-1"></div>
			
		</div>


	</div>

<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
<!--  <input type="button" style="float: right;visibility: hidden;" value="刷新url缓存" onclick="refreshUrlCahce();">
  -->
  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
