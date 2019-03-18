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
<title>修改扑火预案</title>
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
			      <input type="text" name="planName" id="planName" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|title">
			    </div>
			  </div>
			  			  
			  <div class="layui-form-item layui-form-text">
			    <label class="layui-form-label">方案介绍、扑火方式与注意事项</label>
			    <div class="layui-input-block">
			      <textarea placeholder="请输入方案的详细介绍" id="planIntro" name="planIntro" class="layui-textarea" lay-verify="required"></textarea>
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
		        <select name="startpt" id="startpt" lay-search="" lay-filter="startpt">
		          <option value="">直接选择或搜索选择</option>
		          <option value="1">海淀区消防支队</option>
		          <option value="2">林场场部消防队</option>
		          <option value="3">居民学生消防队</option>
		          <option value="4">玻璃乡消防队</option>
		          <option value="5">嘻嘻消防队</option>
		        </select>
		      </div>
		    </div>
		    
		    <div class="layui-inline">
		      <label class="layui-form-label">覆盖范围</label>
		      <div class="layui-input-inline">
		        <select name="endRtID" id="endRtID" lay-search="">
		          <option value="">选择终点路径ID，如有疑问可咨询管理员</option>
		          <option value="1">1</option>
		          <option value="2">2</option>
		          <option value="3">3</option>
		          <option value="4">4</option>
		          <option value="5">5</option>
		          <option value="6">6</option>
		          <option value="7">7</option>
		          <option value="8">8</option>
		          <option value="9">9</option>
		          <option value="10">10</option>
		          <option value="11">11</option>
		          <option value="12">12</option>
		          <option value="13">13</option>
		          <option value="14">14</option>
		          <option value="15">15</option>
		          <option value="16">16</option>
		          <option value="17">17</option>
		          <option value="18">18</option>
		          <option value="19">19</option>
		          <option value="20">20</option>
		          <option value="21">21</option>
		          <option value="22">22</option>
		          <option value="23">23</option>
		          <option value="24">24</option>
		          <option value="25">25</option>
		          <option value="26">26</option>
		          <option value="27">27</option>
		          <option value="28">28</option>
		          <option value="29">29</option>
		          <option value="30">30</option>
		          <option value="31">31</option>
		          <option value="32">32</option>
		          <option value="33">33</option>
		          <option value="34">34</option>
		          <option value="35">35</option>
		          <option value="36">36</option>
		          <option value="37">37</option>
		          <option value="38">38</option>
		        </select>
		      </div>
		    </div>
		    
		    <div class="layui-inline">
		    	<div class="layui-input-inline">
		    		<input type="checkbox" name="reverse" id="reverse" lay-skin="primary" title="反向" lay-filter="reverseBox">
		    	</div>
		    </div>
		    
		    <button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="searchRts">计算路线</button>			  			  			
	    
	    	<div id="rtsTable"></div>
	    	
	    
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">物资点与水源点</h2>
		<div class="layui-colla-content">
			
			<div id="cfrmMats"></div>
			<div id="cfrmWats"></div>
			
			<div class="layui-inline">
		      <label class="layui-form-label">物资点</label>
		      <div class="layui-input-inline">
		        <select name="material" lay-search="">
		          <option value="">直接选择或搜索选择</option>
		          <option value="1">物资点1</option>
		          <option value="2">物资点2</option>
		          <option value="3">物资点3</option>
		          <option value="4">望京塔物资点</option>
		        </select>
		      </div>
		    </div>
		    
		    <div class="layui-inline">
		      <label class="layui-form-label">水源点</label>
		      <div class="layui-input-inline">
		        <select name="waterSrc" lay-search="">
		          <option value="">直接选择或搜索选择</option>
		          <option value="1">蓄水池1</option>
		          <option value="2">蓄水池2</option>
		          <option value="3">消防栓1</option>
		          <option value="4">消防栓1</option>
		        </select>
		      </div>
		    </div>	
		
			<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="searchPois">查询</button>
			<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="srchPoisByRts">根据路线获取</button>
			
			<div id="matInfoTable"></div>
			<div id="watInfoTable"></div>
		</div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">启用条件（非必填）</h2>
		<div class="layui-colla-content">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">温度</label>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="temp_min" id="temp_min" placeholder="℃"
							autocomplete="off" class="layui-input" lay-verify="temp">
					</div>
					<div class="layui-form-mid">-</div>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="temp_max" id="temp_max" placeholder="℃"
							autocomplete="off" class="layui-input" lay-verify="temp">
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">风力</label>
					<div class="layui-input-inline" style="width: 100px;">
