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
<title>指派部门</title>

</head>
<body>

<!-- 初级版本，可完成所有部门的层级查询 -->

		<br />
	<br />
	<h1 align="center">指派部门</h1>
	<br />
	<br />
	<br />

<!-- 	<table id="idData" align="center" border="1" cellpadding="10" -->
<!-- 		cellspacing="0"> -->
<!-- 		<tr> -->
<!-- 			<th>上级部门名称</th> -->
<!-- 			<th>部门名称</th> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<td>${organization.parent.orgName }</td> -->
<!-- 			<td>${organization.orgName }</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
	
	<c:if test="${empty requestScope.chilOrgs }">
		该机构没有任何下属部门！
	</c:if>
	<c:if test="${!empty requestScope.chilOrgs }">
		<table id="idData" align="center" border="1" cellpadding="10" cellspacing="0">
			<tr >
				<th>序号</th>
				<th>部门名称</th>
				<th>操作</th>
			</tr>
			
			<c:forEach items="${requestScope.chilOrgs }" var="chilOrgs" varStatus="status">
				<tr class="dataInfo">
					<td>${status.index+1 }</td>
					<td>${chilOrgs.orgName }</td>
					<td><input type="checkbox" name="assignedOrg" value="orgID" />选中   |  <a href="${pageContext.request.contextPath }/assign/getOrgInfo/${chilOrgs.orgId }">查看下属单位</a></td>
					
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	
	
</body>
</html>