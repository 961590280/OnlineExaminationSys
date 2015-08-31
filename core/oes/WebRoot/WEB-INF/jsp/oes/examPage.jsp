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
    
    <title>My JSP 'index.jsp' starting page</title>
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
	var time; //考试时间
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
				alert("提交失败，请重新提交！！");
			}else{
				alert("您答对 "+data["resultObj"]+" 题。点击确定，回到个人主页,查看详情！！");
				location.href="${ctxPath}/common/toPersonalPage";
			}
		}
		
		});
	}
	
	function backPersonalPage(){
		location.href="${ctxPath}/common/ajax/commitExam";
	}
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
  		
  <body style="padding: 0;margin: 0;height:100%;">
  <div style="float:left;text-align: center;background-color: gray;width: 100%;height: 100%;position: relative;">
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
 	</div>
  </body>
</html>
