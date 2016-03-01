<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String currentTestPaperPid = request.getSession().getAttribute("currentTestPaperPid").toString();
String examPid = request.getParameter("examPid");

%>

<!DOCTYPE HTML >
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
	
	<link rel="stylesheet" type="text/css" href="res/css/main.css">
	<script type="text/javascript" src="res/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	var allTime;
	var topicNum;
	var examPid = <%=examPid%>;//测验id
	var userPid ;
	var isFinished = false;
	
	var init = false;
	var socket;
	var timer;
	
	$(function(){
		getExamInfo();
	});
	
	
	
	
	/** 开始考试 **/
	function beginExam(){
		
		
		/* if(!confirm("开始考试后不能退出全屏和关闭摄像头")){
			return ;
		} */
		
		
		persoanlExam();
		/* publicExam(); */
		
	}
	/* 个人测验 */
	function persoanlExam(){
		initExamPaper();
	}
	/* 公开考试  */
	function publicExam(){
		requestFullScreen(); //全屏
		//初始化视频和socket
		initVideo(function(){
			initVideoSocket();
			videoListen(); 
			initExamPaper();
			
		});
	}
	
	/* 初始化测验页面  */
	function initExamPaper(){
		$("#begin-btn").removeAttr("disabled");
		init = true; 
		
		$.ajax({
			url:"${ctxPath}/common/ajax/beginExamByPersonal",
			data:{
					examPid:examPid
					},
			type:"post",
			success:function(data){
			
				data = eval("("+data+")");
				
				$("#exam-personal-info button").removeClass("btn-success").addClass("btn-danger").html("交 &nbsp; &nbsp;卷").attr("onclick","commitExam()");
				allTime = data["resultObj"].finishedTime;
				examType = data["resultObj"].type;
				topicNum = data["resultObj"].topicNum;
				
				$(".exam-time #time-all").text(timeStr(allTime));
				$("#progress-bar").addClass("active");
				
				beginTime(allTime);//时间控件开始倒计时
				loadTopics(topicNum);//显示答题按钮
				
			}
		});
	}
	/** 加载题目数，显示题目按钮 **/
	function loadTopics(num){
		var html = "";
		if(num == null|| num == 0){
			
			$("#exam-topics-div").html("<div class=\"col-md-4\"></div><div class=\"col-md-4 exam-topic-error\" ><h2>数据错误！！<br/>请重新刷新页面</h2></div><div class=\"col-md-4\"></div>");
			return false;
		}
		
		for(var i = 1;i<=num;i++){
			if(i%5 == 1){
				html += "<div class=\"row\"><div class=\"col-md-1 col-xs-0\"></div>";
			}
			html+=createButton(i);
			if(i%5 == 0){
				html +="<div class=\"col-md-1 col-xs-0\"></div></div>";
			}
		}
		
		$("#exam-topics-div").html(html);
	}
	/** 创建答题button的html字符串**/
	function createButton(sort){
		return "<div class=\"col-md-2 col-xs-6 col-md-offset-0 col-xs-offset-3\" ><button  id='btn_"+sort+"'  type=\"button\" class=\"btn btn-info  btn-lg btn-block\" onclick=\"openTopicPanle('"+sort+"')\">第"+sort+"题	<span class=\"badge answer\"></span></button></div>";
	}
	/** 创建提交button的html字符串 **/
	function createCommitTopicButton(sort){
		var html = "";
		sort=parseInt(sort);
		html += " <button type='button' class='btn btn-default' data-dismiss='modal'>关闭</button>";
		if(sort == 1){
			html += " <button type='button' class='btn btn-info' onclick=\"nextTopic('"+(sort+1)+"')\">下一题</button>";
			
		}else if(sort == topicNum){
			html += " <button type='button' class='btn btn-info' onclick=\"preTopic('"+(sort-1)+"')\">上一题</button>";
		}else{
			html += " <button type='button' class='btn btn-info' onclick=\"preTopic('"+(sort-1)+"')\">上一题</button>";
			html += " <button type='button' class='btn btn-info' onclick=\"nextTopic('"+(sort+1)+"')\">下一题</button>";
			
		}
		html += " <button type='button' class='btn btn-primary' onclick='commitTopic(\""+sort+"\")'>提交</button>";
		return html;
	}
	/**创建radio的html字符串**/
	function createRadioOption(value,text,checked){
		if(checked == true){
			return "<div class='radio'><label> <input type='radio'  checked='checked'  name='option' id='opn_"+value+"'  value='"+value+"' aria-label='"+text+"'>"+text+"</label></div>";
		}
		return "<div class='radio'><label> <input type='radio' name='option' id='opn_"+value+"'  value='"+value+"' aria-label='"+text+"'>"+text+"</label></div>";
	}
	/** 打开答题面板**/
	function openTopicPanle(sort){
		//alert(sort);
		$('#topicPanle .modal-title').text("第"+sort+"题");
		$('#topic-footer').html(createCommitTopicButton(sort));
		loadTopicToPanel(sort);
		$('#topicPanle').modal();//打开模态窗体
	}
	/** 重新加载答题面数据**/
	function refreshTopicPanle(sort){
		//alert(sort);
		$('#topicPanle .modal-title').text("第"+sort+"题");
		$('#topic-footer').html(createCommitTopicButton(sort));
		loadTopicToPanel(sort);
	}
	/** 从服务器加载数据到答题面板 **/
	function loadTopicToPanel(sort){
		$.ajax({
			url:"${ctxPath}/common/ajax/getTopic",
			type:"post",
			data:{topicSort : sort},
			success:function(data){
				data = eval("("+data+")");
				console.info(data);
				var answer = data["resultObj"].answer;
				var topic = data["resultObj"].topic;
				//设置题目内容
				//$("#question").text(currentTopic+"."+topic.content);
				var options =new Array();
				options[0] = topic.opn1;
				options[1] = topic.opn2;
				options[2] = topic.opn3;
				options[3] = topic.opn4;
				options[4] = topic.opn5;
				options[5] = topic.opn6;
				options[6] = topic.opn7;
				console.info(options);
				$("#topicPanle .modal-body .topic-head").text(topic.content);
				var str = "";
				var value = 1;
				for(var i =0;i<options.length;i++){
					var temp = options[i];
					if(temp != null &&temp !=""){
						console.info(temp);
						
					
						if(answer!=null&&answer!=""&&value==answer){
							str += createRadioOption(value,temp,true);
						}else{
							str += createRadioOption(value,temp);
							
						}
						value++;
					}
				}
				$("#topicPanle .modal-body .topic-body").html(str);	
			}
		});
	}
	
	/**计算倒计时**/
	function beginTime(time){
		
		 $(".exam-time #time-surplus").text(timeStr(time));
		 var percent = time/allTime*100+"%";
		 $("#progress-bar").css("width",percent);
		 time-=100;
		 
		if(time<1000*60*3){
			$("#progress-bar").removeClass("progress-bar-success").addClass("progress-bar-danger").text("时间不足3分钟");
		}
		if(time<=0){
			$("#exam-topics-div button").attr("disabled","disabled");//设置按钮为不可用
		    $(".exam-time #time-surplus").text("00:00:00");
			$("#progress-bar").css("width","0%");
			
			isFinished = true;
			
			videoStreamClose();
			exitFullscreen();
			return true;
		}else{
			/*  console.log(t); */
			setTimeout("beginTime("+time+")",100);
		}
	}
	/** 返回格式化时间 **/
	function timeStr(time){
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
		 return t;
	}
	/**提交一个题目的答案**/
	function commitTopic(sort,close){
		
		if(isFinished){
			alert("考试时间结束！！");
			return ;
		}
		
		if(close == null || close == true){
			
			$('#topicPanle').modal('toggle');
		}
		
		var answer = $(".topic-body input[name ='option']:checked").val();
		if(answer == null){
			
			return;
		}
		
		//保存答案
		$.ajax({
			url :"${ctxPath}/common/ajax/saveAnswerOne",
			data:{
				topicSort : sort,
				answer : answer
				},
			success:function(data){
				data = eval("("+data+")");
				console.log(data);
				if(data["result"] == 2){
					alert(data["resultInfo"]);
					return false;
				}else{
					
					$("#btn_"+sort).removeClass("btn-info").addClass("btn-primary");
					$("#btn_"+sort+" span").text(String.fromCharCode(parseInt(answer)+64));

					return true;
					
				}
			}
		});
	}
	
	/** 下一题 **/
	function nextTopic(sort){
		sort = parseInt(sort);
		commitTopic(sort-1,false);
		$('#topicPanle .modal-title').text("第"+sort+"题");
		refreshTopicPanle(sort);
	}
	/** 上一题 **/
	function preTopic(sort){
		sort = parseInt(sort);
		commitTopic(sort+1,false);
		refreshTopicPanle(sort);
	}
	/** 交卷  **/
	function commitExam(){
		
		
		
		if(confirm("确定交卷吗？")){
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
		
		
	}
	
	/** 显示测验和考试信息 **/
	function getExamInfo(){
		$.ajax({
			
			url:"${ctxPath}/common/ajax/getPersonalInfo",
			success:function(data){
				data = eval("("+data+")");
				$("#personalName").text(data["resultObj"].userName);
				$("#head_img").attr("src","res/personal-img/"+data["resultObj"].userHead);
				
				userPid = data["resultObj"].uuid;
				console.log(data["resultObj"]);
			}
		
		});
		$.ajax({
			
			url:"${ctxPath}/common/ajax/getExamInfo",
			data:{examPid:examPid},
			success:function(data){
				data = eval("("+data+")");
				
				$("#examName").text(data["resultObj"].examName);
				console.log(data["resultObj"].uuid);
			}
		
		});
		
	}
	
	
	/* 初始化摄像头 */
	
	
	function initVideo(back){
		var video = document.getElementById("video");
		
		
		var errocb = function(error) {
			alert("请确保摄像头可用，浏览器支持摄像头和浏览器摄像头权限开启后刷新页面");
			console.log("Video capture error: ", error.code); 
		};
		
		
		if (navigator.getUserMedia) { // 标准的API
			
			navigator.getUserMedia({ "video": true }, function (stream) {
				video.src = stream;
				back();
            }, errocb);

		} else if (navigator.webkitGetUserMedia) { // WebKit 核心的API
			navigator.webkitGetUserMedia({ "video": true }, function (stream) {
				video.src = window.webkitURL.createObjectURL(stream);
				back();
				
            }, errocb);
		
		}else if(navigator.mozGetUserMedia) { // Firefox-prefixed
			navigator.mozGetUserMedia({ "video": true }, function(stream){
				video.src = window.URL.createObjectURL(stream);
				back();
			}, errocb);
		}
	
	}
	/* 初始化socket */
	function initVideoSocket(){
		var url =  "ws://"+window.location.host+"${ctxPath}/ws/monitoring?userId="+userPid+"&examId="+examPid;
		
		
		socket = new WebSocket(url); 
		
		socket.binaryType = "arraybuffer";
		// 打开Socket 
		socket.onopen = function(event) { 
		  // 监听消息
		  socket.onmessage = function(event) { 
			  var data = eval("("+event.data+")");
		  }; 

		  // 监听Socket的关闭
		  socket.onclose = function(event) { 
		    console.log('Client notified socket has closed',event); 
		  }; 
		};
	}
	
	
	//设置视频监听事件
	function videoListen(){
		
		
		var video = document.getElementById("video");
		
		video.addEventListener('playing', function(){//当摄像头打开后事件
			  var ctx = canvas.getContext("2d");
	          var PACKAGE_LEN = 8000;			//设置包长度
	          
	          timer = setInterval(function() {
	              ctx.drawImage(video, 0,0,180,110);//绘制canvas
				  var data = canvas.toDataURL("image/jpeg");
				  var len = data.length;
				  
	      		try { 
	      			var packages = parseInt(len/PACKAGE_LEN);//计算包的个数
	      			var index = 0;
	      			
	      			for(var i = 0;i<packages;i++){
	      				socket.send(data.substring(index,index += PACKAGE_LEN));
	      			}
	      			
	      			if(index<len){
	      				socket.send(data.substring(index+1,len+1));
	      			}
	      		} catch (ex) { 
	      			console.log(ex); 
	      		}
	          }, 250);
	     },false);
	}
	
	//关闭视频流操作
	function videoStreamClose(){
		
		if(timer!=null){
			clearInterval(timer);//清空interval
		}
		
		if(socket != null){
			socket.close(); //关闭socke
			document.getElementById("video").pause();//暂停摄像头
		}
	}
	
	//进入全屏
	function requestFullScreen() {
	    var de = document.documentElement;
	    if (de.requestFullscreen) {
	        de.requestFullscreen();
	    } else if (de.mozRequestFullScreen) {
	        de.mozRequestFullScreen();
	    } else if (de.webkitRequestFullScreen) {
	        de.webkitRequestFullScreen();
	    }
	}
	//退出全屏
	function exitFullscreen() {
	    var de = document;
	    if (de.exitFullscreen) {
	        de.exitFullscreen();
	    } else if (de.mozCancelFullScreen) {
	        de.mozCancelFullScreen();
	    } else if (de.webkitCancelFullScreen) {
	        de.webkitCancelFullScreen();
	    }
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
  		
  <body style="padding: 0;margin: 0;height:100%;" >
	<!-- 摄像头部分 -->
	<video id="video" autoplay="" style='width:0;height:0;'></video>
	<canvas id="canvas" style="width:180px;height:110px;margin-top:-220px;"></canvas>
 	<div class="container-fluid exam-container" >
 		<div class="row ">
 			<div id="exam-personal-info" class="col-md-2 col-xs-12 ">
				<div class="col-md-12 col-xs-5">
					<img id="head_img" src="" alt="..." class="img-rounded" style="width: 100%;">
				</div>
				<div class="col-md-12 col-xs-7">
					<h5 >姓名：<span id="personalName"></span><h5>
					<h5>测验名称：<span id="examName"></span><h5>
					<button id="begin-btn"  class="btn btn-success btn-lg btn-block"  type="button"  onclick="beginExam()">开始答题</button>
					
				</div>
			</div>
 			
 			
 			<div class="col-md-10 col-xs-12">
	 			<div class="row">
	 				<div class="col-md-12">
	 					<div class="progress">
						  <div id="progress-bar" class="progress-bar progress-bar-success progress-bar-striped " role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
						    <span class="sr-only"></span>
						  </div>
						</div>
	 				</div>
	 				<div class="col-md-5"></div>
	 				<div class="col-md-2 exam-time" style="text-align: center;font-size: 20px;font-weight: 10px;"><span id="time-surplus">00:00:00</span>/<span id="time-all">00:00:00</span></div>
	 				<div class="col-md-5"></div>
	 			</div>
 				<div id="exam-topics-div" class="row-fluid exam-topics-div">
 					
 				<div class="col-md-4"></div>
 				<div class="col-md-4"><h3>点击按钮开始测验</h3></div>
 				<div class="col-md-4"></div>
 				
	 				
 				</div>
 				
 				
 			</div>
 		
 		
 		</div>
 	
 	</div>


  </body>
   <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/modal.jsp"></jsp:include>
</html>
