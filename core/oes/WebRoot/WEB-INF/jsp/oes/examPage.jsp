<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String currentTestPaperPid = request.getSession().getAttribute("currentTestPaperPid").toString();
String examPid = request.getParameter("examPid");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html style="height:100%;">
  <head>
    <base href="<%=basePath%>">
    
    <title>OES-个人测验</title>
     <!-- 引入top.jsp页面  -->
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/top.jsp"></jsp:include>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="res/css/main.css">
	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	/**创建radio的html字符串**/
	function createRadioOption(value,text){
		return "<div class='radio'><label> <input type='radio' name='option' id='opn_"+value+"'  value='"+value+"' aria-label='"+text+"'>"+text+"</label></div>";
	}
	/** 打开答题面板 **/
	function openTopicPanle(sort){
		//alert(sort);
		$('#topicPanle .modal-title').text("第"+sort+"题");
		$('#topicPanle .modal-body .topic-head').text("下列是高级机器语言的是？");
		var str = "";
		str += createRadioOption("1","java");
		str += createRadioOption("2","英语");
		$('#topicPanle .modal-body .topic-body').html(str);
		
		
		$('#topicPanle').modal({
			
		});
		
		
	}
	function beginExam(){
		
	}
<%-- 	var time; //考试时间
	var examPid = <%=examPid%>;
	var examType;
	var currentTopic = 1;//从1开始
	var topicNum;
	
	$(document).ready(function(){
		if(confirm("一旦开始考试计时就不会停止，不能中途暂停！确定现在开始考试吗")){
			$.ajax({
			url:"${ctxPath}/common/ajax/beginExamByPersonal",
			data:{
					examPid:examPid
					},
			type:"post",
			success:function(data){
			
				data = eval("("+data+")");
				time = data["resultObj"].finishedTime;
				examType = data["resultObj"].type;
				topicNum = data["resultObj"].topicNum;
				if(time<0){
					alert("考试时间已结束！");
					location.href="${ctxPath}/common/toPersonalPage";
				}else{
					console.log(data);
					$("#paperType").text("类型："+data["resultObj"].type);
					$("#paperDifficulty").text("难度："+data["resultObj"].difficulty);
					$("#paperTitle").text(data["resultObj"].title);
					$("#paperTotalPoint").text("总分："+data["resultObj"].totalPoint);
					$("#paperTime").text("考试时间："+parseInt(data["resultObj"].finishedTime/(1000*60))+"分钟");
					beginTime();
					getTopic();
				}
			}
		});
			
		}else{
		
			location.href="${ctxPath}/common/toPersonalPage";
		}
		
	});
	/**计算倒计时**/
	function beginTime(){
		 var s = parseInt(time/1000);
		 var m = parseInt(s/60);
		 var h = parseInt(m/60);
		 s = s%60;
		 m = m%60;
		 var t = h>=10? h+"":"0"+h;
		 t +=":";
		 t += m>=10? m+"":"0"+m;
		 t+=":";
		 t += s>=10 ? s+"":"0"+s;
		 $("#time").text(t);
		 time-=50;
		 //当剩余时间小于5分钟
		 if(time<1000*60*5){
		 	
		 	$("#timeDiv").css("background-color", time%500==0?"#FF5511":"#DDDDDD");
		 	$("#warm").text("考试时间不足5分钟！！");
		 }
		 
		 if(time<=0){
		 	location.href="${ctxPath}/common/toPersonalPage";
		 }
		/*  console.log(t); */
		setTimeout("beginTime()",50);
	}
	
	
	//读取下一题
	function nextQ(){
		
		var answer = $("input[name ='option']:checked").val();
		console.log("a"+answer);
		if(answer == null){
			if(!confirm("还未选中答案是否就前往下一题")){
				return;
			}
		}else{
			//保存答案
			$.ajax({
				url :"${ctxPath}/common/ajax/saveAnswerOne",
				data:{
					topicSort:currentTopic,
					answer :answer
					},
				success:function(data){
					data = eval("("+data+")");
					if(data["resul"] == 2){
						alert("答案保存失败请再此点击【下一题】进行保存");
						return;
					}
				}
			});
			if(currentTopic == topicNum){
			alert("答完全部题目");
			return;
		}
		}
		
		currentTopic++;
		getTopic();
	
	}
	//读取上一题
	function preQ(){
		if(currentTopic == 1){
			alert("已经是第一个题目了");
			return;
		}
		currentTopic--;
		getTopic(); 
	}
	/**读取题目**/
	function getTopic(){
		$.ajax({
			url:"${ctxPath}/common/ajax/getTopic",
			type:"post",
			data:{topicSort : currentTopic},
			success:function(data){
				data = eval("("+data+")");
				console.info(data);
				var answer = data["resultObj"].answer;
				var topic = data["resultObj"].topic;
				//设置题目内容
				$("#question").text(currentTopic+"."+topic.content);
				var options =new Array();
				options[0] = topic.opn1;
				options[1] = topic.opn2;
				options[2] = topic.opn3;
				options[3] = topic.opn4;
				options[4] = topic.opn5;
				options[5] = topic.opn6;
				options[6] = topic.opn7;
				console.info(options);
				var value = "1";
				var html = "";
				for(var i =0;i<options.length;i++){
					var temp = options[i];
					if(temp != null &&temp !=""){
						console.info(temp);
						html += "<p><input  name='option' type='radio' id='opn_"+value+"' value='"+ value +"'";
						if(answer!=null&&answer!=""&&value==answer){
							html += "  checked='checked' ";
						}
						html += "/><label for='opn_"+value+"'>"+temp+"</label></p>";
						value++;
					}
				}
				$("#answer").html(html);
				
				
			}
		});
	}
	/**提交考卷**/
	function commitExam(){
		$.ajax({
		url:"${ctxPath}/common/ajax/commitExam",
		success:function(data){
			data = eval("("+data+")");
			console.log(data);
			if(data["result"] == "2"){
				alert(data["resultInfo"]);
			}else{
				alert("您答对 "+data["resultObj"]+" 题。点击确定，回到个人主页,查看详情！！");
				location.href="${ctxPath}/common/toPersonalPage";
			}
		}
		
		});
	}
	
	function backPersonalPage(){
		location.href="${ctxPath}/common/ajax/commitExam";
	} --%>
	</script>
	<style type="text/css">
	.red
	{
	width:150px;
	height:70px; 
	background-color:red; 
	position:fixed; 
	margin-top: 10px;
	margin-left:10px;
	padding:10px;
	
	}
	
	.grave
	{
	width:150px;
	height:70px; 
	background-color:#DDDDDD; 
	position:fixed; 
	margin-top: 10px;
	margin-left:10px;
	padding:10px;
	
	}
