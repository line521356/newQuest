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
<style type="text/css">
	visible {visibility:visible}
	invisible {display:none}
</style>
<title>报警状态监控页for Android</title>
</head>

<body>

	 <div id="alarmStatus">
	 	<h1 align="center" id="statusNum" onclick="toggleF()">${requestScope.hasAlarming }</h1>
	 </div>


	 <div class="invisible" id="recDetails">
		<fieldset class="layui-elem-field">
				<legend>未处理报警</legend>
				<div class="layui-field-box">
					
					<c:if test="${empty requestScope.alrminRecs }">
						 无报警记录
					</c:if>
					
					<c:if test="${!empty requestScope.alrminRecs }">
						<table id="idData" class="site-table table-hover" align="center" border="1" cellpadding="10" cellspacing="0">
							<tr>
								<th>序号</th>
								<th>报警地点</th>
								<th>报警时间</th>
								<th>火点经度</th>
								<th>火点纬度</th>
								<th>火点高度</th>
								<th>确认状态 </th>
							</tr>
							<c:forEach items="${requestScope.alrminRecs }" var="alrminRec" varStatus="status">
								<tr class="dataInfo">
									<td>${status.index+1 }</td>
									<td>${alrminRec.mptName }</td>
									<td>${alrminRec.alarmTime }</td>
									<td>${alrminRec.optLattitude }</td>
									<td>${alrminRec.optLongtitude }</td>
									<td>${alrminRec.optHeight }</td>
									<td>${alrminRec.isConfirm }</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</div>
			</fieldset>
   </div>
			
			
	<button id="testJSON" onclick="testJSON()"> test my JSON </button>	
	<div id="jsonData"></div>
	 
	 
 
    
<script type="text/javascript" src="/js/jquery-latest.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
		<script>
			
			
		function testJSON(){
				 $.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "<%=request.getContextPath() %>/alrmRec/almMonitor2", //请求链接 
				 error : function() {
					 alert('亲，网络有点不给力呀！');
				 },
				 success : function(data) {
	 			 	 console.log("！！！！！" + data);
					 console.log(" 是否有报警 " +data.hasAlarming);
					 var alrminRecs = data.alrminRecs;
					 console.log("报警记录" + alrminRecs.length);
					 for(var i=0; i<alrminRecs.length; i++){
						 console.log("记录详情" + alrminRecs[i].alarmTime);
						 console.log("记录详情" + alrminRecs[i].mptName);
					 }
				 }
			 });
		}

		
			function toggleS(){
				$("#statusNum").text("1");
				$("#recDetails").css("display","block");
				//$("#recDetails").attr("class","visible");
				$("#statusNum").attr("onclick","toggleF()");
			}
			
			function toggleF(){
				$("#statusNum").text("0");
				$("#recDetails").css("display","none");
				//$("#recDetails").attr("class","invisible");
				$("#statusNum").attr("onclick","toggleS()");
			}
			
			layui.config({
				base: 'plugins/layui/modules/'
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
				      
				      
				      othis.addClass('layui-btn-disabled');
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
</script>   
</body>
</html>