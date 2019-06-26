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
<title>未处理火情</title>
</head>

<body>

	 
			
			<table class="layui-table"
				lay-data="{url:'chkUnhandledRecs', page:{layout: ['prev', 'page', 'next', 'count', 'skip']}, limit: 10, id:'unHandledRecs'}"
				lay-filter="recsFilter">
				<thead>
					<tr>
<!-- 						<th lay-data="{type:'checkbox', fixed: 'left'}"></th> -->
						<th lay-data="{field:'aRecId', width:100, sort: true}">记录编号</th>
						<th lay-data="{field:'mptName', width:150, sort: true}">监控点名称</th>
						<th lay-data="{field:'mptId', width:150, sort: true}">监控点id</th>
						<th lay-data="{field:'alarmTime', width:180, sort: true}">报警时间</th>
						<th lay-data="{field:'optLongtitude', width:120}">火点纵坐标</th>
						<th lay-data="{field:'optLattitude', width:120}">火点横坐标</th>
<!-- 						<th lay-data="{field:'optHeight', width:120}">火点高度</th> -->
						<th lay-data="{field:'name', width:120}">巡查人员</th>
						<th lay-data="{field:'phone', width:120}">联系方式</th>
						<th lay-data="{width:325, align:'center', toolbar: '#barDemo'}"></th>
					</tr>
				</thead>
			</table>
	 
<!--  		<script type="text/html" id="barDemo">  -->
<!-- 		  <a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-danger layui-btn layui-btn-normal-sm" style="font-size: 15px;" onclick="firePointPosition(689, 584)">定位火点</a> -->
<!-- 		  <a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-sm" style="font-size: 15px;" onclick="searchPlan(1,-1)">规划扑救方案</a>		 -->
<!-- 		</script>  -->
	 		<script type="text/html" id="barDemo"> 
		  		<a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-danger layui-btn layui-btn-normal-sm" style="font-size: 15px;" lay-event="posFP">定位火点</a>
		  		<a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-sm" style="font-size: 15px;" lay-event="showPlan">规划扑救方案</a>
				<a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-normal layui-btn layui-btn-normal-sm" style="font-size: 15px;" lay-event="cancel">解除警报</a>
 			</script>  
    
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
<!-- 		<script type="text/javascript" src="../js/map/map.js"></script>  -->
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>
			
			//跨页调用父页函数,获取方案
			function searchPlan(zmLev, planID){
			    parent.testSegment(zmLev, planID);
			    var index = parent.layer.getFrameIndex(window.name);
			    parent.layer.close(index);
			}
			
			//跨页调用父页函数,火点定位
			function firePointPosition(fpX, fpY){
			    parent.fpPositioning(fpX, fpY);
			    var index = parent.layer.getFrameIndex(window.name);
			    parent.layer.close(index);
			}
		
		
			function toggleComdS(currRec){
				
				$(currRec).attr("class","layui-btn layui-btn-normal layui-btn-xs layui-btn-normal");
				$(currRec).text("停止报警");
				$(currRec).attr("onclick","toggleComdF(this)");
			
				$.ajax( {
					 async : true, //是否异步
					 cache : false, //是否使用缓存
					 type : 'post', //请求方式,post
					 dataType : "json", //数据传输格式
					 url : "<%=request.getContextPath() %>/alrmRec/DistributeInfo", //请求链接 
					 error : function() {
						 alert('网络故障！');
					 },
					 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
						console.log("报警成功");	
					 }
				 });				
			}
		
			function toggleComdF(currRec){
				
				
				
				$(currRec).attr("class","layui-btn layui-btn-danger layui-btn-xs");
				$(currRec).text("发送警报");
				$(currRec).attr("onclick","toggleComdS(this)");
				
				$.ajax( {
					 async : true, //是否异步
					 cache : false, //是否使用缓存
					 type : 'post', //请求方式,post
					 dataType : "json", //数据传输格式
					 url : "<%=request.getContextPath() %>/alrmRec/StopDistribute", //请求链接 
					 error : function() {
						 alert('网络故障！');
					 },
					 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
						console.log("已停止报警");	
					 }
				 });
						
			}
			

			//LayUI table 必需监听
			layui.use('table', function(){
				var table = layui.table;
				//监听工具条
				table.on('tool(recsFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'cancel'){ 	//删除
					    layer.confirm('确认解除该警报吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"aRecId":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "cancelAlrm", //请求链接
							     contentType:"application/json",
							     data:JSON.stringify(req),
							     error : function() {
							       alert('网络故障！');
							     },
							     success : function(data) {
							       	  if(data.msg == 1){
							       		layer.alert("警报已解除");
							       	  }				       		 							       	  						 								       	 
							     }				    	 				       							     
							});
					    });
					  } else if(layEvent === 'posFP'){
						  parent.fpPositioning(parseFloat(td.eq(5).text()), parseFloat(td.eq(4).text()));
						  var index = parent.layer.getFrameIndex(window.name);
						  parent.layer.close(index);
					  } else if(layEvent === 'showPlan'){
						  parent.testSegment(1, -1,td.eq(2).text());
						  var index = parent.layer.getFrameIndex(window.name);
						  parent.layer.close(index);
					  } 					  					 
			  });  
			});
						
</script>   
</body>
</html>