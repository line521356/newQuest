<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<title>设置问卷问题</title>

<style type="text/css">
	table{
		align:center;
		width:590px;
	/* 		float:left; */
		display:block;
	}
	table tr{
 		width:100%
	}
</style>
</head>
<body onLoad="goPage(1,10);">
		
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>第二步：设置问卷问题</legend>
	</fieldset>
		<br>
		<br>
			<h1 align="center">已添加问题</h1>
			
			
	<c:if test="${empty requestScope.tnQuestionnaireItems }">
		还未添加任何问题！
	</c:if>
	<c:if test="${!empty requestScope.tnQuestionnaireItems }">
		<table id="idData" align="center" border="1" cellpadding="10" cellspacing="0">
			<tr >
				<th>问题序号</th>
				<th>问题内容</th>
				<th>操作</th>
			</tr>
			
			<c:forEach items="${requestScope.tnQuestionnaireItems }" var="tnQuestionnaireItem" varStatus="status">
				<tr class="dataInfo">
					<td>${status.index+1 }</td>
					<td>${tnQuestionnaireItem.title }</td>
					<td><a href="">Edit</a> | <a href="">Delete </a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	 <table width="60%" align="right">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
    </table>






	<!-- make 该版本页面实现文本框复制 -->
	<br />
	<br />
	<h1 align="center">设置问卷问题</h1>
	<br />
	<br />
	<br />

	<form method="post" id="updateForm" action="/quesnr/addQuesItem">
		<table cellpadding=0 cellspacing=0 width="100%" class="" align="center">
			
			<tr>
<!-- 				<td>所属问卷：${requestScope.currentQuesnr.theme } </td> -->
				<td><input type="hidden" name="TnNeedsQuestionnaire.ID" value="${requestScope.currentQuesnr.ID }">  
				<br></td>
			</tr>
			
			<tr>
				<th style="width: 200px">问题描述</th>
				<td><input type="text" name="title" class=""
					value="" size="85" />
				</td>
			</tr>
			
			<tr>
				<th style="width: 200px">题目类型</th>
				<td><input type="radio" id="txtEndTime" name="typeId"
					value="1011" size="40" /> 单选 <input type="radio" id="txtEndTime"
					name="typeId" value="1012" size="40" /> 多选 <input type="radio"
					id="txtEndTime" name="typeId" value="1013" size="40" /> 问答</td>
					<!-- 问答的value不知是不是1013 -->
			</tr>

			<tr>
				<th style="width: 200px">是否必填</th>
				<td><input type="radio" name="required" value="1" size="40" />
					是 <input type="radio" name="required" value="0" size="40" /> 否</td>
			</tr>
			
			<tr>
				<th style="width: 200px">是否有其他</th>
				<td><input type="radio" name="hasOtherInput" value="1" size="40" />
					是 <input type="radio" name="hasOtherInput" value="0" size="40" /> 否</td>
			</tr>
			
			<tr id="vote_1">
				<th style="width: 200px">问题选项</th>
				<td><input type="button" id="btnAddOption" class="button" value="添加选项" /> 
				<input type="reset" id="btnResetOption" class="button" value="重置选项" />
				</td>
			</tr>
<!-- 		make 0426	 去掉   name="btnAddOption"   name="btnResetOption"  不提交这俩按钮-->
			<tr id="save">
				<td align="left"><input type="submit" id="btnSave"
					name="btnSave" class="button" style="width:80px" value="提交问题" />
				</td>
			</tr>
		</table>
	</form>
	

	<a href="${pageContext.request.contextPath }/assign/${requestScope.currentQuesnr.ID }">下一步</a>
		
		
	<script type="text/javascript" src="http://www.softwhy.com/mytest/jQuery/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript">
	
		var spotMax = 12;//限定添加text元素的总个数  
		var afterId = 0;//要追加元素的id  
		var newId = 1;//新生成text的id 
	
	
		$(document).ready(function() {
	// 		var spotMax = 12;//限定添加text元素的总个数  
	// 		var afterId = 0;//要追加元素的id  
	// 		var newId = 1;//新生成text的id 
			if ($('table#vote').size() >= spotMax) {
			}
			$("#btnAddOption").click(function() {
				afterId++;
				newId = afterId + 1;
				addSpot(this, spotMax, afterId, newId);
			});
		});
		
		function removeSpot(newId){        //删除这一块只做了简单的处理，即总数-1， 因此为保证正确性只能从最后一个元素删除
			var $choice=$("#vote_"+newId);
			$choice.remove();
			afterId--;
			newId--;		
		}
		
		//添加选项方法  
		function addSpot(obj, sm, afterId, newId) {
			if ($('tr.spot').size() < sm) {
			
			var stringArray=new Array();
			stringArray.push("<tr id='vote_");
			stringArray.push(newId);
			stringArray.push("' class='spot'><th>");
			stringArray.push(afterId);
			stringArray.push("</th><td><input type='text' id='txtInput_'");
			stringArray.push(afterId);
			stringArray.push("' class='input-text' value='' size='40' name='choices[");
			stringArray.push(afterId-1);
			stringArray.push("].choiceContent'/>");   //name 
			stringArray.push("</td>");
			stringArray.push("<td><button onclick='removeSpot(" + newId + ")'>删除</button></td>");
			stringArray.push("</tr>");
			var stringhtml=stringArray.join("");
			console.log(stringhtml);
			
			
				var $newChoice=$(stringhtml).insertAfter($('#vote_' + afterId));
				$newChoice.find("input[type='text']").val("");
				
			} else {
				alert("最多只能添加X个答案！");
			}
		};
		//重置选项  
		$("input#btnResetOption").click(function() {
			$(":text[id^='txtInput_']").val("");//清空文本内容  
		});
	</script>
</body>
</html>