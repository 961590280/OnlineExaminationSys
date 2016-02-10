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
	<link href="res/plug-in/redactor/redactor.css" rel="stylesheet"> 
	<style type="text/css">
	.redactor_editor{
		height:100px;
	}
	</style>
	
	<script type="text/javascript">
	var examPid = '<%=examPid%>';
	var createTime = '<%=createTime%>';
	var indexArr = ['A','B','C','D','E','F','G','H'];//选项序号
	
	$(function () {
		  getExamRecord();
		 
		
	})
	/* 读取测验记录  */
	function getExamRecord(){
		$.ajax({
			url:"${ctxPath}/common/ajax/getPersonalExamRecordInfo",
			data:{examPid:examPid,createTime:createTime},
			success:function(data){
				data = eval("("+data+")");
				data = data.resultObj;
				
				var dateArry = data.date.split("-");
				
				if(data==null||data==""){
					alert("记录不存在！！");
					location.href="${ctxPath}/common/toPersonalPage";
				}
				
				
				var html = '';
				
				
				$("#examTitle").html(data.examTitle);//测验名称
				
				console.log(dateArry);
				$("#year").html(dateArry[0]);//考试时间
				$("#month-day").html(dateArry[1]+"月"+dateArry[2].split(" ")[0]+"日");//考试时间
				var topicsHtml = '';//题目html
				for(var key in data.examPaper.topics){
					var topic = data.examPaper.topics[key];
					var answer = data.answers[parseInt(key)+1];//回答
					
					//alert()
					//console.log(parseInt(key)+1);
					topicsHtml+="<div class=\"row";
					if(answer==null){
						topicsHtml+=" f-null-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<span class=\" glyphicon glyphicon-question-sign options-empty\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"没有作答的题目\" ></span>";
						
					}else if(answer == topic.correctAnswer){
						topicsHtml+=" f-correct-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<span class=\" glyphicon glyphicon-ok-sign options-correct\"  ></span>";
					}else{
						topicsHtml+=" f-error-topics\" ><div class=\"col-md-8\"><h3>";
						topicsHtml+="<span class=\" glyphicon glyphicon-remove-sign options-error\"  ></span>";
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
						
						topicsHtml+="\">"+indexArr[optKey]+'.'+topic.options[optKey]+"</div></div> ";
					}
					topicsHtml+="</div><div class=\"col-md-4\"><div class=\"col-md-12\">";
					topicsHtml+="<div class=\"btn-group\" role=\"group\" aria-label=\"...\">";
					topicsHtml+="<button id='edit'  type=\"button\" class=\"btn btn-default record-note\"  onclick=\"showNote('note_"+key+"');\"   > <span class=\" glyphicon glyphicon-edit\" ></span> 笔记</button>";
					
					topicsHtml+="<button  type=\"button\" class=\"btn btn-default record-note\"   data-toggle=\"tooltip\" data-placement=\"bottom\" ";
					if(topic.isImport == "N"){
						topicsHtml+=" title=\"标记为重点\" onclick=\"setImport("+topic.uuid+",this)\" > <span class=\" glyphicon glyphicon-star-empty\"> ";
					}else{
						topicsHtml+=" title=\"取消重点\" onclick=\"unSetImport("+topic.uuid+",this)\" > <span class=\" glyphicon glyphicon-star\"> ";
					}
					console.log(topic);
					topicsHtml+="</span> 重点</button>";
					
					
					topicsHtml+="<button  type=\"button\" class=\"btn btn-default record-note\" onclick=\"refrenceOther()\"> <span class=\" \"></span>参考</button>";
					topicsHtml+="</div></div><div class=\"col-md-12\" style=\"margin-top: 20px;\"> <textarea class=\"textarea-note\" id='note_"+key+"'  topicId = '"+topic.uuid+"' lastValue='"+((topic.topicNote==null||topic.topicNote=='')?'':topic.topicNote)+"'  rows=\"4\">"+((topic.topicNote==null||topic.topicNote=='')?'':topic.topicNote)+"</textarea></div></div><div class=\"clear\"></div><hr/></div>";
				}
				/* console.log(topic); */
				$("#topics").html(topicsHtml);
				$('[data-toggle="tooltip"]').tooltip();//工具提示要调用tooltip方法
				initNotes();
				
			}
		});
	}
	/* 显示答错题目  */
	function showErrorTopics(){
		$("#topics .row").each(function(){
			if(!$(this).hasClass("f-error-topics")){
				$(this).hide(1000);
			}
			if($(this).hasClass("f-error-topics")){
				$(this).show(1000);
			};
		});
		
	}
	/* 显示没有作答题目  */
	function showNullTopics(){
		$("#topics .row").each(function(){
			if(!$(this).hasClass("f-null-topics")){
				$(this).hide(1000);
			}
			if($(this).hasClass("f-null-topics")){
				$(this).show(1000);
			};
		});
	}
	/* 显示所有题目  */
	function showAllTopics(){
		$("#topics .row").each(function(){
			$(this).show(1000);
		});
		
	}
	/* 显示答对题目  */
	function showCorrectTopics(){
		$("#topics .row").each(function(){
			if(!$(this).hasClass("f-correct-topics")){
				$(this).hide(1000);
			}
			if($(this).hasClass("f-correct-topics")){
				$(this).show(1000);
			};
		});
	}
	
	/* 显示笔记编辑框 */
	function showNote(id){
		$("textarea[id*='note_']").each(function(){
			if($(this).attr('id')==id){
				$('#'+id).parent().show(500);
			}else{
				$(this).parent().hide(500);
			}
			
		});
	}
	/* 设置题目为重点  */
	function setImport(topicId,button){
		$.ajax({
			url:"${ctxPath}/common/ajax/setImport",
			data:{
				topicId:topicId,
				isImport:"Y"
				},
			success:function(data){
				data = eval("("+data+")");
				if(data.result == "1"){
					console.log($(button).find("span.glyphicon-star"));
					$(button).find("span.glyphicon-star-empty").removeClass("glyphicon-star-empty").addClass("glyphicon-star");
					$(button).attr("onclick","unSetImport("+topicId+",this)").attr("data-original-title","取消重点");
				}
			}
		});
		
	}
	/* 取消重点 */
	function unSetImport(topicId,button){
		$.ajax({
			url:"${ctxPath}/common/ajax/setImport",
			data:{
				topicId:topicId,
				isImport:"N"
				},
			success:function(data){
				data = eval("("+data+")");
				if(data.result == "1"){
					$(button).find("span.glyphicon-star").removeClass("glyphicon-star").addClass("glyphicon-star-empty");
					$(button).attr("onclick","setImport("+topicId+",this)").attr("data-original-title","标记为重点");
				}
			}
		});
	}
	
	/* 参考按钮   */
	function refrenceOther(){
		alert("敬请期待");
	}
	</script>
	<style>
	.date{
		margin-top: 15px;
		text-align: center;
	}
	.date #year{
		font-size: 26px;
		font-weight: bold;
	}
	.date #month-day{
		font-size: 19px;
	}
	</style>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	<div class="exam-record-header">
	<div class="row exam-record-title" >
			
			<!-- 考试日期  -->
			<div class="col-md-3 date">
				<div >
					<span class="glyphicon glyphicon-calendar"></span>
					<span id="year"></span>
				</div>
				
				<div id="month-day"></div>
			</div>
			<!-- 考试标题 -->
			<div class="col-md-6" style="text-align: center;">
				<h1 id="examTitle"></h1>
			</div>
			
			<!-- 考试成绩 -->
			<div class="col-md-3">
				
			</div>
		
			
		
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
					      <li><a href="javascript:void(0)" onclick="showCorrectTopics()">显示答对题目</a></li>
					      <li><a href="javascript:void(0)" onclick="showNullTopics()">显示没有作答题目</a></li>
					    </ul>
					    
					    
					    
					  </div>
					  
					  <!-- <div class="btn-group" role="group">
					    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					      备用
					      <span class="caret"></span>
					    </button>
					    <ul class="dropdown-menu">
					      <li><a href="#">Dropdown link</a></li>
					      <li><a href="#">Dropdown link</a></li>
					    </ul>
					  </div> -->
					 </div>
  					
				</div>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-3">
				<div class="btn-toolbar" role="toolbar" aria-label="...">
					 <div class="btn-group" role="group" aria-label="...">
					 	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="分享到我的圈子">
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
			<div class="col-md-1">
				<!-- 测试 -->
			</div>
		</div>


	</div>

	<div class="save-message"> <span class="glyphicon glyphicon-floppy-disk"></span><p>保存</p></div>
	
	
