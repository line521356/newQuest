<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/css/global.css" media="all">
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/table.css" />
<title>问卷管理</title>
</head>
<style type="text/css">
	table{
		width:1200px;
	/* 		float:left; */
		display:block;
	}
	table tr{
 		width:100%
	}
</style>
<body onLoad="goPage(1,10);">

	<!-- 
	
			0508 测试新的表格样式 
	
	 -->
	 <div class="admin-main">

			<blockquote class="layui-elem-quote">
				<a href="javascript:;" class="layui-btn layui-btn-small" id="add">
					<i class="layui-icon">&#xe608;</i> 添加信息
				</a>
				<a href="#" class="layui-btn layui-btn-small" id="import">
					<i class="layui-icon">&#xe608;</i> 导入信息
				</a>
				<a href="#" class="layui-btn layui-btn-small">
					<i class="fa fa-shopping-cart" aria-hidden="true"></i> 导出信息
				</a>
				<a href="javascript:;" class="layui-btn layui-btn-small" id="search">
					<i class="layui-icon">&#xe615;</i> 搜索
				</a>
			</blockquote>
			<fieldset class="layui-elem-field">
				<legend>问卷列表</legend>
				<div class="layui-field-box">
					<c:if test="${empty requestScope.questionnaires }">
							没有任何用户信息！
					</c:if>
					<c:if test="${!empty requestScope.questionnaires }">
					<table class="site-table table-hover">
						<thead>
							<tr>
								<th><input type="checkbox" id="selected-all"></th>
								<th>调查名称</th>
								<th>调查时间</th>
								<th>Email发布问卷</th>
								<th>匿名调查问卷</th>
								<th>匿名调查地址</th>
								<th>发布状态 </th>
								<th>参加人数</th>
								<th>设置问题与指派</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.questionnaires }" var="questionnaire">
							<tr class="dataInfo">
								<td><input type="checkbox"></td>								 
								<td title='${questionnaire.theme }'>${questionnaire.theme }</td>
								<td>${questionnaire.startTime } -- ${questionnaire.endTime } </td>
								<td>${questionnaire.sendMail }</td>
								<td>${questionnaire.ifAnonymous }</td>
								<td>${questionnaire.publishAddr }</td>
								<td>${questionnaire.pubStatus }</td>
								<td>${questionnaire.finishCount }/${questionnaire.joinCount }</td>
								<td><a href="${questionnaire.ID }" class="layui-btn layui-btn-mini">设置问题</a>
									<a href="/assign/${questionnaire.ID }" data-id="1" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">指派部门</a>
								</td>
								<td>
									<a href="javascript:;" class="layui-btn layui-btn-mini">编辑</a>
									<a href="javascript:;" data-id="1" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
								</td>
							</tr>
						</c:forEach>							
						</tbody>
					
				</table>
			</c:if>

				</div>
			</fieldset>
			<div class="admin-table-page">
				<div id="page" class="page">
				</div>
			</div>
		</div>
	 
	 <!-- 0508 测试新的表格样式  -->
		<br>
		<br>
			<h1 align="center">老版本的可分页的问卷列表，还未完成用LayUI进行分页</h1>
			<h1 align="center">问卷管理</h1>
			
			
	<c:if test="${empty requestScope.questionnaires }">
		没有任何用户信息！
	</c:if>
	<c:if test="${!empty requestScope.questionnaires }">
		<table id="idData" align="center" border="1" cellpadding="10" cellspacing="0">
			<tr >
				<th>调查名称</th>
				<th>调查时间</th>
				<th>Email发布问卷</th>
				<th>匿名调查问卷</th>
				<th>匿名调查地址</th>
				<th>发布状态 </th>
				<th>参加人数</th>
				<th>操作</th>
			</tr>
			
			<c:forEach items="${requestScope.questionnaires }" var="questionnaire">
				<tr class="dataInfo">
					<td title='${questionnaire.theme }'>${questionnaire.theme }</td>
					<td>${questionnaire.startTime } -- ${questionnaire.endTime } </td>
					<td>${questionnaire.sendMail }</td>
					<td>${questionnaire.ifAnonymous }</td>
					<td>${questionnaire.publishAddr }</td>
					<td>${questionnaire.pubStatus }</td>
					<td>${questionnaire.finishCount }/${questionnaire.joinCount }</td>
					<td><a href="">Edit</a> | <a href="">Delete </a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	 <table width="60%" align="right">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
    </table>
    
    <a href="creatQuesnrInfo"> 创建问卷   </a>
    
    
<script type="text/javascript" src="/js/jquery-latest.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<script type="text/javascript" src="/plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: '/plugins/layui/modules/'
			});

			layui.use(['icheck', 'laypage','layer'], function() {
				var $ = layui.jquery,
					laypage = layui.laypage,
					layer = parent.layer === undefined ? layui.layer : parent.layer;
				$('input').iCheck({
					checkboxClass: 'icheckbox_flat-green'
				});

				//page
				laypage({
					cont: 'page',
					pages: 25 //总页数
						,
					groups: 5 //连续显示分页数
						,
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							//layer.msg('第 '+ obj.curr +' 页');
						}
					}
				});

				$('#search').on('click', function() {
					parent.layer.alert('你点击了搜索按钮')
				});

				$('#add').on('click', function() {
					$.get('/temp/edit-form.html', null, function(form) {
						layer.open({
							type: 1,
							title: '添加表单',
							content: form,
							btn: ['保存', '取消'],
							area: ['600px', '400px'],
							maxmin: true,
							yes: function(index) {
								console.log(index);
							},
							full: function(elem) {
								var win = window.top === window.self ? window : parent.window;
								$(win).on('resize', function() {
									var $this = $(this);
									elem.width($this.width()).height($this.height()).css({
										top: 0,
										left: 0
									});
									elem.children('div.layui-layer-content').height($this.height() - 95);
								});
							}
						});
					});
				});

				$('#import').on('click', function() {
					var that = this;
					var index = layer.tips('只想提示地精准些', that,{tips: [1, 'white']});
					$('#layui-layer'+index).children('div.layui-layer-content').css('color','#000000');
				});

				$('.site-table tbody tr').on('click', function(event) {
					var $this = $(this);
					var $input = $this.children('td').eq(0).find('input');
					$input.on('ifChecked', function(e) {
						$this.css('background-color', '#EEEEEE');
					});
					$input.on('ifUnchecked', function(e) {
						$this.removeAttr('style');
					});
					$input.iCheck('toggle');
				}).find('input').each(function() {
					var $this = $(this);
					$this.on('ifChecked', function(e) {
						$this.parents('tr').css('background-color', '#EEEEEE');
					});
					$this.on('ifUnchecked', function(e) {
						$this.parents('tr').removeAttr('style');
					});
				});
				$('#selected-all').on('ifChanged', function(event) {
					var $input = $('.site-table tbody tr td').find('input');
					$input.iCheck(event.currentTarget.checked ? 'check' : 'uncheck');
				});
			});
</script>   
</body>
</html>