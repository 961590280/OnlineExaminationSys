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
	
	<link href="res/plug-in/cropper-master/cropper.min.css" rel="stylesheet" ><!-- 图片裁剪控件 -->
	
	<script type="text/javascript">
	var $image;//剪裁图片
	var $modal;//模态框
	var $cropImg;//剪裁图片的父div
	var $imgInfo;//提示框
	
	$(function () {
	
	  getUserInfo();
	  init();
	
		
	});
	/* 读取用户信息 */
	function getUserInfo(){
		$.ajax({
			
			url:"${ctxPath}/common/ajax/getPersonalInfo",
			success:function(data){
				data = eval("("+data+")");
				$("#img-input").attr("src","res/personal-img/"+data["resultObj"].userHead);
			}
		
		});
	}
	/* 初始化 */
	function init(){
		  $modal   = $('#cutImgPanle');
		  $cropImg = $('#crop-img');
		  $imgInfo = $("#imgInfo");//提示框
		  
		  /* 注册事件 */
		  $('#save').bind("click",function(){//为模态窗口的保存按钮注册事件
			  
				uploadImg($image.cropper('getCroppedCanvas').toDataURL());
				loadding();
				$modal.modal('hide');
		  })
		
	}
	
	
	/* 选择图片，预览显示 */
	function selectPic(){
		hideAlert($imgInfo);//隐藏警告框
		
		
		var f = document.getElementById('img-path').files[0];
		if(!isImg(f)){
			showAlert($imgInfo, "请选择图片", ALERT_ERROR);
			return;
		}
		
		$modal.modal();//打开模态窗体 
		
		
		$('#cutImgPanle').on('shown.bs.modal', function (){	
			$cropImg.html("<img style=\"visibility: hidden;\" id=\"cut-img\" src=\""+window.URL.createObjectURL(f)+"\">");
			$image = $("#cut-img");//要剪裁的图像
			var $imgPreview = $("#preView-img");//剪裁后的头像预览
			$image.cropper({
				  aspectRatio: 4 / 4,
				  autoCropArea:0.5,
				  strict: true,
				  preview:$imgPreview, //参数为div对象，用来显示裁剪后的图片
				  built: function () {
					  $cropImg.css("visibility","visible");
					  
			      }}); 
		}).on('hidden.bs.modal', function (){//模态窗关闭后
			$cropImg.find("img").remove();
			$image.cropper('destroy');
			$image.remove();
			
		});
	}
	/* 64base方式上传图片 */
	function uploadImg(data){
		$.ajax({
				url:"${ctxPath}/common/ajax/uploadHeadImg",
				type:'POST',
				dataType:'text',
				data:{data:data},
				success:function(json){
					json = eval("("+json+")");
					$('#img-input').attr("src","res/personal-img/"+json.resultObj.fileName);
					showAlert($imgInfo, "上传成功", ALERT_SUCCESS);
					loadded();
				}
		});
	}
	

	
	/* 判断是否是合法的图片  */
	function isImg(file){
	  if (file.type) {
	        return /^image\/\w+$/.test(file.type);
      } else {
        return /\.(jpg|jpeg|png|gif)$/.test(file);
      }
	}
	
	
	
	
	/* 等待加载  效果*/
	function loadding(){
		$("#change-img").addClass("loading");
		$("img.loadding").css("visibility","visible");	
	}
	/* 加载完毕  效果移除*/
	function loadded(){
		$("#change-img").removeClass("loading");
		$("img.loadding").css("visibility","hidden");	
	}

	</script>
	<style type="text/css">
	</style>
  </head>
  
  <body>
  
  <!-- 导航栏 -->
	<jsp:include page="/WEB-INF/jsp/oes/subUnit/navBar.jsp"></jsp:include>
	
	
	<div class="container-fluid count-setting-container" >
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="panel panel-gray">
				  <div class="panel-heading">个人资料</div>
				  <div class="panel-body">
	   				 <form action="">
	   				 
	   				 	<div class="form-group setting-form-group">
		   				 	 <label for="img-input">头像</label>
		   				 	 <div class="col-md-12 " style="padding:0;margin-bottom: 20px;">
		   				 	 	<div class="col-md-3 " style="padding:0;">
		   				 	 	<img   src="" id="img-input" class="img-rounded img-input" />
	    					 	</div>
	    					 	<div class="col-md-6 " style="padding:0;">
	    					 		<input type="hidden" id="img-data"/>
	    					 		<button id="change-img" class="btn btn-primary" style="float: left;margin-right: -90px;">更换头像 </span></button> <img class="loadding" style="visibility: hidden;" src="res/img/loadding.gif">
		    					 	<input id="img-path" type="file" name="img" onchange="selectPic();"/>
		    					 	<p class="chnImg-info">选择要作为头像的图片后，进行裁剪。</p>
		    					 	
	    					 	</div>
	    					 	<div class="col-md-3 ">
	    					 	
	    					 		<div class="col-sm-12 alert hidden" role="alert" id="imgInfo" >
										
									</div>
	    					 	</div>
	    					 </div>
	   				 	</div>
	   				 	<div class="form-group setting-form-group">
		   				 	 <label for="email-input">社交邮箱</label>
	    					 <input type="email" class="form-control email-input" id="email-input" placeholder="">	
	   				 	</div>
	   				 	 <button type="submit" class="btn btn-primary">保存</button>
	   				 </form>
	   				 
				   </div>
				</div>
			</div>
			<div class="col-md-3"></div>
		
		</div>
	</div>

 <jsp:include page="/WEB-INF/jsp/oes/subUnit/ImgCutModal.jsp"></jsp:include>
<jsp:include page="/WEB-INF/jsp/oes/subUnit/footer.jsp"></jsp:include>

  </body>
</html>
 <jsp:include page="/WEB-INF/jsp/oes/subUnit/bottom.jsp"></jsp:include>
 
 <script type="text/javascript" src="res/plug-in/cropper-master/cropper.min.js"></script>
