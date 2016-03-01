
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" import="com.cw.oes.form.*" import="com.cw.oes.utils.*" pageEncoding="UTF-8"%>
<%

UserSessionBean userSession  = (UserSessionBean)request.getSession().getAttribute(Environment.SESSION_USER_LOGIN_INFO);
boolean isNull;
if(userSession == null){
	System.out.println("null");
	isNull = true;
}else{
	isNull = false;
}
%>
<script type="text/javascript">

var userId ;
var userPwd;
$(function(){
	if(<%=isNull %> != true){
		getUserInfoNav();
		getNewMessages();
	}
	
});

function memberSignOut(){
	$.ajax({
		url:"${ctxPath}/common/ajax/memberSignOut",
		success:function(){
			toPage("${ctxPath}/common/index");
		}
		
	});
	
	
}



/* 读取用户信息 */
function getUserInfoNav(){
	$.ajax({
		
		url:"${ctxPath}/common/ajax/getPersonalInfo",
		success:function(data){
			data = eval("("+data+")");
			$("#nav-userName").text(data["resultObj"].userName);
			
			userId = data["resultObj"].uuid;
			userPwd = data["resultObj"].userPwd;
		}
	
	});
}

function getNewMessages(){
	
	var url =  "ws://"+window.location.host+"${ctxPath}/ws/message?useId="+userId+"&userPwd="+userPwd;
	
	var socket = new WebSocket(url); 
	// 打开Socket 
	socket.onopen = function(event) { 
	  var data = {userId : userId,
			  	  userPwd : userPwd};
	   data =  JSON.stringify(data);
	   /*   console.log(data); */
	   // 发送一个初始化消息
	   socket.send(data); 

	  // 监听消息
	  socket.onmessage = function(event) { 
		  var data = eval("("+event.data+")");
		  console.log(data.length);
		  var num = data.length;
		  if(num > 0){
			  $("#nav-badge1").text(data.length);
			  $("#nav-badge2").text(data.length);
		  }
	     
	  }; 

	  // 监听Socket的关闭
	  socket.onclose = function(event) { 
	    console.log('Client notified socket has closed',event); 
	  }; 

	  // 关闭Socket.... 
	  //socket.close() 
	};
	
}
//站内搜索
function siteSearch(){
	alert("敬请期待");
}
</script>
<style type="text/css">

body { padding-top: 70px; }
.navbar-inverse a{font-size: 18px;z-index: 1;}

.dropdown-toggle-top{
		background-color: RGBA(8, 8, 8, 0);
	}
</style>


<nav id="nav-bar" class="navbar navbar-inverse navbar-fixed-top nav-bar-unfixed">
  <div class="container-fluid">
    <div class="navbar-header" >
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="${ctxPath}/common/index">OES</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li ><a href="${ctxPath}/common/comingSoon">测验资源 </a></li>
        <li><a href="${ctxPath}/common/comingSoon">在线考试</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">合作<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${ctxPath}/common/comingSoon">广告栏位</a></li>
          </ul>
        </li>
      </ul>
      
      <form class="navbar-form navbar-left" role="search" >
        <div class="form-group">
        <div class="input-group">
	      <input type="text" class="form-control" placeholder="站内搜索...">
	      <span class="input-group-btn">
	        <button class="btn btn-info" type="button" onclick="siteSearch()"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 搜索</button>
	      </span>
    	</div>
          
        </div>
        
      </form>
      
       
      <ul class="nav navbar-nav navbar-right">
       <c:if test="<%= !isNull%>">
	      	 <li class="dropdown">
	          <a href="" class="dropdown-toggle" data-toggle="dropdown"  aria-haspopup="true" aria-expanded="false">
	          	<span  id="nav-userName"></span>
          		 <span class="glyphicon glyphicon-user userIcon" aria-hidden="true" id="userIcon"><span class="badge messageBag " id="nav-badge1" ></span></span><span class="caret"></span> 
          			
	          </a>
	        	<ul class="dropdown-menu">
	            <li><a href="${ctxPath}/common/toPersonalPage">个人主页</a></li>
	            <li><a href="${ctxPath}/common/toCountSettingPage">账号设置</a></li>
	          	<li><a href="">消 息<span class="badge textBadgeAlign" id="nav-badge2" ></span></a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="javascript:void(0)" onclick="memberSignOut()">退&nbsp;出  <span class="glyphicon glyphicon-off" aria-hidden="true"  ></span></a></li>
	          </ul>
        	</li>
        	<li>
        	
        	</li>
      	
      	</c:if>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">帮助<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="${ctxPath}/common/comingSoon">FAQ</a></li>
            <li><a href="${ctxPath}/common/comingSoon">在线机器人</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="${ctxPath}/common/comingSoon">关于</a></li>
          </ul>
        </li>
      	</ul>
      	<c:if test="<%=isNull %>">
	       <form class="navbar-form navbar-right"  >
		       <button type="button" class="btn  btn-primary navbar-btn" onclick="toPage('${ctxPath}/common/toLoginPage')"> 回  归 </button>
		       <button type="button" class="btn  btn-default navbar-btn" onclick="toPage('${ctxPath}/common/toRegisterPage')"> 加  入 </button>
	     	</form> 
      	
      	
      		<%-- <ul class="nav navbar-nav navbar-right">
		        <li><a href="${ctxPath}/common/toLoginPage">回  归</a></li>
		        <li><a href="${ctxPath}/common/toRegisterPage">加  入 </a></li>
		    </ul> --%>
      	</c:if>
      	</div><!-- /.navbar-collapse -->
  	</div><!-- /.container-fluid -->
	</nav>

	
	
	

