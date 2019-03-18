<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/metroStyle/metroStyle.css" type="text/css">
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/ZTree/jquery.ztree.all.js"></script>
<script type="text/javascript" src="/js/json2.js"></script>
<script type="text/javascript">
	
	var zTreeObj = null;
	var currentQuesnrID = ${requestScope.currentQuesnr.ID };
	
	// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	var setting = {
		check: {
			enable: true,
			chkStyle: "checkbox"
		},
		data: {  
                simpleData: {  
                    enable: true  
              }  
        }  
	};
	
	
	function onloadZTree(){
		 var ztreeNodes = null;
		 $.ajax( {
			 async : true, //是否异步
			 cache : false, //是否使用缓存
			 type : 'post', //请求方式,post
			 dataType : "json", //数据传输格式
			 url : "<%=request.getContextPath() %>/assign/getAllOrgs", //请求链接 
			 error : function() {
				 alert('亲，网络有点不给力呀！');
			 },
			 success : function(data) {
 			 	 console.log(data);
				 console.log(currentQuesnrID);
				 ztreeNodes = eval( "["+data+"]" ); //将string类型转换成json对象
				 $.fn.zTree.init($( "#treeDemo"), setting, ztreeNodes);
			 }
		 });
	}
	
	 //初始化操作
	$(document).ready( function(){
		 onloadZTree();
	});
	
	
	//提交已勾选的节点
	function submitChkdNodes(){
	
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getCheckedNodes(true);
				
		var orgObjects = new Array();   //封装属性
		var tableBody = new Array();
		
		$.each(nodes,function(index,that){
			orgObjects.push({id:that.id, name:that.name, check_child_state: that.check_Child_State, quesnrID:currentQuesnrID});
		});
			
			
 		$.ajax( {
			 async : true, //是否异步
			 cache : false, //是否使用缓存
			 type : 'post', //请求方式,post
			 traditional:true,
			 dataType:"json",
			 contentType:"application/json",
			 data:JSON.stringify(orgObjects),
			 url : "<%=request.getContextPath() %>/assign/subChkdNodes", //请求链接 
			 error : function() {
				 alert('亲，网络有点不给力呀！');
			 },
			 success : function(data) {
				 alert('提交成功！');
				 var num = 1;
				 tableBody.push("<h2>已指派部门：</h2><br /><table border='1' cellpadding='10' cellspacing='0'><tr><th width='200px'>序号</th><th width='500px'>部门名称</th><th width='200px'>操作</th></tr></table>");
				 $.each(nodes,function(index,that){
				 	if(that.check_Child_State < 0){
				 		tableBody.push("<table border='1' cellpadding='10' cellspacing='0'><tr><td width='200px'>" + (num++) + "</td>" + "<td width='500px'>" + that.name + "</td><td width='200px'><a href='#'>删除</a></td></tr></table>");
				 	}
				  });
			 	 $("#TableBody").html(tableBody);
			 }
		 });
		
			
			

	}
	
	
	
</script>
<title>指派部门</title>
</head>
<body>

<!-- Ztree正式测试版本V1.0 -->
	<br />
	<br />
	<h1>当前问卷ID at RequestScope :  ${requestScope.currentQuesnr.ID }</h1>
	<h1>当前问卷ID at SessionScope :  ${sessionScope.currentQuesnr.ID }</h1>
	<h1>TestString : ${requestScope.testString }</h1>
	<br />
	<br />
	<h1 align="center">指派部门</h1>
	<br />
	<br />
	<br />
	
	<button onclick="submitChkdNodes()">确定</button>
	<br >
	<br >
	<br >
	
	
	<div id="TableBody">
		<h2>还未指派任何部门！</h2><br />		
<!-- 		<table>	 -->
<!-- 			<tr> -->
<!-- 				<th><input type="checkbox"></th> -->
<!-- 				<th>序号</th> -->
<!-- 				<th>部门名称</th> -->
<!-- 				<th>操作</th> -->
<!-- 			</tr> -->
					
						
			
			
												
<!-- 	    </table> -->
	</div>
	
	
	<div>
   		<ul id="treeDemo" class="ztree"></ul>
	</div>

	<br />
	<br />
	<button id="finishNPrev" align="center">
		<a href="/quesnr/chkNPreview/${requestScope.currentQuesnr.ID }">完成并预览问卷</a>
	</button>
	
</body>
</html>