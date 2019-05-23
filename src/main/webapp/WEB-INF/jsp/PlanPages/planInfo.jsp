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
<title>方案信息</title>
</head>

<body>

	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	  <ul class="layui-tab-title">
	    <li class="layui-this">方案基本信息</li>
	    <li>扑火方式详情</li>
	    <li>水源物资信息</li>
	    <li>切换方案</li>
	  </ul>
	  <div class="layui-tab-content" style="height: 100px;">
	    <div class="layui-tab-item layui-show">
			<h1 id="headName" style="font-size: 25px; color: #01814A;">
				<i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i>
			</h1>
			<br />
<!-- 			<button class="layui-btn layui-btn-sm layui-btn-normal">标示水源</button> -->
<!--     		<button class="layui-btn layui-btn-sm">标示物资点</button> -->
<!--     		<button class="layui-btn layui-btn-sm layui-btn-danger">标示扑救人员</button> -->
<!--     		<button class="layui-btn layui-btn-sm layui-btn-primary">清除标绘</button> -->
    		<hr class="layui-bg-green">
    		<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>当前天气:</h3>
			<h3 style="font-size: 15px;" id="weatherCond">
					
			</h3>
			<br />			
			<hr class="layui-bg-green">
			<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>人员与扑救路径信息</h3>
			<div id="routesCond"></div>
	    </div>
	    <div class="layui-tab-item">
			<h1 id="p2headName" style="font-size: 25px; color: #01814A;">
				<i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i>
			</h1>
			<hr class="layui-bg-green">
			<h3 style="font-size: 15px;" id="p2PlanIntro"></h3>
	    </div>
	    <div class="layui-tab-item">
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
		</div>
	    <div class="layui-tab-item">
	    	<div id="avPlans"></div>
		</div>
	  </div>
	</div> 	
 
	<script type="text/javascript" src="/js/jquery-latest.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	layui.use('element', function(){
		  var $ = layui.jquery
		  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块		  
		});	
	
	function switchPlan(zmLev, planID){
	    parent.clearCanvas();
		parent.testSegment(zmLev, planID);
		parent.drawSwitchRoutes();
	    var index = parent.layer.getFrameIndex(window.name);
	    parent.layer.close(index);
	}
		
	$(document).ready(function(){
		  var routeLoad = parent.sendHasroute();
		  if(routeLoad < 1){
			  alert("请先获取方案再查看方案详情！");
			  var index = parent.layer.getFrameIndex(window.name);
			  parent.layer.close(index);
		  } else {
			  			  		
			  var SltdPlanID = parent.sendCurPlanID();
			  var avPlans = parent.sendAvPlans();
		  
			  $.ajax( {
			     async : false, //这里不开异步，以防点数据赋值混乱
			     cache : false, //是否使用缓存
			     type : 'post', //请求方式,post
			     dataType : "json", //数据传输格式
			     url : "/map/planSketch", //请求链接
			     contentType:"application/json",
			     data:JSON.stringify(avPlans),
			     error : function() {
			       alert('网络故障！');
			     },
			     success : function(data) {
			       if(data.msg == 1){
			    	 console.log("已获取预案简介");
			    	 var plansTable = new Array();
					 plansTable.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
							  + "<thead><tr><th>方案编号</th><th>方案名称</th><th>扑救队伍</th><th>预估到达时间</th><th>预估路程</th><th>操作</th></tr></thead>"
							  + "<tbody>");
					 $.each(data.skchPlans, function(index, skchPlan){
						  plansTable.push("<tr><td>" + skchPlan.planID + "</td>"
						  		  + "<td>" + skchPlan.planName + "</td>" 
								  + "<td>" + skchPlan.planIntro + "</td>"
								  + "<td>" + skchPlan.arrTime + "</td>"
								  + "<td>" + skchPlan.rtsLen + "</td>"
								  + "<td><button class='layui-btn layui-btn-normal' onclick='switchPlan(1,"+ skchPlan.planID +")'>切换方案</button>" + "</td>"
								  + "</tr>");					
						}
			 		 )
			 		 plansTable.push("</tbody></table>");
					 $("#avPlans").append(plansTable.join(""));
			       }
			     }
			  });
			  
			  
			  var req = {"rtID":SltdPlanID};
			  $.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/map/planDetInfo", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       if(data.msg == 1){
				    	 console.log("已获取预案详情");
				    	 var planDetInfo = new Array();
				    	 planDetInfo.push(data.planName);
				    	 $("#headName").text(planDetInfo);
				    	 $("#p2headName").text(planDetInfo);
				    	 planDetInfo.length = 0;
				    	 planDetInfo.push(data.planIntro);
				    	 $("#p2PlanIntro").text(planDetInfo);
				    	 planDetInfo.length = 0;
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
						 planDetInfo.length = 0;
						 var crewInfo = data.crewInfo;
						 var segedRoutes = data.segedRoutes;
						 for(var i=0; i<crewInfo.length; i++){
							 if(crewInfo[i].crewID == 1){
								 planDetInfo.push("<img width='30px' height='30px' src='/image/icons/staff2.png' />");
							 } 
							 if(crewInfo[i].crewID == 2){
								 planDetInfo.push("<img width='30px' height='30px' src='/image/icons/staff1.png' />");
							 }
							 planDetInfo.push("<h3 style='font-size: 15px;'>" + crewInfo[i].crewName +" " + crewInfo[i].crewType + " " + crewInfo[i].headCount + "人</h3>");
						     planDetInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
										  + "<thead><tr><th>路径ID</th><th>路径类型</th><th>路径长度</th><th>预计通过时间</th></tr></thead>"
										  + "<tbody>");
							 $.each(segedRoutes[i], function(index, route){
									 if(route.rtType == 1){
										 planDetInfo.push("<tr><td>" + route.rtID + "</td>" 
												  + "<td>防火公路</td>"
												  + "<td>" + route.rtLength + "km</td>"
												  + "<td>" + route.rtTime + "min</td>"
												  + "</tr>"); 
									 } else {
										 planDetInfo.push("<tr><td>" + route.rtID + "</td>" 
												  + "<td>防火小路</td>"
												  + "<td>" + route.rtLength + "km</td>"
												  + "<td>" + route.rtTime + "min</td>"
												  + "</tr>"); 
									 }
								}
					 		 )
					 		 planDetInfo.push("</tbody></table>");							 
						 }
						 $("#routesCond").append(planDetInfo.join(""));
						 planDetInfo.length = 0;
						 $.ajax( {
							 async : true, //这里不开异步，以防点数据赋值混乱
							 cache : false, //是否使用缓存
							 type : 'get', //请求方式,post
							 dataType : "json", //数据传输格式
							 url : "http://api.yytianqi.com/observe?city=39.93,116.40&key=ejajdlntnsmf3n8s", //请求链接
							 error : function() {
								 alert('网络故障！');
							 },
							 success : function(data) {
								 var weather = data.data;
								 var planDetInfo = new Array();
								 planDetInfo.push("<i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe62e;</i> 气象：" + weather.tq);
								 planDetInfo.push("<i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe609;</i> 风向：" + weather.fx);
								 planDetInfo.push("<i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe64f;</i> 风力：" + weather.fl);
								 planDetInfo.push("<i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe628;</i> 温度：" + weather.qw + "°");
								 planDetInfo.push("<i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe636;</i> 湿度：" + weather.sd + "%");
								 $("#weatherCond").append(planDetInfo.join(""));
							 }
						 });
						 //$("#weatherCond").append(planDetInfo.join(""));
				       }
				     }
				  });
			  
			  
		  } 
	});				
	</script>   
</body>
</html>