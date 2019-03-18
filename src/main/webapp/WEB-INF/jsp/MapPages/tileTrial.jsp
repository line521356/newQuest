<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset='utf-8'>
		<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="/css/global.css" media="all">
		<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="/css/table.css" />
		<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">  
		<title>地图浏览</title>
		<style>
			html,body{
				margin:0px;
				padding:0px;
			}
			canvas{
				border: 1px solid #000;
			}
		</style>
	</head>
	<body>
		<ul class="layui-nav">
			<li class="layui-nav-item"><a href="#" id="getArming" data-method="setTop">正在报警<span
				class="layui-badge">4</span></a></li>
			<li class="layui-nav-item"><a href="#" id="getRoute" data-method="setTop" onclick="getRoute(1,5)">规划路径</a></li>
<!-- 			<li class="layui-nav-item"><a href="#" id="segTest" data-method="setTop" onclick="testSegment(1,-1)">线段测试</a></li> -->
<!-- 			<li class="layui-nav-item"><a href="#" id="getPlan" data-method="setTop" onclick="">获取方案</a></li> -->
<!-- 			<li class="layui-nav-item"><a href="#" id="getSrc" data-method="setTop" onclick="">资源选择列表</a></li>	 -->
<!-- 			<li class="layui-nav-item"><a href="#" id="getSrcLoc" data-method="setTop" onclick="getSrcLoc()">资源位置</a></li>		 -->
		</ul>
		<!-- 原来height是600 -->
		<canvas id="canvas" width="1510" height="900"></canvas>
<%-- 		<div style="position:fixed; left: 748px;top:360px;" id="tipstest" data-toggle="popover" data-placement="top" data-content='手持GPS：20<br />灭火阻燃服：50<br />简易消防水泵：10<br />发电机：2<br />无线电对讲机：20<br />风力灭火机：10' title="物资点4"></div> --%>
		<script type="text/javascript" src="/js/map/tileMap.js"></script>
		<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		$("[data-toggle='popover']").popover(
		        {
		            html: true, // 为true的话，data-content里就能放html代码了
		        }
		     );
			$("[data-toggle='popover']").popover('show');
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
	
	//--------------------------------预案详细信息---------------------------------------------------
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
			  
			  //触发事件
			  var active = {
			    setTop: function(){
			      var that = this; 
			      //多窗口模式，层叠置顶
			      layer.open({
			        type: 2 //此处以iframe举例
			        ,title: '当前方案'
			        ,area: ['500px', '570px']
			        ,shade: 0
			        ,maxmin: true
			        ,offset: "auto"
			        ,content: '/map/planInfo'
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
			  
			  $('#getPlan').on('click', function(){
			    var othis = $(this), method = othis.data('method');
			    active[method] ? active[method].call(this, othis) : '';
			  });
			  
			});		
	//-----------------------------------------------------------------------------------	
	//--------------------------------资源定位---------------------------------------------------
		layui.use('layer', function(){ //独立版的layer无需执行这一句
			  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
			  
			  //触发事件
			  var active = {
			    setTop: function(){
			      var that = this; 
			      //多窗口模式，层叠置顶
			      layer.open({
			        type: 2 //此处以iframe举例
			        ,title: '扑救资源定位'
			        ,area: ['230px', '500px']
			        ,shade: 0
			        ,maxmin: true
			        ,offset: "auto"
			        ,content: '/emrPlan/locateSrc'
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
			  
			  $('#getSrc').on('click', function(){
			    var othis = $(this), method = othis.data('method');
			    active[method] ? active[method].call(this, othis) : '';
			  });
			  
			});		
	
	</script>
	</body>
</html>