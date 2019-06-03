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
<title>创建扑火预案</title>
</head>

<body>

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>创建扑火预案</legend>
	</fieldset>
	
	<form class="layui-form layui-form-pane" action="">
	<div class="layui-collapse" lay-filter="test">
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">方案名称、扑火方式与注意事项</h2>
		<div class="layui-colla-content layui-show">

			  <div class="layui-form-item">
			    <label class="layui-form-label">方案名称</label>
			    <div class="layui-input-inline">
			      <input type="text" name="planName" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|title">
			    </div>
			  </div>
			  			  
			  <div class="layui-form-item layui-form-text">
			    <label class="layui-form-label">方案介绍、扑火方式与注意事项</label>
			    <div class="layui-input-block">
			      <textarea placeholder="请输入方案的详细介绍" name="planIntro" class="layui-textarea" lay-verify="required"></textarea>
			    </div>
			  </div>
			  			  			
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">扑救路线</h2>
		<div class="layui-colla-content">
			 
			<div id="cfrmRtsInfo"></div>
		    <div class="layui-inline">
		      <label class="layui-form-label">扑救人员</label>
		      <div class="layui-input-inline">
		        <select name="startpt" lay-search="" lay-verify="required">
		          <option value="">直接选择或搜索选择</option>
		          <option value="1">海淀区消防支队</option>
		          <option value="2">林场场部消防队</option>
		          <option value="3">居民学生消防队</option>
		          <option value="4">玻璃乡消防队</option>
		          <option value="5">嘻嘻消防队</option>
		        </select>
		      </div>
		    </div>
	    
	    </div>
	  </div>
	</div>
		<button style="margin-left:15cm;" class="layui-btn" lay-submit="" lay-filter="demo1">创建预案</button>
    	<button type="reset" class="layui-btn layui-btn-primary">重置</button> 
	</form>
	<br />

 
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	
	var crewIDs = new Array();			//扑救人员ID集合
	var routes = new Array();			//路径集合，每一项是条完整路线， 对应到人员
	var cfrmCrNames = new Array();		//扑救人员名称集合
    var cfrmEndRts = new Array();		//目标路径集合
    var materials = new Array();		//物资点集合
    var waterSource = new Array();		//水源点集合

	var rtTbStatus = 0;				//路径表格的状态，0表示目前rtTb目前为空，1表示目前rtTb目前非空，下面两个相同
	var matTbStatus = 0;
	var watTbStatus = 0;
	var revrBox = false;			//记录反向复选框的值
	
	function confirmRts(){

		$("#cfrmRtsInfo").empty();
		var cfrmInfo = new Array();
		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'></colgroup>"
				  + "<thead><tr><th>扑救人员</th><th>终点路径</th><th>经过路段</th></tr></thead>"
				  + "<tbody>");
		for(var i=0; i<cfrmEndRts.length; i++){
			cfrmInfo.push("<tr><td>" + cfrmCrNames[i] + "</td>" 
					  + "<td>" + cfrmEndRts[i] + "</td>"
					  + "<td>" + routes[i] + "</td>"
					  + "</tr>");					
		}
		cfrmInfo.push("</tbody></table>");
		$("#cfrmRtsInfo").append(cfrmInfo.join(""));
		$("#rtsTable").empty();
		rtTbStatus = 0;			//路径表格状态改变，表格清空
	}
	
	function confirmMats(){
		
		$("#cfrmMats").empty();
		var cfrmInfo = new Array();
		cfrmInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>已选定的物资点</h3>");
		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'></colgroup>"
				  + "<thead><tr><th>选定类别</th><th>选定内容</th></tr></thead>"
				  + "<tbody>");
		cfrmInfo.push("<tr><td>物资点</td>" 
				  + "<td>" + materials.join(",") + "</td>"
				  + "</tr>");					
		cfrmInfo.push("</tbody></table>");
		$("#cfrmMats").append(cfrmInfo.join(""));
		$("#matInfoTable").empty();
		matTbStatus = 0;        //物资点信息表格状态改变，表格清空
	}
	
	function confirmWats(){
		
		$("#cfrmWats").empty();
		var cfrmInfo = new Array();
		cfrmInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>已选定的水源点</h3>");
		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'></colgroup>"
				  + "<thead><tr><th>选定类别</th><th>选定内容</th></tr></thead>"
				  + "<tbody>");
		cfrmInfo.push("<tr><td>水源点</td>" 
				  + "<td>" + waterSource.join(",") + "</td>"
				  + "</tr>");					
		cfrmInfo.push("</tbody></table>");
		$("#cfrmWats").append(cfrmInfo.join(""));
		$("#watInfoTable").empty();
		watTbStatus = 0;
	}
	
	function reviseRts(){
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句	  
				 layer.open({
				     id: 'reviseWin' //防止重复弹出
				     ,title: '输入路径'
				     ,content: '<input type="text" id="rvdRts" />'
				     ,btn: '关闭全部'
				     ,btnAlign: 'c' //按钮居中
				     ,shade: 0 //不显示遮罩
				     ,yes: function(){
				    	 var routes = $("#rvdRts").val();
				    	 if(!/^(\d+,)*\d+$/.test(routes)){
							 layer.alert("请按照格式输入路径编号，示例：4,2,3");
				    	 } else {
					    	 rvdRtsReq($("#rvdRts").val());
					    	 layer.closeAll(); 
				    	 }
				     }
				   });
		 });
	}
	
	function reviseMats(){
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句	  
				 layer.open({
				     id: 'reviseMatWin' //防止重复弹出
				     ,title: '输入物资点'
				     ,content: '<input type="text" id="rvdMats" />'
				     ,btn: '关闭全部'
				     ,btnAlign: 'c' //按钮居中
				     ,shade: 0 //不显示遮罩
				     ,yes: function(){
				    	 var materials = $("#rvdMats").val();
				    	 if(!/^(\d+,)*\d+$/.test(materials)){
							 layer.alert("请按照格式输入物资点编号，示例：4,2,3");
				    	 } else {
					    	 rvdMatsReq($("#rvdMats").val());
					    	 layer.closeAll();
				    	 }
				     }
				   });
		 });
	}
	
	function reviseWater(){
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
				 layer.open({
				     id: 'reviseWatWin' //防止重复弹出
				     ,title: '输入水源点'
				     ,content: '<input type="text" id="rvdWats" />'
				     ,btn: '关闭全部'
				     ,btnAlign: 'c' //按钮居中
				     ,shade: 0 //不显示遮罩
				     ,yes: function(){
				    	 var waterSource = $("#rvdWats").val();
				    	 if(!/^(\d+,)*\d+$/.test(waterSource)){
							 layer.alert("请按照格式输入水源点编号，示例：4,2,3");
				    	 } else {
					    	 rvdWatsReq($("#rvdWats").val());
					    	 layer.closeAll();
				    	 }
				     }
				   });
		 });
	}
	
	function rvdMatsReq(rvdStr){
		materials[materials.length-1] = rvdStr;
	    var req = {"materials":rvdStr};
		
		$.ajax( {
		     async : false, //这里不开异步，以防点数据赋值混乱
		     cache : false, //是否使用缓存
		     type : 'post', //请求方式,post
		     dataType : "json", //数据传输格式
		     url : "/emrPlan/rvdMats", //请求链接
		     contentType:"application/json",
		     data:JSON.stringify(req),
		     error : function() {
		       alert('网络故障！');
		     },
		     success : function(data) {
		       	 if(data.msg == 1){
		       		 
		       		console.log("获得了修改后的物资点信息！");
		       		if(data.materials.length > 0){
			       		$("#matInfoTable").empty();
						var poiInfo = new Array();
						poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>物资点信息</h3>");
						poiInfo.push("<table class='layui-table'><colgroup><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'></colgroup>"
								  + "<thead><tr><th>物资点ID</th><th>物资点名称</th><th>GPS</th><th>阻燃服</th><th>运兵车</th><th>发电机</th><th>水管</th></tr></thead>"
								  + "<tbody>");
						$.each(data.materials, function(index, mat){
							poiInfo.push("<tr><td>" + mat.matID + "</td>" 
									  + "<td>" + mat.matName + "</td>"
									  + "<td>" + mat.ffSuit + "</td>"
									  + "<td>" + mat.gpsDevice + "</td>"
									  + "<td>" + mat.transCar + "</td>"
									  + "<td>" + mat.dynamotor + "</td>"
									  + "<td>" + mat.waterPipe + "</td>"
									  + "</tr>");					
							}
				 		)
						poiInfo.push("</tbody></table>");
						poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseMats()'>修改</button>");
						poiInfo.push("<button type='button' class='layui-btn' onclick='confirmMats()'>确定添加</button>");
					 	$("#matInfoTable").append(poiInfo.join(""));
					 	matTbStatus = 1;
					 	console.log("物资点数组");
					 	console.log(materials);
		       		}
		       	 }				    	 				       
		     }
		  });
	}
	
	function rvdWatsReq(rvdStr){
		waterSource[waterSource.length-1] = rvdStr;
	    var req = {"watersource":rvdStr};
		
		$.ajax( {
		     async : false, //这里不开异步，以防点数据赋值混乱
		     cache : false, //是否使用缓存
		     type : 'post', //请求方式,post
		     dataType : "json", //数据传输格式
		     url : "/emrPlan/rvdWats", //请求链接
		     contentType:"application/json",
		     data:JSON.stringify(req),
		     error : function() {
		       alert('网络故障！');
		     },
		     success : function(data) {
		       	 if(data.msg == 1){
		       		 
		       		console.log("获得了修改后的水源点信息！");
		       		if(data.waterSources.length > 0){				       			
			       		$("#watInfoTable").empty();
						var poiInfo = new Array();
						poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>水源点信息</h3>");
						poiInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
								  + "<thead><tr><th>水源点ID</th><th>水源点名称</th><th>水源类型</th><th>蓄水量</th></tr></thead>"
								  + "<tbody>");
						$.each(data.waterSources, function(index, water){
							poiInfo.push("<tr><td>" + water.watSrID + "</td>" 
									  + "<td>" + water.watSrName + "</td>"
									  + "<td>" + water.watSrType + "</td>"
									  + "<td>" + water.watQuantity + "</td>"
									  + "</tr>");					
							}
				 		)
						poiInfo.push("</tbody></table>");
						poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseWater()'>修改</button>");
						poiInfo.push("<button type='button' class='layui-btn' onclick='confirmWats()'>确定添加</button>");
					 	$("#watInfoTable").append(poiInfo.join(""));
					 	watTbStatus = 1;
					 	console.log("水源点数组");
					 	console.log(waterSource);							 	
		       		}
		       	 }				    	 				       
		     }
		  });
	}
	
	
	function rvdRtsReq(rvdStr){
		
		routes[routes.length-1] = rvdStr;
		var rvdRts = {"routes":rvdStr};
		$.ajax( {
		     async : false, //这里不开异步，以防点数据赋值混乱
		     cache : false, //是否使用缓存
		     type : 'post', //请求方式,post
		     dataType : "json", //数据传输格式
		     url : "/emrPlan/reviseRts", //请求链接
		     contentType:"application/json",
		     data:JSON.stringify(rvdRts),
		     error : function() {
		       alert('网络故障！');
		     },
		     success : function(data) {
		       	 if(data.msg == 1){
		       		 					
					$("#rtsTable").empty();
					var rvdRtInfo = new Array();					
					rvdRtInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
							  + "<thead><tr><th>路径ID</th><th>路径类型</th><th>路径长度</th><th>预计通过时间</th></tr></thead>"
							  + "<tbody>");
				 	$.each(data.rvdRoutes, function(index, route){
						 if(route.rtType == 1){
							 rvdRtInfo.push("<tr><td>" + route.rtID + "</td>" 
									  + "<td>防火公路</td>"
									  + "<td>" + route.rtLength + "km</td>"
									  + "<td>" + route.rtTime + "min</td>"
									  + "</tr>"); 
						 } else {
							 rvdRtInfo.push("<tr><td>" + route.rtID + "</td>" 
									  + "<td>防火小路</td>"
									  + "<td>" + route.rtLength + "km</td>"
									  + "<td>" + route.rtTime + "min</td>"
									  + "</tr>"); 
						 }
					   }
		 		 	)
		 		 	rvdRtInfo.push("</tbody></table>");
				 	rvdRtInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseRts()'>修改</button>");
				 	rvdRtInfo.push("<button type='button' class='layui-btn' onclick='confirmRts()'>确定添加</button>");
				 	$("#rtsTable").append(rvdRtInfo.join(""));
				 	rtTbStatus = 1;
				 	console.log(routes);
		       	 } else {
		       		 alert("获取新路径信息失败！");
		       	 }
		    	 		       
		     }
		  });
		
	}
		  		  	
	layui.use('element', function(){
		  var $ = layui.jquery
		  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块		  
		});	
	
	layui.use(['form', 'layedit', 'laydate'], function(){			//必须监听表单，否则某些样式出不来
		  var form = layui.form
		  ,layer = layui.layer
		  ,layedit = layui.layedit
		  ,laydate = layui.laydate;		  
		
		  //日期与时间选择器
		  laydate.render({
			    elem: '#avTime_st'
			    ,type: 'time'
		  });
		  laydate.render({
			    elem: '#avTime_ed'
			    ,type: 'time'
		  });
		  
		  //自定义验证规则
		  form.verify({
		    title: [/[\u4e00-\u9fa5]{2,30}$/, '方案名称需为2个以上中文字符']
		    ,temp: function(value){
		        if((value.length > 0) && (!/^[0-9]+([.]{1}[0-9]+){0,10}$/.test(value))){
		            return '温度需为整数或小数';
		          }
		        }
		  });
		  
		  //监听反向复选框
		  form.on('checkbox(reverseBox)', function(data){
			  revrBox = data.elem.checked;				//true或false
			});  
		
		  //提交整个表单
		  form.on('submit(demo1)', function(data){
										  
			    //整合所有数据拼成Emergency对象
				var req = {"crew":crewIDs.join(","), "planName":data.field.planName, "planIntro":data.field.planIntro}
			    		
				$.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/submitNewPlan", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       	 if(data.msg == 1){
				       		
				       		 console.log("创建新预案成功！")
				       		 layer.alert("创建新预案成功！");
				       	 }				    	 				       
				     }
				});
		    console.log(JSON.stringify(req));
		    
		    return false;
		  });
		  
		  //获取单个POI信息
		  form.on('submit(searchPois)', function(data){
				
				var req = {"materials":data.field.material, "watersource":data.field.waterSrc, "routes":""};
				
				$.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/srchPois", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       	 if(data.msg == 1){
				       		 
				       		console.log("获得了POI信息！");
				       		if(data.materials.length > 0){
				       			for(var i=0; i<data.materials.length; i++){
				       				if(matTbStatus == 1){
				       					materials[materials.length-1] = "" + data.materials[i].matID;	//这个地方是基于取回的物资点数组只有一个值的情况，目前的查询方法也确实只会返回一个值
				       				} else {
				       					materials.push("" + data.materials[i].matID);
				       				}
				       				//materials.push("" + data.materials[i].matID);
				       			}
					       		$("#matInfoTable").empty();
								var poiInfo = new Array();
								poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>物资点信息</h3>");
								poiInfo.push("<table class='layui-table'><colgroup><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'></colgroup>"
										  + "<thead><tr><th>物资点ID</th><th>物资点名称</th><th>GPS</th><th>阻燃服</th><th>运兵车</th><th>发电机</th><th>水管</th></tr></thead>"
										  + "<tbody>");
								$.each(data.materials, function(index, mat){
									poiInfo.push("<tr><td>" + mat.matID + "</td>" 
											  + "<td>" + mat.matName + "</td>"
											  + "<td>" + mat.ffSuit + "</td>"
											  + "<td>" + mat.gpsDevice + "</td>"
											  + "<td>" + mat.transCar + "</td>"
											  + "<td>" + mat.dynamotor + "</td>"
											  + "<td>" + mat.waterPipe + "</td>"
											  + "</tr>");					
									}
						 		)
								poiInfo.push("</tbody></table>");
								poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseMats()'>修改</button>");
								poiInfo.push("<button type='button' class='layui-btn' onclick='confirmMats()'>确定添加</button>");
							 	$("#matInfoTable").append(poiInfo.join(""));
							 	matTbStatus = 1;
							 	console.log("物资点数组");
							 	console.log(materials);
				       		}
				       		if(data.waterSources.length > 0){
				       			for(var i=0; i<data.waterSources.length; i++){
				       				if(watTbStatus == 1){
				       					waterSource[waterSource.length-1] = "" + data.waterSources[i].watSrID;
				       				} else {
				       					waterSource.push("" + data.waterSources[i].watSrID);
				       				}
				       				//waterSource.push("" + data.waterSources[i].watSrID);
				       			}				       			
					       		$("#watInfoTable").empty();
								var poiInfo = new Array();
								poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>水源点信息</h3>");
								poiInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
										  + "<thead><tr><th>水源点ID</th><th>水源点名称</th><th>水源类型</th><th>蓄水量</th></tr></thead>"
										  + "<tbody>");
								$.each(data.waterSources, function(index, water){
									poiInfo.push("<tr><td>" + water.watSrID + "</td>" 
											  + "<td>" + water.watSrName + "</td>"
											  + "<td>" + water.watSrType + "</td>"
											  + "<td>" + water.watQuantity + "</td>"
											  + "</tr>");					
									}
						 		)
								poiInfo.push("</tbody></table>");
								poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseWater()'>修改</button>");
								poiInfo.push("<button type='button' class='layui-btn' onclick='confirmWats()'>确定添加</button>");
							 	$("#watInfoTable").append(poiInfo.join(""));
							 	watTbStatus = 1;
							 	console.log("水源点数组");
							 	console.log(waterSource);							 	
				       		}
				       	 }				    	 				       
				     }
				  });
			  
			    return false;
		  });
		  
		  //根据路径获取POI信息
		  form.on('submit(srchPoisByRts)', function(data){
			  
			if(routes.length < 1){
				alert("请先确定预案的路径！");
			} else {	
			  
			    var req = {"routes":routes.join(","), "materials":"", "watersource":""};
				
				$.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/srchPois", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       	 if(data.msg == 1){
				       		 
				       		console.log("根据路径获得了POI信息！");
				       		if(data.materials.length > 0){
				       			var matTempStr = ""
					       		for(var i=0; i<data.materials.length; i++){
				       				if(i == data.materials.length-1){
				       					matTempStr = matTempStr + data.materials[i].matID;
				       				} else {
				       					matTempStr = matTempStr + data.materials[i].matID + ",";
				       				}				       								       				
					       		}
				       			if(matTbStatus == 1){
				       				materials[materials.length-1] = matTempStr;
				       			} else {
				       				materials.push(matTempStr);
				       			}
				       			//materials.push(matTempStr);
					       		$("#matInfoTable").empty();
								var poiInfo = new Array();
								poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>物资点信息</h3>");
								poiInfo.push("<table class='layui-table'><colgroup><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'></colgroup>"
										  + "<thead><tr><th>物资点ID</th><th>物资点名称</th><th>GPS</th><th>阻燃服</th><th>运兵车</th><th>发电机</th><th>水管</th></tr></thead>"
										  + "<tbody>");
								$.each(data.materials, function(index, mat){
									poiInfo.push("<tr><td>" + mat.matID + "</td>" 
											  + "<td>" + mat.matName + "</td>"
											  + "<td>" + mat.ffSuit + "</td>"
											  + "<td>" + mat.gpsDevice + "</td>"
											  + "<td>" + mat.transCar + "</td>"
											  + "<td>" + mat.dynamotor + "</td>"
											  + "<td>" + mat.waterPipe + "</td>"
											  + "</tr>");					
									}
						 		)
								poiInfo.push("</tbody></table>");
								poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseMats()'>修改</button>");
								poiInfo.push("<button type='button' class='layui-btn' onclick='confirmMats()'>确定添加</button>");
							 	$("#matInfoTable").append(poiInfo.join(""));
							 	matTbStatus = 1;   			//物资表格状态变化，表格中添加数据
							 	console.log("物资点数组");
							 	console.log(materials);
				       		}
				       		if(data.waterSources.length > 0){
				       			var watTempStr = ""
				       			for(var i=0; i<data.waterSources.length; i++){
				       				if(i == data.waterSources.length-1){
				       					watTempStr = watTempStr + data.waterSources[i].watSrID;
				       				} else {
				       					watTempStr = watTempStr + data.waterSources[i].watSrID + ",";
				       				}				       								       				
				       			}
				       			if(watTbStatus == 1){
				       				waterSource[waterSource.length-1] = watTempStr;
				       			} else {
				       				waterSource.push(watTempStr);
				       			}
				       			//waterSource.push(watTempStr);
					       		$("#watInfoTable").empty();
								var poiInfo = new Array();
								poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>水源点信息</h3>");
								poiInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
										  + "<thead><tr><th>水源点ID</th><th>水源点名称</th><th>水源类型</th><th>蓄水量</th></tr></thead>"
										  + "<tbody>");
								$.each(data.waterSources, function(index, water){
									poiInfo.push("<tr><td>" + water.watSrID + "</td>" 
											  + "<td>" + water.watSrName + "</td>"
											  + "<td>" + water.watSrType + "</td>"
											  + "<td>" + water.watQuantity + "</td>"
											  + "</tr>");					
									}
						 		)
								poiInfo.push("</tbody></table>");
								poiInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseWater()'>修改</button>");
								poiInfo.push("<button type='button' class='layui-btn' onclick='confirmWats()'>确定添加</button>");
							 	$("#watInfoTable").append(poiInfo.join(""));
							 	watTbStatus = 1;  			//水源点信息表状态改变，填充数据
							 	console.log("水源点数组");
							 	console.log(waterSource);							 	
				       		}
				       	 }				    	 				       
				     }
				  });
				}
			    return false;
		  });
		  
		  //获取最短路径信息
		  form.on('submit(searchRts)', function(data){
			
			if(data.field.startpt == "" || data.field.endRtID == ""){
				layer.alert("请完善起终点信息进行路径计算！");
			} else {
				
	       		if(rtTbStatus == 1){	//此时路径表格非空，也就是用户没有点击确认，需要再计算路径或是修改
	       			crewIDs[crewIDs.length-1] = parseInt(data.field.startpt);
	       			if(revrBox == true){		//如果反向box选中，则存入复制，反之则正值，默认正值(未选中)
	       				cfrmEndRts[cfrmEndRts.length-1] = -parseInt(data.field.endRtID);
	       			} else {
	       				cfrmEndRts[cfrmEndRts.length-1] = parseInt(data.field.endRtID);
	       			}	       			
	       		} else {				//此时路径表格为空，用户操作为新增一条路线
	       			crewIDs.push(parseInt(data.field.startpt));
	       			if(revrBox == true){
	       				cfrmEndRts.push(-parseInt(data.field.endRtID));
	       			} else {
	       				cfrmEndRts.push(parseInt(data.field.endRtID));
	       			}
	       		}
				//crewIDs.push(data.field.startpt);
				//cfrmEndRts.push(data.field.endRtID);
	
				var srchRtsCond = {"zmLev":data.field.startpt, "rtID":data.field.endRtID};
							
				$.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/countRts", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(srchRtsCond),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       	 if(data.msg == 1){
				       		 
				       		console.log("获得了最短路径！");
				       		
				       		if(rtTbStatus == 1){	//此时路径表格非空，也就是用户没有点击确认，需要再计算路径或是修改
				       			routes[routes.length-1] = data.passRtsStr;
				       			cfrmCrNames[cfrmCrNames.length-1] = data.curCrName;
				       		} else {				//此时路径表格为空，用户操作为新增一条路线
								routes.push(data.passRtsStr);
								cfrmCrNames.push(data.curCrName);
				       		}
							//routes.push(data.passRtsStr);
							//cfrmCrNames.push(data.curCrName);
							
							$("#rtsTable").empty();
							var rtDetInfo = new Array();
							rtDetInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
									  + "<thead><tr><th>路径ID</th><th>路径类型</th><th>路径长度</th><th>预计通过时间</th></tr></thead>"
									  + "<tbody>");
						 	$.each(data.routes, function(index, route){
								 if(route.rtType == 1){
									 rtDetInfo.push("<tr><td>" + route.rtID + "</td>" 
											  + "<td>防火公路</td>"
											  + "<td>" + route.rtLength + "km</td>"
											  + "<td>" + route.rtTime + "min</td>"
											  + "</tr>"); 
								 } else {
									 rtDetInfo.push("<tr><td>" + route.rtID + "</td>" 
											  + "<td>防火小路</td>"
											  + "<td>" + route.rtLength + "km</td>"
											  + "<td>" + route.rtTime + "min</td>"
											  + "</tr>"); 
								 }
							   }
				 		 	)
				 		 	rtDetInfo.push("</tbody></table>");
						 	rtDetInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseRts()'>修改</button>");
						 	rtDetInfo.push("<button type='button' class='layui-btn' onclick='confirmRts()'>确定添加</button>");
						 	$("#rtsTable").append(rtDetInfo.join(""));
						 	rtTbStatus = 1;   //路径表格状态改变，表格中有路线信息
						 	console.log(routes);
				       	 }
				    	 
				       
				     }
				  });
			}
		    return false;
		  });
	
	});
						
	</script>   
</body>
</html>