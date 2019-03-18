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
<script type="text/javascript">
	
	var zTreeObj;
	// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	var setting = {
		check: {
			enable: true,
			chkStyle: "checkbox"
		}
	};
	// zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
	var zNodes = [ {
		name : "parent1",
		open : true,
		children : [ {
			name : "children1"
		}, {
			name : "children2"
		} ]
	}, {
		name : "parent2",
		open : true,
		children : [ {
			name : "children1"
		}, {
			name : "children2"
		} ]
	} ];
	$(document).ready(function() {
		zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
</script>
<title>指派部门</title>
</head>
<body>

<!-- Ztree实验版本V0.1，样式Demo -->

		<br />
	<br />
	<h1 align="center">指派部门</h1>
	<br />
	<br />
	<br />
	<div>
   		<ul id="treeDemo" class="ztree"></ul>
	</div>

	
	
</body>
</html>