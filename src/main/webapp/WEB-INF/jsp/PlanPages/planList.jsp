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
<title>预案列表</title>
</head>

<body>

	<fieldset class="layui-elem-field">
		<legend>搜索预案</legend>
		<form class="layui-form layui-form-pane" action="">
			<div class="layui-form-item" style="margin-left:10cm;">
				<div class="layui-inline">
					<label class="layui-form-label">关键词类型</label>
				    <div class="layui-input-inline">
				        <select name="srchType" lay-search="" lay-verify="required">
				          <option value="">直接选择或搜索选择</option>
				          <option value="1">预案编号</option>
				          <option value="2">预案名称</option>
				        </select>
				    </div>
					<div class="layui-input-inline" style="width: 300px;">
						<input type="text" name="keyWord" placeholder="请输入关键词"
							autocomplete="off" class="layui-input" lay-verify="required">
					</div>
					<div class="layui-input-inline">
						<button class="layui-btn" lay-submit="" lay-filter="demo1">搜索</button>
					</div>				
				</div>
			</div>			
		</form>
	</fieldset>
	

	<fieldset class="layui-elem-field">
		<legend>预案列表</legend>
		<div class="layui-field-box">
		<table class="layui-table" lay-filter="planFilter" id="allPlans">				
		</table>
		</div>
	</fieldset>
			

		<script type="text/html" id="barDemo">
		  <%--<a class="layui-btn layui-btn-sm" lay-event="chkDet">查看详情</a>--%>
		  <%--<a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="preview">方案预览</a>--%>
		  <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="revise">编辑</a>		  
		  <a class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del">删除</a>
		</script> 
    
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>

			var curPlanID = -1;
			
			function sendPlanID(){
				return curPlanID;
			}
			
			function refreshPlans(){
				layui.use(['table'], function(){
					  var table = layui.table;
					  table.render({
						    elem: '#allPlans'
						    ,url: 'chkAllPlans' //数据接口
							,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
						    ,limit: 10
						    ,cols: [[ //表头
					       	      {field: 'planID', title: '预案编号'}
					       	      ,{field: 'planName', title: '预案名称', sort: true}
					       	      ,{field: 'planIntro', title: '预案介绍'}
					       	      // ,{field: 'arrTime', title: '预计到达时间', sort: true}
					       	      // ,{field: 'rtsLen', title: '路程', sort: true}
					       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#barDemo'}
						    ]]
						  });
				});
			}
		
			//LayUI table 必需监听
			layui.use(['table','form'], function(){
				  var table = layui.table
				  ,form = layui.form;
				  				  
				  //第一个实例
				  table.render({
				    elem: '#allPlans'
				    ,url: 'chkAllPlans' //数据接口
					,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
				    ,limit: 10
				    ,cols: [[ //表头
			       	      {field: 'planID', title: '预案编号'}
			       	      ,{field: 'planName', title: '预案名称', sort: true}
			       	      ,{field: 'planIntro', title: '预案介绍'}
			       	      // ,{field: 'arrTime', title: '预计到达时间', sort: true}
			       	      // ,{field: 'rtsLen', title: '路程', sort: true}
			       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#barDemo'}
				    ]]
				  });
				  
				  
					//监听工具条
				  table.on('tool(planFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'preview'){ 		//查看
						  curPlanID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '预览方案'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: '/map/miniMap'
						        ,btn: ['关闭'] 
						        ,yes: function(){
						          $(that).click();  //规划路线
						        }
						        ,btn2: function(){
						          layer.closeAll();   //关闭窗口
						        }			        
						        ,zIndex: layer.zIndex //重点1
						        ,success: function(layero){
						          layer.setTop(layero); //重点2
						        }
						      });
					  } else if(layEvent === 'del'){ 	//删除
					    layer.confirm('确认删除该预案吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"planID":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "/emrPlan/delPlan", //请求链接
							     contentType:"application/json",
							     data:JSON.stringify(req),
							     error : function() {
							       alert('网络故障！');
							     },
							     success : function(data) {
							       	  if(data.msg == 1){
							       		layer.alert("删除成功");
							       	  }				       		 							       	  						 								       	 
							     }				    	 				       							     
							});
					      //向服务端发送删除指令
					    });
					  } else if(layEvent === 'chkDet'){
						  curPlanID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '当前方案'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: 'detInfoWin'
						        ,btn: ['关闭'] 
						        ,yes: function(){
						          $(that).click();  //规划路线
						        }
						        ,btn2: function(){
						          layer.closeAll();   //关闭窗口
						        }			        
						        ,zIndex: layer.zIndex //重点1
						        ,success: function(layero){
						          layer.setTop(layero); //重点2
						        }
						      });
					  } else if(layEvent === 'revise'){
						  curPlanID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '当前方案'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: 'revInfoWin'
						        ,btn: ['关闭'] 
						        ,yes: function(){
						          $(that).click();  //规划路线
						        }
						        ,btn2: function(){
						          layer.closeAll();   //关闭窗口
						        }			        
						        ,zIndex: layer.zIndex //重点1
						        ,success: function(layero){
						          layer.setTop(layero); //重点2
						        }
						      });
					  } 					  					 
					});
					
					
				  //监听提交
				  form.on('submit(demo1)', function(data){
					table.render({
					    elem: '#allPlans'
					    ,url: '/emrPlan/srchPlan' //数据接口
					    ,where: {kwTyep: data.field.srchType, keyWord: data.field.keyWord}
						,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'planID', title: '预案编号'}
				       	      ,{field: 'planName', title: '预案名称', sort: true}
				       	      ,{field: 'planIntro', title: '预案介绍'}
				       	      // ,{field: 'arrTime', title: '预计到达时间', sort: true}
				       	      // ,{field: 'rtsLen', title: '路程', sort: true}
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#barDemo'}
					    ]]
				    });							       	 
				    return false;
				  });
					
					
			
			});
			
		
</script>   
</body>
</html>