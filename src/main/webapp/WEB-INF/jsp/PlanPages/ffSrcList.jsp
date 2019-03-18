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
<title>扑救资源列表</title>
</head>

<body>

	
	<div class="layui-tab layui-tab-card">
  		<ul class="layui-tab-title">
		    <li class="layui-this">物资</li>
		    <li>水源</li>
		    <li>人员</li>
	    </ul>
	    <div class="layui-tab-content">
		    <div class="layui-tab-item layui-show">
				<fieldset class="layui-elem-field">
					<legend>搜索物资</legend>
					<form class="layui-form layui-form-pane" action="">
						<div class="layui-form-item" style="margin-left: 10cm;">
							<div class="layui-inline">
								<label class="layui-form-label">关键词类型</label>
								<div class="layui-input-inline">
									<select name="msrchType" lay-search="" lay-verify="required">
										<option value="">直接选择或搜索选择</option>
										<option value="1">物资点编号</option>
										<option value="2">物资点名称</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 300px;">
									<input type="text" name="mkeyWord" placeholder="请输入关键词"
										autocomplete="off" class="layui-input" lay-verify="required">
								</div>
								<div class="layui-input-inline">
									<button class="layui-btn" lay-submit="" lay-filter="srchMat">搜索</button>
									<button class="layui-btn layui-btn-warm" type="button" onclick="createMat()">新增物资点</button>
								</div>
							</div>
						</div>
					</form>
				</fieldset>
				<fieldset class="layui-elem-field">
					<legend>物资列表</legend>
					<div class="layui-field-box">
						<table class="layui-table" lay-filter="matFilter" id="allMats">
						</table>
					</div>
				</fieldset>				
			</div>
		    <div class="layui-tab-item">
				<fieldset class="layui-elem-field">
					<legend>搜索水源</legend>
					<form class="layui-form layui-form-pane" action="">
						<div class="layui-form-item" style="margin-left: 10cm;">
							<div class="layui-inline">
								<label class="layui-form-label">关键词类型</label>
								<div class="layui-input-inline">
									<select name="wsrchType" lay-search="" lay-verify="required">
										<option value="">直接选择或搜索选择</option>
										<option value="1">水源点编号</option>
										<option value="2">水源点名称</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 300px;">
									<input type="text" name="wkeyWord" placeholder="请输入关键词"
										autocomplete="off" class="layui-input" lay-verify="required">
								</div>
								<div class="layui-input-inline">
									<button class="layui-btn" lay-submit="" lay-filter="srchWat">搜索</button>
									<button type="button" class="layui-btn layui-btn-warm" onclick="createWat()">新增水源点</button>
								</div>
							</div>
						</div>
					</form>
				</fieldset>
				<fieldset class="layui-elem-field">
					<legend>水源列表</legend>
					<div class="layui-field-box">
						<table class="layui-table" lay-filter="watFilter" id="allWats">
						</table>
					</div>
				</fieldset>	
			</div>
		    <div class="layui-tab-item">
				<fieldset class="layui-elem-field">
					<legend>搜索扑救人员</legend>
					<form class="layui-form layui-form-pane" action="">
						<div class="layui-form-item" style="margin-left: 10cm;">
							<div class="layui-inline">
								<label class="layui-form-label">关键词类型</label>
								<div class="layui-input-inline">
									<select name="csrchType" lay-search="" lay-verify="required">
										<option value="">直接选择或搜索选择</option>
										<option value="1">扑救人员编号</option>
										<option value="2">扑救人员名称</option>
									</select>
								</div>
								<div class="layui-input-inline" style="width: 300px;">
									<input type="text" name="ckeyWord" placeholder="请输入关键词"
										autocomplete="off" class="layui-input" lay-verify="required">
								</div>
								<div class="layui-input-inline">
									<button class="layui-btn" lay-submit="" lay-filter="srchCrew">搜索</button>
									<button class="layui-btn layui-btn-warm" type="button" onclick="createCrew()">新增人员</button>
								</div>
							</div>
						</div>
					</form>
				</fieldset>
				<fieldset class="layui-elem-field">
					<legend>扑救人员列表</legend>
					<div class="layui-field-box">
						<table class="layui-table" lay-filter="crewFilter" id="allCrew">
						</table>
					</div>
				</fieldset>	
			</div>
	    </div>
	</div>
	
				
		<script type="text/html" id="toolBar">
		  <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="revise">编辑</a>		  
		  <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
		</script> 
    
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>

			var curTgID = -1;						//要操作的记录ID
						
			function sendTgID(){
				return curTgID;
			}
			
			function refreshMats(){
				layui.use(['table'], function(){
					  var table = layui.table;
					  table.render({
						    elem: '#allMats'
						    ,url: 'allffSrcList' //数据接口
							,where: {listType: 1}
						    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
						    ,limit: 10
						    ,cols: [[ //表头
					       	      {field: 'matID', title: '物资点编号'}
					       	      ,{field: 'matName', title: '物资点名称'}
					       	      ,{field: 'ffSuit', title: '阻燃服', sort: true}
					       	      ,{field: 'gpsDevice', title: 'GPS', sort: true} 
					       	      ,{field: 'transCar', title: '运兵车', sort: true}
					       	   	  ,{field: 'dynamotor', title: '发电机', sort: true}
					       	      ,{field: 'waterPipe', title: '水管', sort: true}
					       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
						    ]]
						  });
				});
			}
			
			function refreshWats(){
				layui.use(['table'], function(){
					  var table = layui.table;
					  table.render({
						    elem: '#allWats'
						    ,url: '/emrPlan/allffSrcList' //数据接口
							,where: {listType: 2}
						    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
						    ,limit: 10
						    ,cols: [[ //表头
					       	      {field: 'watSrID', title: '水源点编号'}
					       	      ,{field: 'watSrName', title: '水源点名称'}
					       	      ,{field: 'watSrType', title: '水源类型', sort: true}
					       	      ,{field: 'watQuantity', title: '蓄水量', sort: true} 
					       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
						    ]]
						  });
				});
			}
			
			function refreshCrew(){
				layui.use(['table'], function(){
					  var table = layui.table;
					  table.render({
						    elem: '#allCrew'
						    ,url: '/emrPlan/allffSrcList' //数据接口
							,where: {listType: 3}
						    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
						    ,limit: 10
						    ,cols: [[ //表头
					       	      {field: 'crewID', title: '人员编号'}
					       	      ,{field: 'crewName', title: '人员/队伍名称', sort: true}
					       	      ,{field: 'headCount', title: '人数', sort: true}
					       	      ,{field: 'crewType', title: '人员/队伍构成', sort: true} 
					       	      ,{field: 'leader', title: '联系人'}
					       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
						    ]]
					});
				});
			}
			
			//新建物资点
			function createMat(){	
			      layer.open({
				        type: 2 //此处以iframe举例
				        ,title: '新建物资点'
				        ,area: ['570px', '570px']
				        ,shade: 0
				        ,maxmin: true
				        ,offset: "auto"
				        ,content: 'toCreateMat'
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
			
			//新建水源点
			function createWat(){	
			      layer.open({
				        type: 2 //此处以iframe举例
				        ,title: '新建水源点'
				        ,area: ['570px', '570px']
				        ,shade: 0
				        ,maxmin: true
				        ,offset: "auto"
				        ,content: 'toCreateWat'
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
			
			function createCrew(){	
			      layer.open({
				        type: 2 //此处以iframe举例
				        ,title: '添加人员'
				        ,area: ['570px', '570px']
				        ,shade: 0
				        ,maxmin: true
				        ,offset: "auto"
				        ,content: 'toCreateCrew'
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
		
			//LayUI table 必需监听
			layui.use(['table','form','element'], function(){
				  var table = layui.table
				  ,form = layui.form
				  ,element = layui.element
				  ,laypage = layui.laypage;  //Tab的切换功能，切换事件监听等，需要依赖element模块
				  				  
				  //第一个实例
				  table.render({
				    elem: '#allMats'
				    ,url: '/emrPlan/allffSrcList' //数据接口
					,where: {listType: 1}
				    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
				    ,limit: 10
				    ,cols: [[ //表头
			       	      {field: 'matID', title: '物资点编号'}
			       	      ,{field: 'matName', title: '物资点名称'}
			       	      ,{field: 'ffSuit', title: '阻燃服', sort: true}
			       	      ,{field: 'gpsDevice', title: 'GPS', sort: true} 
			       	      ,{field: 'transCar', title: '运兵车', sort: true}
			       	   	  ,{field: 'dynamotor', title: '发电机', sort: true}
			       	      ,{field: 'waterPipe', title: '水管', sort: true}
			       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
				    ]]
				  });
				  
				  table.render({
					    elem: '#allWats'
					    ,url: '/emrPlan/allffSrcList' //数据接口
						,where: {listType: 2}
					    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'watSrID', title: '水源点编号'}
				       	      ,{field: 'watSrName', title: '水源点名称'}
				       	      ,{field: 'watSrType', title: '水源类型', sort: true}
				       	      ,{field: 'watQuantity', title: '蓄水量', sort: true} 
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
					    ]]
					  });
				  
				  table.render({
					    elem: '#allCrew'
					    ,url: '/emrPlan/allffSrcList' //数据接口
						,where: {listType: 3}
					    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'crewID', title: '人员编号'}
				       	      ,{field: 'crewName', title: '人员/队伍名称', sort: true}
				       	      ,{field: 'headCount', title: '人数', sort: true}
				       	      ,{field: 'crewType', title: '人员/队伍构成', sort: true} 
				       	      ,{field: 'leader', title: '联系人'}
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
					    ]]
					  });
				  				  				  				  
					//监听工具条
				  table.on('tool(matFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'del'){ 	//删除
					    layer.confirm('确认删除该物资点吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"transCar": 1, "matID":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "/emrPlan/delffSrc", //请求链接
							     contentType:"application/json",
							     data:JSON.stringify(req),
							     error : function() {
							       alert('网络故障！');
							     },
							     success : function(data) {
							       	  if(data.msg == 1){
							       		layer.alert("删除物资点成功");
							       	  }				       		 							       	  						 								       	 
							     }				    	 				       							     
							});
					    });
					  } else if(layEvent === 'revise'){
						  curTgID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '修改物资点信息'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: 'toRvdMat'
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
					
					//监听工具条
				  table.on('tool(watFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'del'){ 	//删除
					    layer.confirm('确认删除该水源点吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"transCar": 2, "matID":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "/emrPlan/delffSrc", //请求链接
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
					    });
					  } else if(layEvent === 'revise'){						
						  curTgID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '修改水源信息'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: 'toRvdWat'
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
					
					//监听工具条
				  table.on('tool(crewFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'del'){ 	//删除
					    layer.confirm('确认删除该人员吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"transCar": 3, "matID":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "/emrPlan/delffSrc", //请求链接
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
					    });
					  } else if(layEvent === 'revise'){
						  curTgID = td.eq(0).text();
					      layer.open({
						        type: 2 //此处以iframe举例
						        ,title: '修改人员信息'
						        ,area: ['570px', '570px']
						        ,shade: 0
						        ,maxmin: true
						        ,offset: "auto"
						        ,content: 'toRvdCrew'
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
				  form.on('submit(srchMat)', function(data){
					table.render({
					    elem: '#allMats'
					    ,url: '/emrPlan/srchSrcs' //数据接口
					    ,where: {kwType: data.field.msrchType, keyWord: data.field.mkeyWord, listType: 1}
					    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'matID', title: '物资点编号'}
				       	      ,{field: 'matName', title: '物资点名称'}
				       	      ,{field: 'ffSuit', title: '阻燃服', sort: true}
				       	      ,{field: 'gpsDevice', title: 'GPS', sort: true} 
				       	      ,{field: 'transCar', title: '运兵车', sort: true}
				       	   	  ,{field: 'dynamotor', title: '发电机', sort: true}
				       	      ,{field: 'waterPipe', title: '水管', sort: true}
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
					    ]]
				    });							       	 
				    return false;
				  });
				  
				  //监听提交
				  form.on('submit(srchWat)', function(data){
					table.render({
					    elem: '#allWats'
					    ,url: '/emrPlan/srchSrcs' //数据接口
					    ,where: {kwType: data.field.wsrchType, keyWord: data.field.wkeyWord, listType: 2}
					    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'watSrID', title: '水源点编号'}
				       	      ,{field: 'watSrName', title: '水源点名称'}
				       	      ,{field: 'watSrType', title: '水源类型', sort: true}
				       	      ,{field: 'watQuantity', title: '蓄水量', sort: true} 
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
					    ]]
				    });							       	 
				    return false;
				  });
				  
				  //监听提交
				  form.on('submit(srchCrew)', function(data){
					table.render({
					    elem: '#allCrew'
					    ,url: '/emrPlan/srchSrcs' //数据接口
					    ,where: {kwType: data.field.csrchType, keyWord: data.field.ckeyWord, listType: 3}
					    ,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
					    ,limit: 10
					    ,cols: [[ //表头
				       	      {field: 'crewID', title: '人员编号'}
				       	      ,{field: 'crewName', title: '人员/队伍名称', sort: true}
				       	      ,{field: 'headCount', title: '人数', sort: true}
				       	      ,{field: 'crewType', title: '人员/队伍构成', sort: true} 
				       	      ,{field: 'leader', title: '联系人'}
				       	      ,{align: 'center', title: '操作', width: 350, toolbar: '#toolBar'}
					    ]]
				    });							       	 
				    return false;
				  });
					
					
			
			});
			
		
</script>   
</body>
</html>