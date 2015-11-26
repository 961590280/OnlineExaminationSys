
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
function memberSignOut(){
	$.ajax({
		url:"${ctxPath}/common/ajax/memberSignOut",
		success:function(){
			toPage("${ctxPath}/common/index");
		}
		
	});
	
}
</script>
<style type="text/css">

body { padding-top: 70px; }
.navbar-inverse a{font-size: 18px;z-index: 1;}
</style>
<div class="container-fluid">

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
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
        <li ><a href="#">测验资源 </a></li>
        <li><a href="#">在线考试</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">合作<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">广告栏位</a></li>
          </ul>
        </li>
      </ul>
      
      <form class="navbar-form navbar-left" role="search" >
        <div class="form-group">
        <div class="input-group">
	      <input type="text" class="form-control" placeholder="站内搜索...">
	      <span class="input-group-btn">
	        <button class="btn btn-info" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 搜索</button>
	      </span>
    	</div>
          
        </div>
        
      </form>
      
       
      <ul class="nav navbar-nav navbar-right">
       <c:if test="<%= !isNull%>">
	      	 <li class="dropdown">
	          <a href="" class="dropdown-toggle" data-toggle="dropdown"  aria-haspopup="true" aria-expanded="false">
          			<%=userSession.getUserCode() %> <span class="glyphicon glyphicon-user userIcon" aria-hidden="true" id="userIcon"><span class="badge messageBag" id="nav-badge" >1</span></span><span class="caret"></span> 
          			
	          </a>
	        	<ul class="dropdown-menu">
	            <li><a href="${ctx}/oes/common/toPersonalPage">个人主页</a></li>
	            <li><a href="${ctx}/oes/common/toCountSettingPage">账号设置</a></li>
	          	<li><a href="">消 息<span class="badge textBadgeAlign" id="nav-badge" >1</span></a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="javascript:void(memberSignOut())">退&nbsp;出  <span class="glyphicon glyphicon-off" aria-hidden="true"  ></span></a></li>
	          </ul>
        	</li>
        	<li>
        	
        	</li>
      	
      	</c:if>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">帮助<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">FAQ</a></li>
            <li><a href="#">在线机器人</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">关于${userSession}</a></li>
          </ul>
        </li>
      	</ul>
      	<c:if test="<%=isNull %>">
	      	<form class="navbar-form navbar-right"  >
		       <button type="button" class="btn  btn-primary navbar-btn" onclick="toPage('${ctxPath}/common/toLoginPage')"> 登   录 </button>
		       <button type="button" class="btn  btn-default navbar-btn" onclick="toPage('11')"> 注   册 </button>
	     	</form>
      	
      	</c:if>
      	</div><!-- /.navbar-collapse -->
  	</div><!-- /.container-fluid -->
	</nav>

	
	
	
	

	</div>
