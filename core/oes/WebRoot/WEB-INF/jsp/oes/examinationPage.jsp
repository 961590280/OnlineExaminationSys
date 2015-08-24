<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String currentTestPaperPid = request.getSession().getAttribute("currentTestPaperPid").toString();
String testPaperPid = request.getParameter("testPaperPid");

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
	var testPaperPid = <%=testPaperPid%>;
	
	$(document).ready(function(){
		if(confirm("一旦开始考试计时就不会停止，不能中途暂停！确定现在开始考试吗")){
			$.ajax({
			url:"${ctxPath}/common/ajax/beginTest",
			data:{
					testPaperPid:testPaperPid
					},
			type:"post",
			success:function(data){
				data = eval("("+data+")");
				time = data["resultObj"].time;
				
				if(time<0){
					alert("考试时间已结束！");
					location.href="${ctxPath}/common/toPersonPage";
				}else{
					beginTime();
					getTestPaper();
				}
			}
		});
			
		}else{
		
			location.href="${ctxPath}/common/toPersonPage";
		}
		
	});
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
		 	location.href="${ctxPath}/common/toPersonPage";
		 }
		/*  console.log(t); */
		setTimeout("beginTime()",50);
	}
	
	function getQuestion(){
		
	}
	
	function nextQ(){
		$.ajax({
		url:"",
		data:"",
		type:"",
		success:function(data){
		
		}
		
		});
	
	}
	function getTestPaper(){
		$.ajax({
			url:"${ctxPath}/common/ajax/getTestPaper",
			type:"post",
			success:function(data){
			
				
				data = eval("("+data+")");
				if(data["result"] == '2'){
					alert("考试已经结束");
					location.href="${ctxPath}/common/toPersonPage";
				}
				
				
				//alert(data);
				console.log(data);
				$("#paperType").text(data["resultObj"].paperType);
				$("#paperDifficulty").text(data["resultObj"].paperDifficulty);
				$("#paperTitle").text(data["resultObj"].paperTitle);
				$("#paperTotalPoint").text(data["resultObj"].paperTotalPoint);
				$("#paperTime").text(parseInt(data["resultObj"].paperFinishedTime/(1000*60))+"分钟");
			
			}
		});
	
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
		<td>类型：</td><td id="paperType" style="float:left;"></td>
		<td>难度：</td><td id="paperDifficulty" style="float:left;"></td>
		<td>总分：</td><td id="paperTotalPoint" style="float:left;"></td>
		<td>考试时间：</td><td id="paperTime" style="float:left;"></td>
		</tr></table>
		</p>
		<div class="questionContext" >
		<p class="topic" style="text-align: left;margin-left:10px;">第一大题 选择题：</p>
			
			<div style="margin-left:20px;">
				<p class="question" style="text-align: left;margin-left:10px;">
					1.你是男的还是女的？
				</p>
				<div class="answer" style="text-align: left;margin-left:30px;">
				
					A.男<input name="a" type="radio" value=""><br/>
					B.女<input name="a" type="radio" value=""><br/>
				</div>
				<input type="button" value="上一题" onclick="preQ()">
				<input type="button" value="下一题" onclick="nextQ()">
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
