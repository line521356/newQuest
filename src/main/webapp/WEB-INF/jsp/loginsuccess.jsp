<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录成功</title>
<link rel="stylesheet" type="text/css" href="/css/loginseccess.css">
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/json2.js"></script>
<script type="text/javascript">
	$(function() {
		$("#send").click(
				function() {
					$.get("/json/getEmpInfo/${sessionScope.eosoperator.operatorId }",
							null, function(data, textStatus) {
								var operatorName = data.operatorName;
								var degree = data.eosorgTEmployee.degree;
								var otel1 = data.eosorgTEmployee.otel1;
								var birthDate = data.eosorgTEmployee.birthDate;
								var major = data.eosorgTEmployee.major;
								var hobby = data.eosorgTEmployee.hobby;
								var txthtml = "<div class='empInfo'><h3 align='center'>"
										+ operatorName + "</h3><br /><h3 align='center'>"
										+ degree + "</h3><br /><h3 align='center'>"
										+ otel1 + "</h3><br /><h3 align='center'>"
										+ birthDate + "</h3><br /><h3 align='center'>"
										+ major + "</h3><br /><h3 align='center'>"
										+ hobby + "</h3><br />";
								$("#resText").html(txthtml);
							}, "json");

				}

		)
	})
</script>
</head>
<body>

	<h1 align="center">欢迎！以下是你的用户信息：</h1>
	<br />


	<table align="center">
		<tr>
			<td align="center">用户名:</td>
			<td>${sessionScope.eosoperator.operatorName }</td>
		</tr>

	</table>


	<a href="getEmpInfo/${sessionScope.eosoperator.operatorId }">
		查看详细个人信息</a>

	<a href="../quesnr/getQuestionnaires"> 查看问卷列表</a>

	<button id="send">AJAX显示用户信息</button>

	<div class="empInfo" align="center">用户信息：</div>
	<div id="resText"></div>






</body>
</html>