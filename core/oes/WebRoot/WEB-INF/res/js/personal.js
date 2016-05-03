
	/** 读取用户数据 用户名，头像**/
	function getUserInfo(){
		
		$.ajax({
		
			url:ctxPath+"/common/ajax/getPersonalInfo",
			success:function(data){
				data = eval("("+data+")");
				$("#head_img").attr("src","res/personal-img/"+data["resultObj"].userHead);
			}
		
		});
		getUserTags();
		
	}
	
function getUserTags(){
	var arr=["primary","success","info","warning","danger"];
	$.ajax({
		url:ctxPath+"/common/ajax/getPersonalTag",
		success:function(data){
			data = eval("("+data+")");
			data = data["resultObj"];
			var html ="";
			if(data.length==0){
				html="<span >暂无标签</span>";
				
			}
			for(var key in data){
				html+="<span class='label label-"+arr[key%5]+"'>"+data[key].name+"</span>";
			}
			$("#tags").html(html);
		}
	
	});
}
//加载【猜你喜欢】 中的测验数据
function loadLikeExams(){
 	var id = "examList";
 	$("#"+id).html("");//清空数据
 	
	$.ajax({
		
			url:ctxPath+"/common/ajax/getExams",
			success:function(data){
				data = eval("("+data+")");
				var html = "";
				for(var temp in data["resultObj"]){
					html +="<tr id = \"examPid_"+data["resultObj"][temp]["uuid"]+"\" ><td class=\"col-md-6 col-xs-12\">"+"<a href='"+ctxPath+"/common/toExamPage?examPid="+data["resultObj"][temp]["uuid"]+"'>"+data["resultObj"][temp]["examName"]+"</a></td><td class=\"col-md-5 col-xd-10\">";
					html +="</td><td class=\"col-md-1 col-xs-2 personal-star-td\"><a href='javascript:void(0)' onclick='collectionExam("+data["resultObj"][temp]["uuid"]+")'><span class=\"glyphicon glyphicon-star-empty\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"点击收藏\" ></span></a></td></tr>";
				}
				$("#"+id).html(html);
				$('[data-toggle="tooltip"]').tooltip();//在文档充新加载完后执行
			}
		
		});
	
}
/** 收藏测验 **/
function collectionExam(examPid){
	
	$.ajax({
		url:ctxPath+"/common/ajax/collectionExam",
		data:{examPid:examPid},
		success:function(data){
			data = eval("("+data+")");
			/* console.log(data) */
			if(data["result"] == 2){
				
				alert(data["resultInfo"]);
				
			}else{
				$("tr#examPid_"+examPid+" td.personal-star-td span").removeClass("glyphicon-star-empty").addClass("glyphicon-star").attr("data-original-title","取消收藏");
				$("tr#examPid_"+examPid+" td.personal-star-td a").attr("onclick","unCollectionExam("+examPid+")");
			}
		}
		
	});
	
	
}
/** 取消收藏 **/
function unCollectionExam(examPid){

	$.ajax({
		url:ctxPath+"/common/ajax/unCollectionExam",
		data:{examPid:examPid},
		success:function(data){
			data = eval("("+data+")");
			/* console.log(data) */
			if(data["result"] == 2){
				
				alert(data["resultInfo"]);
				
			}else{
			
				$("tr#examPid_"+examPid+" td.personal-star-td span").removeClass("glyphicon-star").addClass("glyphicon-star-empty").attr("data-original-title","点击收藏");
				$("tr#examPid_"+examPid+" td.personal-star-td a").attr("onclick","collectionExam("+examPid+")");
			}
		}
		
	});

	
}
/** 加载个人测验记录  分页**/
var pageNum = 0;
var pageSize = 5;
function getPersonalExamRecords(){
	
	$.ajax({
		
			url:ctxPath+"/common/ajax/getPersonalExamRecordList",
			data:{pageNum:pageNum},
			success:function(data){
				
				
				
				data = eval("("+data+")");
				/* console.log(data); */
				var html = "";
				for(var temp in data["resultObj"]){
					
					
					html +="<tr ><td class=\"col-md-1 \"><a href=\"javascript:void(0)\" onclick=\"alert();\" class=\"remove-record-btn\" style=\"display:none;\"><span class=\"glyphicon glyphicon-minus-sign\"></span></a> </td><td style=\"text-align:center;\"  class=\"col-md-7\">  <a href=\""+ctxPath+"/common/toExamRecordInfoPage?createTime="+data["resultObj"][temp]["createTime"]+"&examPid="+data["resultObj"][temp]["examPid"]+"\">"+data["resultObj"][temp]["examName"]+"</a></td><td class=\"col-md-4\">"+data["resultObj"][temp]["createTime"]+"</td></tr>";
					
				}
				if(pageNum == 0){
					
					$("#examRecordList").html(html);
				}else{
					$("#more-records").remove();
					$("#examRecordList").append(html);
				}
				if(data["resultObj"] == null||data["resultObj"].length<5){
					$("#examRecordList").append("<tr style=\"background-color: white;\"  id=\"more-records\"><td  class=\"col-md-12 no-more-record\" colspan=\"3\"> 没有更多 </td></tr>")
				}else{
					$("#examRecordList").append("<tr style=\"background-color: white;\" id=\"more-records\"><td  class=\"col-md-12 \" colspan=\"3\"> <button  type=\"button\" class=\"btn btn-default  btn-sm btn-block\" onclick=\"getPersonalExamRecords()\">更多 <span class=\"glyphicon glyphicon-menu-down\"></span></button></td></tr>")
					
				}
				pageNum ++;
				
			}
		
		});
}

