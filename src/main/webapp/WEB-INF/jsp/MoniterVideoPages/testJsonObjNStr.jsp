<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 视频模块视频浏览查询主页面 正式网页 单页调试访问地址：/mVid/toVideoBoard -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layui/css/layui.css"  media="all">
<title>问卷管理</title>
</head>

<body>


	<h1>这个页面用来做实验</h1>
	
	<h1>实验1，2测试JSON</h1>
	
	<form action="">
		<input type="radio" />
		<input type='button' value='什么毛病' id='but' onclick="return testJump()">
		
	</form>


	
    
    
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/ZTree/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="/js/json2.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	   
		$(document).ready( function(){
		 	//onloadVideos();
		});
		
		function onloadVideos(){
			
			console.log("1.------测试JSON的各种转换方式----------");
			var jsonFromDB = ${requestScope.testArrayList };
			var jsonStr = '{"p": 5}';
			console.log("直接输出EL表达式中的内容" + jsonFromDB);
			console.log("JSON.stringify" + JSON.stringify(jsonFromDB));
			console.log("JSON.parse" + JSON.parse(jsonStr));
			console.log("eval()" + eval( "["+jsonStr+"]" ));
			
			console.log("2.---------转来转去------------------");
			console.log("直接输出EL表达式中的内容" + jsonFromDB + jsonFromDB[0].mood);
			jsonFromDB = JSON.stringify(jsonFromDB);
			console.log("转成字符串" + jsonFromDB);
			//jsonFromDB = JSON.parse(jsonFromDB);
			jsonFromDB = eval( "["+jsonFromDB+"]" );
			console.log("用parse转JSON对象" + jsonFromDB);
		}
		
		function testJump(){
			console.log("Testing caught!");
			return false;
		}
		
		
	</script>
</body>
</html>