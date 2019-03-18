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
		<title>方案预览</title>
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

		<!-- 原来height是600 -->
		<canvas id="canvas" width="1510" height="900"></canvas>
<%-- 		<div style="position:fixed; left: 748px;top:360px;" id="tipstest" data-toggle="popover" data-placement="top" data-content='手持GPS：20<br />灭火阻燃服：50<br />简易消防水泵：10<br />发电机：2<br />无线电对讲机：20<br />风力灭火机：10' title="物资点4"></div> --%>
		<script type="text/javascript" src="/js/map/miniMap.js"></script>
		<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		
		$(document).ready(function(){
			  var planID = parent.sendPlanID();
			  if(planID != -1){
				 testSegment(1, planID); 
			  }	else {
				  alert("获取方案编号失败");
			  }		  
		});
	
	
	</script>
	</body>
</html>