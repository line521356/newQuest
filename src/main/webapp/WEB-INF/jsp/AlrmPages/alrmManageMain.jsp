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
<title>问卷管理</title>
</head>

<body>

	 <div class="admin-main">

<!-- 			<blockquote class="layui-elem-quote"> -->
				
<!-- 				<a href="javascript:;" class="layui-btn layui-btn-normal layui-btn layui-btn-normal-small" id="search"> -->
<!-- 					<i class="layui-icon">&#xe615;</i> 搜索 -->
<!-- 				</a> -->
<!-- 			</blockquote> -->
	
			<fieldset class="layui-elem-field">
				<legend>报警记录</legend>
				<div class="layui-field-box">

			<div class="layui-tab">
			  <ul class="layui-tab-title">
			    <li class="layui-this">未处理报警</li>
			    <li>已处理报警</li>
			    <li>异常报警记录</li>
			  </ul>
			  <div class="layui-tab-content">
			    <div class="layui-tab-item layui-show">
			    
						<table class="layui-table" lay-filter="demo" id="unHandledRecs"></table>
					
			    </div>
			    <div class="layui-tab-item">
					<table class="layui-table"
						lay-data="{width: 1200, url:'chkHandledRecs', page:{layout: ['prev', 'page', 'next', 'count', 'skip']}, limit: 10, id:'handledRecs'}"
						lay-filter="demo2">
						<thead>
							<tr>
								<th lay-data="{field:'mptName', sort: true, fixed: true}">监控点名称</th>
								<th lay-data="{field:'alarmTime', sort: true}">报警时间</th>
								<th lay-data="{field:'optLongtitude'}">火点纵坐标</th>
								<th lay-data="{field:'optLattitude'}">火点横坐标</th>
<!-- 								<th lay-data="{field:'optHeight'}">火点高度</th> -->
							</tr>
						</thead>
					</table>
				</div>
			    <div class="layui-tab-item">
			    	<table class="layui-table"
						lay-data="{width: 1200, url:'chkErrRecs', page:{layout: ['prev', 'page', 'next', 'count', 'skip']}, limit: 10, id:'handledRecs'}"
						lay-filter="demo3">
						<thead>
							<tr>
								<th lay-data="{field:'mptName', sort: true, fixed: true}">监控点名称</th>
								<th lay-data="{field:'alarmTime', sort: true}">报警时间</th>
								<th lay-data="{field:'optLongtitude'}">火点纵坐标</th>
								<th lay-data="{field:'optLattitude'}">火点横坐标</th>
<!-- 								<th lay-data="{field:'optHeight'}">火点高度</th> -->
							</tr>
						</thead>
					</table>
			    </div>
			  </div>
			</div>

				
		

				</div>
			</fieldset>
			
		</div>
	 <script type="text/html" id="toolBar">
		 <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="detail">火情判断</a>
	 </script>
