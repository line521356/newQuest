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
<link rel="stylesheet" href="https://js.arcgis.com/4.6/esri/css/main.css">
<style>
  html, body, #viewDiv {
    padding: 0;
    margin: 0;
    height: 100%;
    width: 100%;
  }
</style>
<title>测试使用ArcGIS for js获取地图</title>
</head>

<body>

	<ul class="layui-nav">
		<li class="layui-nav-item"><a href="#" id="getArming" data-method="setTop">正在报警<span
				class="layui-badge">4</span></a></li>
		<li class="layui-nav-item"><a href="#" id="getArming" data-method="setTop">规划路径<span
				class="layui-badge">4</span></a></li>
	</ul>

<!-- 	<div id="viewDiv"></div> -->

    <img alt="" src="/image/test.jpg" align="middle" height="600" width="1200">
	<br />
 	<br />
 	<br />
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script src="https://js.arcgis.com/4.6/"></script>
	<script>
	
		require([
		  "esri/Map",
		  "esri/views/MapView",
		  "dojo/domReady!"
		], function(Map, MapView){
		  var map = new Map({
		    basemap: "streets"
		  });
		  var view = new MapView({
		    container: "viewDiv",  // Reference to the scene div created in step 5
		    map: map,  // Reference to the map object created before the scene
		    zoom: 4,  // Sets zoom level based on level of detail (LOD)
		    center: [15, 65]  // Sets center point of view using longitude,latitude		    
		  });
		});
		
		
	//============================== LayUI 弹出层  ====================================
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
			  
			  //触发事件
			  var active = {
			    setTop: function(){
			      var that = this; 
			      //多窗口模式，层叠置顶
			      layer.open({
			        type: 2 //此处以iframe举例
			        ,title: '正在报警'
			        ,area: ['950px', '500px']
			        ,shade: 0
			        ,maxmin: true
			        ,offset: "auto"
			        ,content: '/alrmRec/UnhandledRecForMap'
			        ,btn: ['关闭'] 
			        ,yes: function(){
			          $(that).click();  //规划路线
			        }
			        ,btn2: function(){
			          layer.closeAll();   //关闭窗口
			        }			        
			        ,zIndex: layer.zIndex //重点1
			        ,success: function(layero){
			          layer.setTop(layero); //重点2
			        }
			      });
			    }			    
			  };
			  
			  $('#getArming').on('click', function(){
			    var othis = $(this), method = othis.data('method');
			    active[method] ? active[method].call(this, othis) : '';
			  });
			  
			});
		
	</script> 
</body>
</html>