<!-- 						<input type="text" name="winForce_min" id="winForce_min" placeholder="风力级别" -->
<!-- 							autocomplete="off" class="layui-input"> -->
							<select name="winForce_min" id="winForce_min" lay-search="">
					          <option value="">风力级别</option>
					          <option value="0">0级</option>
					          <option value="1">1级</option>
					          <option value="2">2级</option>
					          <option value="3">3级</option>
					          <option value="4">4级</option>
					          <option value="5">5级</option>
					          <option value="6">6级</option>
					          <option value="7">7级</option>
					          <option value="8">8级</option>
					          <option value="9">9级</option>
					          <option value="10">10级</option>
					          <option value="11">11级</option>
					          <option value="12">12级</option>
					          <option value="13">13级</option>
					          <option value="14">14级</option>
					          <option value="15">15级</option>
					          <option value="16">16级</option>
					          <option value="17">17级</option>
					          <option value="18">18级</option>
		        		</select>
					</div>
					<div class="layui-form-mid">-</div>
					<div class="layui-input-inline" style="width: 100px;">
<!-- 						<input type="text" name="winForce_max" id="winForce_max" placeholder="风力级别" -->
<!-- 							autocomplete="off" class="layui-input"> -->
							<select name="winForce_max" id="winForce_max" lay-search="">
					          <option value="">风力级别</option>
					          <option value="0">0级</option>
					          <option value="1">1级</option>
					          <option value="2">2级</option>
					          <option value="3">3级</option>
					          <option value="4">4级</option>
					          <option value="5">5级</option>
					          <option value="6">6级</option>
					          <option value="7">7级</option>
					          <option value="8">8级</option>
					          <option value="9">9级</option>
					          <option value="10">10级</option>
					          <option value="11">11级</option>
					          <option value="12">12级</option>
					          <option value="13">13级</option>
					          <option value="14">14级</option>
					          <option value="15">15级</option>
					          <option value="16">16级</option>
					          <option value="17">17级</option>
					          <option value="18">18级</option>
		        		</select>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">起止时间</label>
					<div class="layui-input-block">
						<input type="text" name="avTime_st" id="avTime_st" autocomplete="off"
							class="layui-input">
					</div>
				</div>
				<div class="layui-inline">					
						<input type="text" name="avTime_ed" id="avTime_ed" autocomplete="off"
							class="layui-input">					
				</div>
			</div>
		</div>
	  </div>     
	</div>
		<br />
		<button style="margin-left:15cm;" class="layui-btn" lay-submit="" lay-filter="demo1">确认修改</button>
    	<button type="reset" class="layui-btn layui-btn-primary">重置</button> 
	</form>
	<br />

 
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	
	var crewIDs = new Array();
	var routes = new Array();
	var cfrmCrNames = new Array();
	var cfrmEndRts = new Array();
	var materials = new Array();
	var waterSource = new Array();
	var primaryRoutes = null;
	var curPlanID = -1;
	
	var rtTbStatus = 0;				//路径表格的状态，0表示目前rtTb目前为空，1表示目前rtTb目前非空，下面两个相同，由于是修改页面，所有的状态设置为1，都有原始值
	var matTbStatus = 1;
	var watTbStatus = 1;
	var curRoute = null;       		//由于路径的特殊性，该字段表示当前正在处理的路线ID，注意是路线，与人员等一一对应
	var curSltCrName = null;		//记录起点下拉框的文本字符串
	var revrBox = false;			//记录反向复选框的值
	
	$(document).ready(function(){
		
		  var planID = parent.sendPlanID();
		  curPlanID = parent.sendPlanID();
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
		       			$("#planName").val(data.planName);
		       			$("#planIntro").val(data.planIntro);
		       			$("#winForce_min").val(data.wdFrcRst[0]);
		       			$("#winForce_max").val(data.wdFrcRst[1]);
		       			$("#temp_min").val(data.tempRst[0]);
		       			$("#temp_max").val(data.tempRst[1]);
		       			$("#avTime_st").val(data.timeRst[0]);
		       			$("#avTime_ed").val(data.timeRst[1]);
			    	    if(data.mats.length > 0){
			       			var matTempStr = ""
				       		for(var i=0; i<data.mats.length; i++){
			       				if(i == data.mats.length-1){
			       					matTempStr = matTempStr + data.mats[i].matID;
			       				} else {
			       					matTempStr = matTempStr + data.mats[i].matID + ",";
			       				}				       								       				
				       		}			       		
				    	    materials.push(matTempStr);
				       		$("#matInfoTable").empty();
							var poiInfo = new Array();
							poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>物资点信息</h3>");
							poiInfo.push("<table class='layui-table'><colgroup><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'><col width='40'></colgroup>"
									  + "<thead><tr><th>物资点ID</th><th>物资点名称</th><th>GPS</th><th>阻燃服</th><th>运兵车</th><th>发电机</th><th>水管</th></tr></thead>"
									  + "<tbody>");
							$.each(data.mats, function(index, mat){
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
						 	console.log("修改前物资点数组");
						 	console.log(materials);
			    	   }
			       	   if(data.watSrc.length > 0){
			       			var watTempStr = ""
			       			for(var i=0; i<data.watSrc.length; i++){
			       				if(i == data.watSrc.length-1){
			       					watTempStr = watTempStr + data.watSrc[i].watSrID;
			       				} else {
			       					watTempStr = watTempStr + data.watSrc[i].watSrID + ",";
			       				}				       								       				
			       			}
			       			waterSource.push(watTempStr);
				       		$("#watInfoTable").empty();
							var poiInfo = new Array();
							poiInfo.push("<hr class='layui-bg-green'><h3 style='font-size: 15px;'><i class='layui-icon' style='font-size: 12px; color: #01814A;'>&#xe602;</i>水源点信息</h3>");
							poiInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
									  + "<thead><tr><th>水源点ID</th><th>水源点名称</th><th>水源类型</th><th>蓄水量</th></tr></thead>"
									  + "<tbody>");
							$.each(data.watSrc, function(index, water){
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
						 	console.log("水源点数组");
						 	console.log(waterSource);							 	
			       	   }
			       	   if(data.segedRoutes.length > 0){
				       		$("#cfrmRtsInfo").empty();
				       		primaryRoutes = data.segedRoutes;
				       		var tempMassRt = data.segedRoutes;
				    		var cfrmInfo = new Array();
				    		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
				    				  + "<thead><tr><th>扑救人员</th><th>终点路径</th><th>经过路段</th><th>操作</th></tr></thead>"
				    				  + "<tbody>");
				    		for(var i=0; i<tempMassRt.length; i++){
				    			var rtStr = "";
				    			for(var j=0; j<tempMassRt[i].length; j++){
				    				if(j == tempMassRt[i].length-1){
				    					rtStr += tempMassRt[i][j].rtID;
				    				} else {
				    					rtStr = rtStr + tempMassRt[i][j].rtID + ",";
				    				}				    				
				    			}
				    			routes.push(rtStr);
				    			crewIDs.push(data.crewInfo[i].crewID);
				    			cfrmCrNames.push(data.crewInfo[i].crewName);
				    			cfrmEndRts.push(data.unposTgRtIDs[i]);				    			
				    			cfrmInfo.push("<tr><td>" + data.crewInfo[i].crewName + "</td>" 
				    					  + "<td>" + data.unposTgRtIDs[i] + "</td>"
				    					  + "<td>" + rtStr + "</td>"
				    					  + "<td><button type='button' class='layui-btn' onclick='rvsRtFromList(" + i + ")'>修改</button>"
				    					  + "<button type='button' class='layui-btn layui-btn-danger' onclick='delRtFromList(" + i + ")'>删除</button></td>"
				    					  + "</tr>");					
				    		}
				    		cfrmInfo.push("</tbody></table>");
				    		$("#cfrmRtsInfo").append(cfrmInfo.join(""));
			       	   }
		       		}
			     }
			  });
	});
	
	//该函数用于路径信息的初始回显，与修改共用了一个函数
	function rvsRtFromList(rtOrder){
		curRoute = rtOrder;
		rvdRtsReq(routes[rtOrder], rtOrder);
		$("#startpt").val(crewIDs[rtOrder]);
		if(cfrmEndRts[rtOrder] < 0){
			$("#endRtID").val(-cfrmEndRts[rtOrder]);
			$("#reverse").prop("checked",true);
			revrBox = true;
		} else {
			$("#endRtID").val(cfrmEndRts[rtOrder]);
			$("#reverse").prop("checked",false);
			revrBox = false;
		}		
		layui.use('form', function(){			//因为layUI的双向绑定问题，在ready()之外的重新赋值需要再次渲染
			  var form = layui.form;
			  form.render('select');
			  form.render('checkbox');
			});
	}
	
	//删除一条路线，级联删除人员ID数组、人员名称数组、终点路径数组
	function delRtFromList(rtOrder){
		routes.splice(rtOrder,1);
		crewIDs.splice(rtOrder,1);
		cfrmCrNames.splice(rtOrder,1);
		cfrmEndRts.splice(rtOrder,1);
		
		console.log("删除：检查各数组数值匹配：");
		console.log(routes);
		console.log(crewIDs);
		console.log(cfrmCrNames);
		console.log(cfrmEndRts);
		
		$("#cfrmRtsInfo").empty();
		var cfrmInfo = new Array();
		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
				  + "<thead><tr><th>扑救人员</th><th>终点路径</th><th>经过路段</th><th>操作</th></tr></thead>"
				  + "<tbody>");
		for(var i=0; i<cfrmEndRts.length; i++){
			cfrmInfo.push("<tr><td>" + cfrmCrNames[i] + "</td>" 
					  + "<td>" + cfrmEndRts[i] + "</td>"
					  + "<td>" + routes[i] + "</td>"
					  + "<td><button type='button' class='layui-btn' onclick='rvsRtFromList(" + i + ")'>修改</button>"
					  + "<button type='button' class='layui-btn layui-btn-danger' onclick='delRtFromList(" + i + ")'>删除</button></td>"
					  + "</tr>");					
		}
		cfrmInfo.push("</tbody></table>");
		$("#cfrmRtsInfo").append(cfrmInfo.join(""));
	}
	
	function confirmRts(){
		console.log("确认-检查各数组数值匹配：");
		console.log(routes);
		console.log(crewIDs);
		console.log(cfrmCrNames);
		console.log(cfrmEndRts);
		console.log("当前操作路线" + curRoute);
		if($("#startpt").val() != ("" + crewIDs[curRoute])){
			$("#startpt").text();
			crewIDs[curRoute] = parseInt($("#startpt").val());
			cfrmCrNames[curRoute] = curSltCrName;			
			console.log("进入人员ID不相等判断" + crewIDs[curRoute]);
		}
		if(cfrmEndRts[curRoute] > 0){
			if($("#endRtID").val() != ("" + cfrmEndRts[curRoute])){
				cfrmEndRts[curRoute] = parseInt($("#endRtID").val());
				//console.log("原终点路径为正值-值不等" + cfrmEndRts[curRoute]);
			}
			if(revrBox == true){
				cfrmEndRts[curRoute] = -parseInt($("#endRtID").val());
				//console.log("原终点路径为正值-符号不等" + cfrmEndRts[curRoute]);
			}
		} else {
			if($("#endRtID").val() != ("" + (-cfrmEndRts[curRoute]))){
				cfrmEndRts[curRoute] = parseInt($("#endRtID").val());
				//console.log("原终点路径为负值-值不等" + cfrmEndRts[curRoute]);
			}
			if(revrBox == false){
				cfrmEndRts[curRoute] = parseInt($("#endRtID").val());
				//console.log("原终点路径为负值-符号不等" + cfrmEndRts[curRoute]);
			}
		}

		$("#cfrmRtsInfo").empty();
		var cfrmInfo = new Array();
		cfrmInfo.push("<table class='layui-table'><colgroup><col width='70'><col width='70'><col width='70'><col width='70'></colgroup>"
				  + "<thead><tr><th>扑救人员</th><th>终点路径</th><th>经过路段</th><th>操作</th></tr></thead>"
				  + "<tbody>");
		for(var i=0; i<cfrmEndRts.length; i++){
			cfrmInfo.push("<tr><td>" + cfrmCrNames[i] + "</td>" 
					  + "<td>" + cfrmEndRts[i] + "</td>"
					  + "<td>" + routes[i] + "</td>"
					  + "<td><button type='button' class='layui-btn' onclick='rvsRtFromList(" + i + ")'>修改</button>"
					  + "<button type='button' class='layui-btn layui-btn-danger' onclick='delRtFromList(" + i + ")'>删除</button></td>"
					  + "</tr>");					
		}
		cfrmInfo.push("</tbody></table>");
		$("#cfrmRtsInfo").append(cfrmInfo.join(""));
		$("#rtsTable").empty();
		rtTbStatus = 0;
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
		matTbStatus = 0;
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
	
	function reviseRts(rtOrder){
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, 
			  layer = layui.layer; //独立版的layer无需执行这一句	  
				 layer.open({
				     id: 'reviseWin' //防止重复弹出
				     ,title: '输入路径'
				     ,content: '<input type="text" name="rvdRts" id="rvdRts" />'
				     ,btn: '确认'
				     ,btnAlign: 'c' //按钮居中
				     ,shade: 0 //不显示遮罩
				     ,yes: function(){
				    	 var routes = $("#rvdRts").val();
				    	 if(!/^(\d+,)*\d+$/.test(routes)){
							 layer.alert("请按照格式输入路径编号，示例：4,2,3");
				    	 } else {
					    	 rvdRtsReq($("#rvdRts").val(), rtOrder);
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
	
	//这个函数本身是服务于修改路线的，现在同样用于原数据的回显，增加入参路线序号，与新建不同的是，新建修改的就是最后的那一条路线，而修改可以修改任意一条路线
	function rvdRtsReq(rvdStr, rtOrder){
		
		routes[rtOrder] = rvdStr;
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
				 	rvdRtInfo.push("<button type='button' id='reviseRoutes' class='layui-btn layui-btn-warm' onclick='reviseRts(" + rtOrder + ")'>修改</button>");
				 	rvdRtInfo.push("<button type='button' class='layui-btn' onclick='confirmRts()'>确定添加</button>");
				 	$("#rtsTable").append(rvdRtInfo.join(""));
				 	rtTbStatus = 1;
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
		  
		  form.on('select(startpt)', function(data){
			  curSltCrName = $(data.elem).find("option:selected").text(); //赋值当前选中的人员名称
			}); 
		  
		  //监听反向复选框
		  form.on('checkbox(reverseBox)', function(data){
			  revrBox = data.elem.checked;				//true或false
			}); 
		
		  //提交整个表单
		  form.on('submit(demo1)', function(data){
		    
			if(materials.join(",").length < 1 || waterSource.join(",").length < 1 || routes.join(",").length < 1){
				layer.alert("预案缺少关键信息，请检查路线、物资点、水源点、人员等是否完成指定！");
			} else if((data.field.winForce_min == "" && data.field.winForce_max != "") || (data.field.winForce_min != "" && data.field.winForce_max == "")){
				layer.alert("请完善风力限制区间！");
			} else if((data.field.temp_min == "" && data.field.temp_max != "") || (data.field.temp_min != "" && data.field.temp_max == "")){
				layer.alert("请完善温度限制区间！");
			} else if((data.field.avTime_st == "" && data.field.avTime_ed != "") || (data.field.avTime_st != "" && data.field.avTime_ed == "")){
				layer.alert("请完善时间限制区间！");
			} else {
			    //整合所有数据拼成Emergency对象
				var req = {"planID":curPlanID, "materials":materials.join(","), "watersource":waterSource.join(","), 
			    		"routes":routes.join(","), "crew":crewIDs.join(","), "targetRtID":cfrmEndRts.join(","), 
			    		"priority":cfrmEndRts.length, "planName":data.field.planName, "planIntro":data.field.planIntro, 
			    		"wdFrcRst":data.field.winForce_min + "," + data.field.winForce_max, 
			    		"tempRst":data.field.temp_min + "," + data.field.temp_max,
			    		"timeRst":data.field.avTime_st + "," + data.field.avTime_ed}
			    		
				$.ajax( {
				     async : false, //这里不开异步，以防点数据赋值混乱
				     cache : false, //是否使用缓存
				     type : 'post', //请求方式,post
				     dataType : "json", //数据传输格式
				     url : "/emrPlan/updatePlan", //请求链接
				     contentType:"application/json",
				     data:JSON.stringify(req),
				     error : function() {
				       alert('网络故障！');
				     },
				     success : function(data) {
				       	 if(data.msg == 1){			       		
				       		layer.alert("更新新预案成功！");
				       	 }				    	 				       
				     }
				});
				var index = parent.layer.getFrameIndex(window.name);
	     	    parent.layer.close(index);
	     	   	parent.refreshPlans();
			}
			
     	    
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
							 	matTbStatus = 1;
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
							 	watTbStatus = 1;
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
	       			crewIDs[curRoute] = parseInt(data.field.startpt);
	       			if(revrBox == true){		//如果反向box选中，则存入复制，反之则正值，默认正值(未选中)
	       				cfrmEndRts[curRoute] = -parseInt(data.field.endRtID);
	       			} else {
	       				cfrmEndRts[curRoute] = parseInt(data.field.endRtID);
	       			}
	       			//cfrmEndRts[curRoute] = parseInt(data.field.endRtID);
	       		} else {				//此时路径表格为空，用户操作为新增一条路线
	       			crewIDs.push(parseInt(data.field.startpt));
	       			if(revrBox == true){
	       				cfrmEndRts.push(-parseInt(data.field.endRtID));
	       			} else {
	       				cfrmEndRts.push(parseInt(data.field.endRtID));
	       			}
					//cfrmEndRts.push(parseInt(data.field.endRtID));
	       		}	       		
	
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
				       			routes[curRoute] = data.passRtsStr;
				       			cfrmCrNames[curRoute] = data.curCrName;
				       		} else {				//此时路径表格为空，用户操作为新增一条路线
								routes.push(data.passRtsStr);
								cfrmCrNames.push(data.curCrName);
								curRoute = routes.length-1;		//当前路线为最后/最新的一条路线
				       		}
// 							routes.push(data.passRtsStr);
// 							cfrmCrNames.push(data.curCrName);
							
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