/* 刷新测验记录列表  */
function refleshRecords(){
	pageNum = 0;
	$("#examRecordList").html("");
	getPersonalExamRecords();
}
/* 编辑测验记录 */
function editRecords(){
	/* $(".remove-record-btn").each(function(){
		$(this).css("display","block");
	}); */
}
/* 刷新猜你喜欢列表  */
function refleshLike(){
	pageNum = 0;
	loadLikeExams();
}

function setTag(){
	$('#tags-modal').modal({});
	$('#tags-modal').on('hidden.bs.modal', function (e) {
		getUserTags();
	})
	$("#search-tag-key").val("");
	$("#search-tags-resualt").html("");
}

//个人测验标签页
function personalExamTab(){
	$("#examRecordList").html("");//清空数据
	pageNum = 0;
	selectTab(1);
	loadLikeExams();
	getPersonalExamRecords();
	
}
//考试信息标签页
function examInfoTab(){
	selectTab(2);
	
	
}
//订阅资料标签页
function subscriptionMaterialTab(){
	selectTab(3);
}
//我的圈子标签页
function myCircleTab(){
	selectTab(4);
}
//标签页选中
function selectTab(index){
	$("ul.personal-tab li.active").removeClass("active");
	$("div.tab-container").hide();
	var active = $("ul.personal-tab li.tab"+index);
	if(active!=null){
		active.addClass("active");
	}
	$("div.tab-container.tab"+index).show();
	
}
var searchTimer;//监听搜索框的定时器
/**
 * 搜索框自动补全
 * @description 
 * @param input 
 * @date 2016年3月23日
 * @autor cw
 */
function searchAutoComplete(input){
	var value = '';
	var obj = "";
	searchTimer = setInterval(function(){
		if($(input).val() == ""){
			$("#autocomplete-ul").html("<li class=\"dropdown-header\"><i>无搜索结果</i></li>");
			value = "";
			obj = "";
		}else if($(input).val()!= value){
			console.log(value+"==="+$(input).val());
			
			value = $(input).val();
			$.ajax({
				url:ctxPath+"/common/ajax/searchExamAutoComplete",
				data:{key:value},
				success:function(data){
					
					if(data == obj){
						console.log(1);
						return;
					}
					obj = data;
					data = eval("("+data+")");
					var html = "";
					var names = data["resultObj"];
					
					if(names == null ||names.length == 0){
						$("#autocomplete-ul").html("<li class=\"dropdown-header\"><i>无搜索结果</i></li>");
						return;
					}
					
					for(var key in names){
						html += "<li><a href=\"javascript:void(0)\" onclick=\"loadExamsInfoList('"+names[key]+"')\">"+names[key]+"</a></li>";
					}
					$("#autocomplete-ul").html(html);
				}
				
			});
		}
	}, 500);
}
/**
 * 移除监听搜索框的定时器
 * @description  
 * @date 2016年3月22日
 * @autor cw
 */
function removeAutoComplete(){
	clearInterval(searchTimer);
}
/**
 * 加载关键的考试信息
 * @description 
 * @param key 
 * @date 2016年3月23日
 * @autor cw
 */