<!--  原来有个发送警报，注释在这里方便你整理代码  <a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-sm" onclick="toggleComdS(this)">发送警报</a>  -->
		<script type="text/html" id="barDemo">
		  <a class="layui-btn layui-btn-normal layui-btn layui-btn-normal-danger layui-btn layui-btn-normal-sm">确认火情</a>
		</script> 
    
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>
			
			function toggleComdS(currRec){
				
				$(currRec).attr("class","layui-btn layui-btn-normal layui-btn layui-btn-normal-xs layui-btn layui-btn-normal-normal");
				$(currRec).text("停止报警");
				$(currRec).attr("onclick","toggleComdF(this)");
			
				$.ajax( {
					 async : true, //是否异步
					 cache : false, //是否使用缓存
					 type : 'post', //请求方式,post
					 dataType : "json", //数据传输格式
					 url : "<%=request.getContextPath() %>/alrmRec/DistributeInfo", //请求链接 
					 error : function() {
						 alert('网络故障！');
					 },
					 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
						console.log("报警成功");	
					 }
				 });				
			}
		
			function toggleComdF(currRec){
				
				
				
				$(currRec).attr("class","layui-btn layui-btn-normal layui-btn layui-btn-normal-danger layui-btn layui-btn-normal-xs");
				$(currRec).text("发送警报");
				$(currRec).attr("onclick","toggleComdS(this)");
				
				$.ajax( {
					 async : true, //是否异步
					 cache : false, //是否使用缓存
					 type : 'post', //请求方式,post
					 dataType : "json", //数据传输格式
					 url : "<%=request.getContextPath() %>/alrmRec/StopDistribute", //请求链接 
					 error : function() {
						 alert('网络故障！');
					 },
					 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
						console.log("已停止报警");	
					 }
				 });
						
			}

			//LayUI table 必需监听
			layui.use('table', function(){
				  var table = layui.table;
				  
				  //第一个实例
				  table.render({
				    elem: '#unHandledRecs'
				    ,url: 'chkUnhandledRecs' //数据接口
					,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
				    ,limit: 10
				    ,cols: [[ //表头
                          {field: 'aRecId', title: '告警id'}
                          ,{field: 'mptId', title: '监控点id'}
                          ,{field: 'mptName', title: '监控点名称', sort: true}
                          ,{field: 'alarmTime', title: '报警时间', sort: true}
                          ,{field: 'optLongtitude', title: '火点纵坐标'}
                          ,{field: 'optLattitude', title: '火点横坐标'}
                          ,{field: 'name', title: '巡查人员'}
                          ,{field: 'mptId', title: '火情判定', toolbar: '#toolBar'}
                          ,{field: 'phone', title: '联系方式'}
				    ]]
				  });

                //监听工具条
                table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                    var data = obj.data; 				//获得当前行数据
                    var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr;
                    //获得当前行 tr 的DOM对象
                    var td = tr.find("td");
                    if(layEvent === 'detail'){ 	//查看
                        window.open("/alrmRec/video?id="+td.eq(1).text()+"&aRecId="+td.eq(0).text(),"newwindow","height=1080, width=1920, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
                    }
                });
				  
			});


			
			//LayUI 选项卡 必需监听
			layui.use('element', function(){
				  var $ = layui.jquery
				  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
				  
				  //触发事件
				  var active = {
				    tabAdd: function(){
				      //新增一个Tab项
				      element.tabAdd('demo', {
				        title: '新选项'+ (Math.random()*1000|0) //用于演示
				        ,content: '内容'+ (Math.random()*1000|0)
				        ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
				      })
				    }
				    ,tabDelete: function(othis){
				      //删除指定Tab项
				      element.tabDelete('demo', '44'); //删除：“商品管理”
				      
				      
				      othis.addClass('layui-btn layui-btn-normal-disabled');
				    }
				    ,tabChange: function(){
				      //切换到指定Tab项
				      element.tabChange('demo', '22'); //切换到：用户管理
				    }
				  };
				  
				  $('.site-demo-active').on('click', function(){
				    var othis = $(this), type = othis.data('type');
				    active[type] ? active[type].call(this, othis) : '';
				  });
				  
				  //Hash地址的定位
				  var layid = location.hash.replace(/^#test=/, '');
				  element.tabChange('test', layid);
				  
				  element.on('tab(test)', function(elem){
				    location.hash = 'test='+ $(this).attr('lay-id');
				  });
				  
				});
			
				setInterval(function(){  
					layui.use(['table','form'], function(){
						  var table = layui.table
						  ,form = layui.form;
						  				  
						  //第一个实例
						  table.render({
						    elem: '#unHandledRecs'
						    ,url: 'chkUnhandledRecs' //数据接口
							,page: {layout: ['prev', 'page', 'next', 'count', 'skip']} //开启分页
						    ,limit: 10
						    ,cols: [[ //表头
					       	      {field: 'mptId', title: '监控点id'}
					       	      ,{field: 'mptName', title: '监控点名称', sort: true}
					       	      ,{field: 'alarmTime', title: '报警时间', sort: true}
					       	      ,{field: 'optLongtitude', title: '火点纵坐标'}
					       	      ,{field: 'optLattitude', title: '火点横坐标'} 
					       	      ,{field: 'name', title: '巡查人员'}
					       	      ,{field: 'mptId', title: '火情判定', toolbar: '#toolBar'}
					       	      ,{field: 'phone', title: '联系方式'}
						    ]]
						  });  
					});
		        },5000);
			
</script>   
</body>
</html>