<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
<!--  <input type="button" style="float: right;visibility: hidden;" value="刷新url缓存" onclick="refreshUrlCahce();">
  -->
  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
 

<script type="text/javascript" src="res/plug-in/redactor/redactor.js"></script>
<script>


$(document).ready(function(){
	$('.save-message').hide();
	}
);

function initNotes(){
	
	var buttons = ['formatting', '|', 
	               'bold', 'italic', 'deleted', '|',
	               'fontcolor','backcolor','|',
	               'unorderedlist','orderedlist','outdent','indent','|',
	               'horizontalrule'];
	/* 加载编辑器 */
	$(".textarea-note").each(function(){
		var $text = $(this);
		$text.redactor({
			focus: false,
			buttons: buttons,
			buttonsCustom: {
						
					}
				});
		$text.parent().find("div.redactor_editor").focusout(function(e){//失去焦点的事件
			/* console.log(e); */
			if($(e.target).hasClass('redactor_editor')){
				if($text.val()!=$text.attr('lastValue')){
					if(saveTopicNote($text.val(),$text.attr('topicId'))){
						$text.attr('lastValue',$text.val());
					}else{
						$text.val($text.attr('lastValue'));
					}
				}
			}
		 
		 });
		$text.parent().hide();//隐藏笔记
		 
	});
	
}
//保存笔记
function saveTopicNote(note,topicId){
	note = encodeURI(note);
	var saveOk = false;
	
	
	$.ajax({
		url:"${ctxPath}/common/ajax/saveTopicNote",
		data:{content:note,topicId:topicId},
		success:function(data){
			data = eval("("+data+")");
			console.log(data);
			if(data.resultInfo == '1'){
				saveOk = true;
				$('.save-message').show(500);
				setTimeout(function(){
					$('.save-message').hide(500);
				}, 2000);
				
			}else{
				
			}
		}
		
	});
	
	return saveOk;
	
}
</script>