function loadExamsInfoList(key){
	console.log(key);
	$.ajax({
		url:ctxPath+"/common/ajax/searchExamInfoByKey",
		data:{key:key},
		success:function(data){
			data = eval("("+data+")");
			console.log(data);
			var exams = data["resultObj"];
			var html = '';
			$("#exam-list-1").html("");
			$("#exam-list-2").html("");
			$("#search-error").html("");
			if(exams == null ||exams.length == 0){
				html = "<p style=\"min-height: 300px;line-height: 300px;font-size: 40px;text-align: center;\"> 客官您是不是脸滚键盘了，竟然搜不到资料  </p>";
				html += "<p style=\"font-size: 40px;text-align: right;\">╮（╯＿╰）╭</p>";
				$("#search-error").html(html);
			}else{
				
				
				for(var key in exams){
					console.log((key%2 + 1 ));
					html = "";
					html += "<div class=\"panel panel-_clazz_\">";
					html += "	<div class=\"panel-heading\"> _name_  </div>";
					html += " 	<div class=\"panel-body\">";
					html += "		<div class=\"col-md-12\">";
					html += "			<ul class=\"list-group\">";
					html += "				<li class=\"list-group-item\">机构：_organization_</li>";
					html += "				<li class=\"list-group-item\">描述：_description_</li>";
					html += "				<li class=\"list-group-item\">位置：_location_</li>";
					html += "				<li class=\"list-group-item\">日期：_date_</li>";
					html += "			</ul>";
					html += "		</div>";
					html += "		<div class=\"col-md-12\">";
					html += "			<p style=\"text-align: center;font-size: 20px;\">";
					html += "				<span class=\"glyphicon glyphicon-time\"></span>";
					html += "				<span id=\"begin\"> _beginTime_ </span>";
					html += "				<span class=\"glyphicon glyphicon-arrow-right\"></span>";
					html += "				<span id=\"end\">_endTime_</span>";
					html += "			</p>";
					html += "		</div>";
					html += "		<div class=\"col-md-12\"><hr/>";
					html += "			<div class=\"price\">_price_</div>";
					html += "		</div>";
					html += "	</div>";
					html += "	<div class=\"panel-footer\">";
					html += "		<button type=\"button\" _disabled_ class=\"btn btn-_clazz_ btn-lg btn-block\">_btnValue_</button>";
					html += "	</div>";
					html += "</div>";
					var exam = exams[key];
					console.log(exam);
					var name = exam.examName == null?"":exam.examName;
					var description = exam.description == null ?"":exam.description;
					var organization = exam.organization == null?"":exam.organization;
					var location = exam.location == null?"":exam.location;
					var date = "";
					var beginTime = "";
					var endTime = "";
					var price = exam.price == 0 ? "free":("￥"+exam.price);
					if( exam.examBeginTime != null || exam.examBeginTime != ""){
						date = exam.examBeginTime.substring(0,10);
						beginTime = exam.examBeginTime.substring(11, exam.examBeginTime.length);
					}
					if(exam.examEndTime != null || exam.examEndTime != ""){
						endTime = exam.examEndTime.substring(11, exam.examEndTime.length);
					}
					
					var now = new Date();
					var applyBegin = exam.applyBeginTime.replace(/-/g,"/");
					var applyEnd = exam.applyEndTime.replace(/-/g,"/");
					applyBegin = new Date(applyBegin);
					applyEnd = new Date(applyEnd);
					var btnValue = "";
					var clazz = "";
					var disabled = "";
					if(now < applyEnd){
						btnValue = "报名吧";
						clazz = "primary";
					}else{
						btnValue = "结束啦";
					    clazz = "danger";
						disabled= "disabled=\"\"";
					}
					
					html = html.replace("_name_", name)
								.replace("_description_", description)
								.replace("_organization_", organization)
								.replace("_location_", location)
								.replace("_date_", date)
								.replace("_beginTime_", beginTime)
								.replace("_endTime_", endTime)
								.replace("_price_", price)
								.replace("_clazz_", clazz).replace("_clazz_", clazz)
								.replace("_disabled_", disabled)
								.replace("_btnValue_", btnValue);
					
					$("#exam-list-"+(key%2 + 1 )).append(html);
				
				}
			}
			
		}
	});
}
$(function () {
	getUserInfo();
	personalExamTab(); //加载个人测验
	$('[data-toggle="tooltip"]').tooltip();
	
	
	//考试信息搜索框绑定enter事件
	$("#searchExam").keydown(function(event){
		if(event.which == "13"&&$("#searchExam").val()!=""){
			loadExamsInfoList($("#searchExam").val())
		}    
	});
});

