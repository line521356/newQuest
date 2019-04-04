<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" href="../plugins/layui/css/layui.css" media="all" /> -->
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/css/global.css" media="all">
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/table.css" />
<title>日志列表</title>
</head>

<body>

	<fieldset class="layui-elem-field">
		<legend>搜索日志记录</legend>
		<form class="layui-form layui-form-pane" action="">
			<div class="layui-form-item" style="margin-left:1cm;">
				<div class="layui-inline">
					<label class="layui-form-label">关键词类型</label>
				    <div class="layui-input-inline">
				        <select name="srchType" lay-search="">
				          <option value="">直接选择或搜索选择</option>
				          <option value="1">日志级别</option>
				          <option value="2">用户名</option>
				          <option value="3">日志内容</option>
				          <option value="4">用户编号</option>
				        </select>
				    </div>
					<div class="layui-input-inline" style="width: 300px;">
						<input type="text" name="keyWord" placeholder="请输入关键词"
							autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label">起始时间</label>
				    <div class="layui-input-inline">
				        <input type="text" name="recTime_st" id="recTime_st" autocomplete="off" class="layui-input">
				    </div>
				    <label class="layui-form-label">截止时间</label>
				    <div class="layui-input-inline">
				        <input type="text" name="recTime_ed" id="recTime_ed" autocomplete="off" class="layui-input">
				    </div>					
					<div class="layui-input-inline">
						<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="demo1">搜索</button>
					</div>				
				</div>
			</div>			
		</form>
	</fieldset>
	

	<fieldset class="layui-elem-field">
		<legend>日志列表</legend>
		<div class="layui-field-box">
		<table class="layui-table" lay-filter="logFilter" id="allLogs">				
		</table>
		</div>
	</fieldset>
			
    
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>
			
		
			//LayUI table 必需监听
			layui.use(['table','form', 'laydate'], function(){
				  var table = layui.table
				  ,form = layui.form
				  ,laydate = layui.laydate;
				  
				  
				  //日期与时间选择器
				  laydate.render({
					    elem: '#recTime_st'
					    ,type: 'date'
				  });
				  laydate.render({
					    elem: '#recTime_ed'
					    ,type: 'date'
				  });
				
				  
				  				  
				  //第一个实例
				  table.render({
				    elem: '#allLogs'
				    ,url: 'allLogs' //数据接口
					,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
				    ,limit: 10
				    ,cols: [[ //表头
			       	      {field: 'logID', title: '日志编号'}
			       	      ,{field: 'logDate', title: '记录时间', sort: true}
			       	      ,{field: 'logLev', title: '日志级别', sort: true}
			       	      ,{field: 'logMsg', title: '日志内容', sort: true} 
			       	      ,{field: 'userID', title: '操作用户ID', sort: true}
			       	      ,{field: 'userName', title: '操作用户名', sort: true}
				    ]]
				  });
				  				 					
					
				  //监听提交
				  form.on('submit(demo1)', function(data){
					  if(data.field.srchType == "" &&  data.field.keyWord == "" && data.field.recTime_st == "" && data.field.recTime_ed == ""){
					      layer.open({
					          id: 'infoWin' //防止重复弹出
					          ,content: '请输入搜索条件再进行搜索！'
					          ,btn: '好的'
					          ,btnAlign: 'c' //按钮居中
					          ,yes: function(){
					            layer.closeAll();
					          }
					        });
					  } else if((data.field.srchType == "" &&  data.field.keyWord != "") || (data.field.srchType != "" && data.field.keyWord == "")){
					      layer.open({
					          id: 'infoWin'  //防止重复弹出
					          ,content: '请完整填写搜索关键词！'
					          ,btn: '好的'
					          ,btnAlign: 'c' //按钮居中
					          ,yes: function(){
					            layer.closeAll();
					          }
					        });
					  } else {
// 						    layer.alert(JSON.stringify(data.field), {
// 						        title: '最终的提交信息'
// 						      })
							table.render({
							    elem: '#allLogs'
							    ,url: 'srchLogs' //数据接口
							    ,where: {kwType: data.field.srchType, keyWord: data.field.keyWord, recTime_st: data.field.recTime_st, recTime_ed: data.field.recTime_ed}
								,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
							    ,limit: 10
							    ,cols: [[ //表头
						       	      {field: 'logID', title: '日志编号'}
						       	      ,{field: 'logDate', title: '记录时间', sort: true}
						       	      ,{field: 'logLev', title: '日志级别', sort: true}
						       	      ,{field: 'logMsg', title: '日志内容', sort: true} 
						       	      ,{field: 'userID', title: '操作用户ID', sort: true}
						       	      ,{field: 'userName', title: '操作用户名', sort: true}
							    ]]
						    });	
					  }  
						       	 
				    return false;
				  });
					
					
			
			});
			
		
</script>   
</body>
</html>