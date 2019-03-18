<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="../plugins/layui/css/layui.css" media="all" /> -->
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/css/global.css" media="all">
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/table.css" />
<title>方案详情（用于列表查看预案详情）</title>
</head>

<body>

	  
	  
			<h1 style="font-size: 20px; color: #01814A;">
				<i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i>
				人员信息
			</h1>
			<hr class="layui-bg-green">
			<div id="routesCond"></div>
			
			<h1 style="font-size: 20px; color: #01814A;">
				<i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i>
				物资点信息
			</h1>
			<hr class="layui-bg-green">
			<div id="p3Mats"></div>
			
			<h1 style="font-size: 20px; color: #01814A;">
				<i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i>
				水源点信息
			</h1>
			<hr class="layui-bg-green">
			<div id="p3WaterSrc"></div>
		
	 
		
 
	<script type="text/javascript" src="/js/jquery-latest.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	layui.use('element', function(){
		  var $ = layui.jquery
		  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块		  
		});	
	
		
	$(document).ready(function(){
		  			  			  		
			  var planID = parent.sendPlanID();
		  			  			  
			  var req = {"planID":planID};
			  $.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/detInfo", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       if(data.msg == 1){
				    	 console.log("已获取预案详情");
				    	 var planDetInfo = new Array();
				    	 planDetInfo.push("<table class='layui-table'><colgroup><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'></colgroup>"
								  + "<thead><tr><th>物资点ID</th><th>物资点名称</th><th>GPS</th><th>阻燃服</th><th>运兵车</th><th>发电机</th><th>水管</th></tr></thead>"
								  + "<tbody>");
						 $.each(data.mats, function(index, mat){
							 planDetInfo.push("<tr><td>" + mat.matID + "</td>" 
									  + "<td>" + mat.matName + "</td>"
									  + "<td>" + mat.ffSuit + "</td>"
									  + "<td>" + mat.gpsDevice + "</td>"
									  + "<td>" + mat.transCar + "</td>"
									  + "<td>" + mat.dynamotor + "</td>"
									  + "<td>" + mat.waterPipe + "</td>"
									  + "</tr>");					
							}
				 		 )
				 		 planDetInfo.push("</tbody></table>");
						 $("#p3Mats").append(planDetInfo.join(""));
						 planDetInfo.length = 0;
				    	 planDetInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
								  + "<thead><tr><th>水源点ID</th><th>水源点名称</th><th>水源类型</th><th>蓄水量</th></tr></thead>"
								  + "<tbody>");
						 $.each(data.watSrc, function(index, water){
							 planDetInfo.push("<tr><td>" + water.watSrID + "</td>" 
									  + "<td>" + water.watSrName + "</td>"
									  + "<td>" + water.watSrType + "</td>"
									  + "<td>" + water.watQuantity + "</td>"
									  + "</tr>");					
							}
				 		 )
				 		 planDetInfo.push("</tbody></table>");
						 $("#p3WaterSrc").append(planDetInfo.join(""));
						 var crewInfo = data.crewInfo;
						 planDetInfo.length = 0;
						 planDetInfo.push("<ul class='layui-timeline'>");	
						 for(var i=0; i<crewInfo.length; i++){
							 planDetInfo.push("<li class='layui-timeline-item'><i class='layui-icon layui-timeline-axis'>&#xe63f;</i><div class='layui-timeline-content layui-text'><h3  class='layui-timeline-title'>" 
							 + crewInfo[i].crewName +"</h3><p>" + crewInfo[i].crewType + " " + crewInfo[i].headCount + "人</p><p>" + crewInfo[i].leader + "  </p>"
							 + "</div></li>");				     					 		 							 
						 }
						 planDetInfo.push("</ul>");
						 $("#routesCond").append(planDetInfo.join(""));
						 planDetInfo.length = 0;
				       }
				     }
				  });
			  
			  
		 
	});				
	</script>   
</body>
</html>