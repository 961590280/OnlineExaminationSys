<%@ page language="java" import="java.util.*" import="com.cw.oes.form.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String err = request.getParameter("err");
ResponseDataForm rdf = (ResponseDataForm) request.getAttribute("responseDataForm");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!-- 引入top.jsp页面  -->
    <jsp:include page="/WEB-INF/jsp/oes/subUnit/top.jsp"></jsp:include>
    <title>OES 首页</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>
	#top-jumbotron{
		padding-top: 0px;
		height: 600px;
		background-color: #465669;
		color:white;
		margin-bottom: 0px;
		/* background-image: url("res/img/bg.jpg"); */
	}
	#nav-bar{
		position: relative;
		border: none;
	}
	.nav-bar-unfixed{
		background-color:rgba(70, 86, 105, 0);
	}
	
	
	.jumbotron-container{
		padding:20px;
	}
	
	.bg-slider-wrapper {
	    content: "";
	    width: 100%;
	    top: 0;
	    left: 0;
	    background: #373737;
	    
	    background: #253340 url('res/img/bg.jpg') no-repeat 50% top;
   	 	position: relative;
	    min-height: 600px;
   	 	margin-bottom: -600px;
	}
	.slides, .flex-control-nav, .flex-direction-nav {
	    margin: 0;
	    padding: 0;
	    list-style: none;
	}
	.flexslider .slides {
	    zoom: 1;
	}
	
	#data-jumbotron{
		background-color: #D9DDE4;
		height: 100px;
		padding:0px;
	}
	
	</style>

  </head>
  
  <body style="padding:0px;">
  	<!-- 导航栏 -->
	<div id="top-jumbotron" class="jumbotron">
	
	 <div class="bg-slider-wrapper">
	 	<div class="flexslider bg-slider">
	 		<ul class="slides">
	 			<li></li>
	 		</ul>
	 	</div>
	 </div>
	 <jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	 
	  <div class="row-fluid jumbotron-container">
	  	 <div class="col-md-1 col-sm-12">
	    </div>
	  	<div class="col-md-10 col-sm-12">
	  		<p style="font-size: 35px;text-align: center;margin-top:70px;">锻炼你的考试技巧，巩固你的知识基础，就来这里！</p>
	  		<div class="col-md-3 col-sm-12">
	   		</div>
	  		<div class="col-md-6 col-sm-12">
	  			<p style="font-size: 20px;text-align: center;margin-top:70px;color:#C1C6CD;">这里有的都是你想要的,在这里包罗各行各行,在这里有海量题库,在这里有优质的服务</p>
	  		</div>
	  		<div class="col-md-3 col-sm-12">
	    	</div>
	    	<div class="col-md-12 col-sm-12">
	  			<p style="margin-top:70px;text-align: center;">
	  				<a class="btn btn-success btn-lg" href="javascript:void(0)" onclick="alert('敬请期待')" role="button" style="font-size: 30px;">来测试一下实力吧！</a>
	  			</p>
	  		</div>
	  	</div>
	    <div class="col-md-1 col-sm-12">
	    </div>
	  </div>
	  
	 
	  
	</div>

	
	
	
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>
  </body>
  
  <script type="text/javascript">
 	$(function(){
	 	scrollListen();
 	});
  
  function scrollListen(){
	  var w = window;
	  $('.dropdown-toggle').each(function(){
		  $(this).css("background","rgba(8, 8, 8, 0)");
	  });
	  
	  w.onscroll = function(){
		  var t = document.documentElement.scrollTop || document.body.scrollTop; 
		  var h = window.document.getElementById('nav-bar').offsetHeight;//导航栏高度
		  var jumbotron = document.getElementById('top-jumbotron');
		  if(t > 0){
			  $("#nav-bar").css("position","fixed");
			  jumbotron.style.marginTop = h ;
			  $('#nav-bar').removeClass("nav-bar-unfixed");
			  $('.dropdown-toggle').each(function(){
				  $(this).css("background","");
			  });
			  
		  }else{
 			 $('.dropdown-toggle').each(function(){
				  $(this).css("background","rgba(8, 8, 8, 0)");
			  });
			  $('#nav-bar').addClass("nav-bar-unfixed");
			  $("#nav-bar").css("position","relative");
			  jumbotron.style.marginTop = 0;
		  }
	  }
  }
  </script>
</html>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>

