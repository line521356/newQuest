<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<title>创建活动</title>
</head>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>填写活动基本信息</legend>
</fieldset>

<form:form align="center" action="${pageContext.request.contextPath }/act/creatAct" method="POST" enctype="multipart/form-data">
	<table>
		<tr>
			<td>
				<div class="layui-form-item">
					<label class="layui-form-label">活动名称：</label>
					<div class="layui-input-block">
						<input type="text" name="actName" lay-verify="required"
							placeholder="请输入活动名称" autocomplete="off" class="layui-input">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="layui-form-item">
					<label class="layui-form-label">活动简介：</label>
					<div class="layui-input-block">
						<input type="text" name="actIntro" lay-verify="required"
							placeholder="请输入活动简介" autocomplete="off" class="layui-input">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="layui-form-item">
					<label class="layui-form-label">开始时间：</label>
					<div class="layui-input-block">
						<input type="text" name="actSpsDat" id="date" lay-verify="date"
						placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input"
						onclick="layui.laydate({elem: this})">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="layui-form-item">
					<label class="layui-form-label">结束时间：</label>
					<div class="layui-input-block">
						<input type="text" name="actEndDat" id="date" lay-verify="date"
						placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input"
						onclick="layui.laydate({elem: this})">
					</div>
				</div>
			</td>
		</tr>
		<tr>		
			<td>
				<div class="layui-form-item">
				  <label class="layui-form-label">活动封面</label>
				  		
						<input type="file" name="actPic">
					
  				</div>					
			</td>     		
		</tr>
		<tr>
           <td colspan="2"align="center"><input type="submit" value="提交"/></td>
        </tr>
	</table>							
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