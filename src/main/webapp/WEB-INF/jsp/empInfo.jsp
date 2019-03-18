<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录成功</title>
<link rel="stylesheet" type="text/css" href="/css/loginseccess.css">
</head>
<body>

<h1 align="center">用户详细信息：</h1>
<br />


<table align="center">
	<tr>
		<td align="center">当前账号:</td><td>${sessionScope.eosoperator.userId }</td>
	</tr>
	<tr>
		<td align="center">用户名:</td><td>${requestScope.optrWitEmpInfo.operatorName }</td>
	</tr>
	<tr>
		<td align="center">职员学历:</td><td>${requestScope.optrWitEmpInfo.eosorgTEmployee.degree }</td>
	</tr>
	<tr>
		<td align="center">职员电话:</td><td>${requestScope.optrWitEmpInfo.eosorgTEmployee.otel1 }</td>
	</tr>	
	<tr>
		<td align="center">出生年月:</td><td>${requestScope.optrWitEmpInfo.eosorgTEmployee.birthDate }</td>
	</tr>	
	<tr>
		<td align="center">主修专业:</td><td>${requestScope.optrWitEmpInfo.eosorgTEmployee.major }</td>
	</tr>
	<tr>
		<td align="center">兴趣爱好:</td><td>${requestScope.optrWitEmpInfo.eosorgTEmployee.hobby }</td>
	</tr>				
	
</table>




<a href="../loginsuccess">返回</a>
</body>
</html>