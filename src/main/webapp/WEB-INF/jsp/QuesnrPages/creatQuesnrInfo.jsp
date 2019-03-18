<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<title>填写问卷基本信息</title>
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>第一步：填写问卷基本信息</legend>
</fieldset>

<form:form align="center" action="${pageContext.request.contextPath }/quesnr/creatQuesnrInfo" method="POST"  modelAttribute="questionnaire">
		


			<!-- 				<td>调查名称： <form:input id="theme" path="theme"/> -->
			<!-- 				</td>  -->
			<div class="layui-form-item">
				<label class="layui-form-label">调查名称：</label>
				<div class="layui-input-block">
					<input type="text" name="theme" lay-verify="required"
						placeholder="请输入调查名称" autocomplete="off" class="layui-input">
				</div>
			</div>
			
			
			<div class="layui-form-item">
			<!-- 					开始时间： <form:input id="startTime" path="startTime"/> -->
				<label class="layui-form-label">开始时间：</label>
				<div class="layui-input-block">
					<input type="text" name="startTime" id="date" lay-verify="date"
					placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input"
					onclick="layui.laydate({elem: this})">
				</div>
			</div>

			<div class="layui-form-item">
				<!-- 					结束时间：<form:input id="endTime" path="endTime"/>			 -->
				<label class="layui-form-label">结束时间：</label>
				<div class="layui-input-block">
					<input type="text" name="endTime" id="date" lay-verify="date"
						placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input"
						onclick="layui.laydate({elem: this})">
				</div>
			</div>
			
			<div class="layui-form-item">
				<label class="layui-form-label">Email发布问卷：</label>
<!-- 				<input name="sendMail" type="radio" value="1" />是 <input -->
<!-- 				name="sendMail" type="radio" value="2" />否  -->
				<div class="layui-input-block">
						<input type="radio" name="sendMail" value="1" title="是">是
						<input type="radio" name="sendMail" value="2" title="否">否					
				</div>
			</div>
			
			<div class="layui-form-item">	
				<label class="layui-form-label">是否匿名调查：</label>
				<div class="layui-input-block">
						<input type="radio" name="ifAnonymous" value="1" title="是">是
						<input type="radio" name="ifAnonymous" value="2" title="否">否					
				</div>	
<!-- 			是否匿名调查：<input -->
<!-- 				name="ifAnonymous" type="radio" value="1" />是 <input -->
<!-- 				name="ifAnonymous" type="radio" value="2" />否  -->
			
			</div>	
			
			<div class="layui-form-item">
				<label class="layui-form-label">填写说明：</label>
				<div class="layui-input-block">
					<textarea class="layui-textarea layui-hide" name="remark" lay-verify="content" id="LAY_demo_editor"></textarea>
				</div>
<!-- 			填写说明： -->
<!-- 			<form:textarea id="remark" path="remark" rows="5" cols="20" /> -->
			</div>
			
			
			<div class="layui-form-item">
				<div class="layui-input-block">
					<input class="layui-btn" id="smtQsnBscInfo" type="submit" value="下一步" />
<!-- 					<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button> -->
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>		
			
	</form:form>
	
	

	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
		<script>
			layui.use(['form', 'layedit', 'laydate'], function() {
				var form = layui.form(),
					layer = layui.layer,
					layedit = layui.layedit,
					laydate = layui.laydate;

				//创建一个编辑器
				var editIndex = layedit.build('LAY_demo_editor');
				//自定义验证规则
				form.verify({
					title: function(value) {
						if(value.length < 5) {
							return '标题至少得5个字符啊';
						}
					},
					pass: [/(.+){6,12}$/, '密码必须6到12位'],
					content: function(value) {
						layedit.sync(editIndex);
					}
				});

				//监听提交
				form.on('submit(demo1)', function(data) {
					layer.alert(JSON.stringify(data.field), {
						title: '最终的提交信息'
					})
					return false;
				});
			});
		</script>
</body>


</html>