</style>
  </head>
  		
  <body style="padding: 0;margin: 0;height:100%;" >
<!--   <div style="float:left;text-align: center;background-color: gray;width: 100%;height: 100%;position: relative;">
	<div class="pageTitle" style="height:100%;width: 800px;background-color:white;position: absolute;margin-left: 50%;left: -400px; ">
		<h1 id="paperTitle">xxx测试</h1>
		<p >
		<table width="500px" style="margin-left:25%;"><tr>
		<td id="paperType" style="float:left;margin-left: 20px;"></td>
		<td id="paperDifficulty" style="float:left;margin-left: 20px;"></td>
		<td id="paperTotalPoint" style="float:left;margin-left: 20px;"></td>
		<td id="paperTime" style="float:left;margin-left: 20px;"></td>
		</tr></table>
		</p>
		<div class="questionContext" >
		<p class="topic" style="text-align: left;margin-left:10px;visibility: hidden;">第一大题 选择题：</p>
			
			<div style="margin-left:20px;">
				<p id="question" style="text-align: left;margin-left:10px;">
					
				</p>
				<form>
				<div id="answer" style="text-align: left;margin-left:30px;">
				
				</div>
				</form>
				<input type="button" value="上一题" onclick="preQ()">
				<input type="button" value="下一题" onclick="nextQ()">
				<input type="button" value="提交" style="float: right; margin-right:30px;"  onclick="commitExam()">
			</div> 
		</div>
			
	
		
	</div>
	
 </div>
 
 <div id="timeDiv" style="width:150px;height:70px; background-color:#DDDDDD; position:fixed; margin-top: 10px;margin-left:10px;padding:10px;">
 	剩余考试时间：
 	<p id="time" ></p>
 	<p id="warm" style="color:red;"></p>
 	</div> -->
 	
 	<div class="container-fluid exam-container" >
 		<div class="row ">
 			<div class="col-md-2 col-xs-12 ">
				<div class="col-md-12 col-xs-5">
					<img src="res/testimg.png" alt="..." class="img-rounded" style="width: 100%;">
				</div>
				<div class="col-md-12 col-xs-7">
					<h5>姓名：xxx<h5>
					<h5>测验名称：xxx<h5>
					<button class="btn btn-success btn-lg btn-block"   type="button" >开始答题</button>
					<!-- <button class="btn btn-danger btn-lg btn-block" type="button">交 &nbsp; &nbsp;卷</button> -->
				</div>
			</div>
 			
 			
 			<div class="col-md-10 col-xs-12">
	 			<div class="row">
	 				<div class="col-md-12">
	 					<div class="progress">
						  <div class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
						    <span class="sr-only"></span>
						  </div>
						</div>
	 				</div>
	 				<div class="col-md-5"></div>
	 				<div class="col-md-2 exam-time" style="text-align: center;font-size: 20px;font-weight: 10px;">00:16:00/1:20:00</div>
	 				<div class="col-md-5"></div>
	 			</div>
 				<div class="row-fluid exam-topics-div">
 					
 						<div class="row">
 						<div class="col-md-1 col-xs-0"></div>
 						
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3" >
 							<button type="button" class="btn btn-primary  btn-lg btn-block" onclick="openTopicPanle('1')">第1题	<span class="badge answer">C</span></button>
 						
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第2题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第3题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第4题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第5题</button>
 						</div>
 						<div class="col-md-1 col-xs-0"></div>
 						</div>
 						<div class="row">
 						
 						<div class="col-md-1 col-xs-0"></div>
 						
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-primary  btn-lg btn-block" >第1题	<span class="badge answer">C</span></button>
 						
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第2题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第3题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第4题</button>
 						</div>
 						<div class="col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3">
 							<button type="button" class="btn btn-info  btn-lg btn-block" >第5题</button>
 						</div>
 						
 						<div class="col-md-1 col-xs-0"></div>
 						</div>
 					
 				
	 				
 				</div>
 				
 				
 			</div>
 		
 		
 		</div>
 	
 	</div>


  </body>
   <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/modal.jsp"></jsp:include>
</html>
