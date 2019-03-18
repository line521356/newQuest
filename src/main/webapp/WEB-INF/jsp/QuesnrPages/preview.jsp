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
<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<title>预览问卷</title>

</head>
<body>
	<br />
	<br />
	<h1 align="center">预览问卷</h1>
	<br />
	<br />
	<br />

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>第一部分：问卷基本信息</legend>

		<table id="idData" align="center" border="1" cellpadding="10"
			cellspacing="0">
			<tr>
				<th>问卷名称</th>
				<th>起始时间</th>
				<th>结束时间</th>
				<th>注意事项</th>
			</tr>
	
			<tr>
				<td>${quesnrBasicInfo.theme }</td>
				<td>${quesnrBasicInfo.startTime }</td>
				<td>${quesnrBasicInfo.endTime }</td>
				<td>${quesnrBasicInfo.remark }</td>
			</tr>
		</table>		
	</fieldset>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>第二部分：问卷指派部门</legend>

		<table id="idData" align="center" border="1" cellpadding="10"
			cellspacing="0">
			<tr>
				<th>序号</th>
				<th>部门名称</th>
			</tr>
			
			<c:forEach items="${requestScope.assndDepts }" var="assndDept" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${assndDept.dept.orgName }</td>
			</tr>
			</c:forEach>
		</table>		
	</fieldset>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>第三部分：问卷问题预览</legend>
		
		<table align="center" cellpadding="10">
		
			<c:forEach items="${requestScope.quesnrQues }" var="question">
				<tr>
					<td>${question.title }</td>
				</tr>
					<c:if test="${question.typeId  == 1011}">																			
						<c:forEach items="${question.choices }" var="choice">
							<tr>
								<c:choose>
									<c:when test="${choice.allowOtherInput  > 0}">
										
										<td><input type="radio" class="otherChoice" />
											<h5 class="otherContent">${choice.choiceCode }. ${choice.choiceContent }</h5>
										</td>
									</c:when>
									<c:otherwise>
										
										<td><input type="radio" />${choice.choiceCode }. ${choice.choiceContent }</td>
									</c:otherwise>
								</c:choose>								
							</tr>
						</c:forEach>						
					</c:if>
					<c:if test="${question.typeId == 1012}">																			
						<c:forEach items="${question.choices }" var="choice">
							<tr>
								<c:choose>
									<c:when test="${choice.allowOtherInput > 0}">									
										<td>
											<input type="checkbox" class="otherChoice" />
											<h5 class="otherContent">${choice.choiceCode }. ${choice.choiceContent }</h5>
										</td>
									</c:when>
									<c:otherwise>
										
										<td><input type="checkbox" />${choice.choiceCode }. ${choice.choiceContent }</td>
									</c:otherwise>
								</c:choose>								
							</tr>
						</c:forEach>						
					</c:if>
					<c:if test="${question.typeId == 1013}">																			
						<tr>
							<td><textarea cols="80" rows="20"></textarea></td>
						</tr>					
					</c:if>
			</c:forEach>
			
		</table>
		
		
		
		
	</fieldset>
	
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
				var $otherInput = $(".otherChoice");
				$otherInput.click(function(){
					if($otherInput.is(":checked")){
						$(".otherContent").append("<input type='text' />");
// 						$otherInput.after("<h3>!!!!!!!!!!!</h3>");
						alert("Arrive!");
					}
				});				
			}
		);
		
	</script>
</body>
</html>