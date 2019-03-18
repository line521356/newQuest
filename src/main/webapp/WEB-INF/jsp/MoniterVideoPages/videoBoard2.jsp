<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 视频模块视频浏览查询主页面 
		搜索功能测试版
		批量删除功能测试版
		单页调试访问地址：/mVid/toVideoBoard2 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css"  media="all">
<title>视频管理</title>
</head>

<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>视频筛选器</legend>
</fieldset>


<form class="layui-form layui-form-pane">
	<div class="layui-form-item">
		<div class="layui-inline">
	      <label style="margin-left:2cm" class="layui-form-label">起始日期：</label>
	      <div class="layui-input-inline">
	        <input type="text" name="startDate" id="date1" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
	      </div>
	    </div>
		<div class="layui-inline">
			<label class="layui-form-label">终止日期：</label>
			<div class="layui-input-inline">
				<input type="text" name="endDate" id="date2" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">视频类型</label>
			<div class="layui-input-inline">
				<select name="vidType" lay-search="">
					<option value="">请选择您要搜索的视频类型</option>
					<option value="1">监控视频</option>
					<option value="2">手动录制视频</option>
					<option value="3">报警视频</option>
					<option value="4">所有视频</option>
				</select>
			</div>
		</div>
	</div>
	
	<div style="margin-left:2cm" class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">关键词类型</label>
			<div class="layui-input-inline">
				<select name="mptInfoType" lay-search="">
					<option value="">请选择关键词类型</option>
					<option value="1">监控点ID</option>
					<option value="2">监控点IP</option>
<!-- 					<option value="3">监控点名称</option> -->
<!-- 					<option value="4">视频名称</option> -->
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">搜索关键词</label>
			<div class="layui-input-inline">
				<input type="text" name="mptInfo" autocomplete="off" placeholder="请输入搜索关键词" class="layui-input">
			</div>
		</div>
	</div> 
	  	
    <button style="margin-left:2cm" class="layui-btn" lay-submit="" lay-filter="demo1">搜索</button>
    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	     
</form>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>批量删除</legend>
</fieldset>

 <button class="layui-btn" id="delComd" onclick="toggleComdS()">删除</button>
 

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>监控视频列表</legend>
</fieldset>

 
<ul id="biuuu_city_list"></ul>   

<div id="demo8" class='col-md-12' align="center"></div>



	
	
    
    
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/ZTree/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="/js/json2.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	   
	
		$(document).ready( function(){
			onloadVideos();                //加载所有节点	0727暂时注释，先测试页面效果    
			$(".selBox").hide();
	
		});
		
		
		
		
		function onloadVideos(){
			 
			 $.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "<%=request.getContextPath() %>/mVid/getAllmVids", //请求链接 
				 error : function() {
					 alert('亲，网络有点不给力呀！');
				 },
				 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
					renderNodes(data);		
				 }
			 });
		}
		
		function askSrchResult(keyWords){
			
			console.log("Arrive askSrchResult() !" + keyWords.endDate);
			
			$.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 contentType:"application/json",
				 data:JSON.stringify(keyWords),
				 url : "<%=request.getContextPath() %>/mVid/getKeyWords", //请求链接 
				 error : function() {
					 alert('不好意思，又TM出BUG了');
				 },
				 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
					console.log(data);
					renderNodes(data);		
				 }
			 });
			
		}
		
		//目前renderNodes真是我写的JS函数中，最骄傲最完美的一个
		function renderNodes(targetNodes){
			
			var videoBoardBody = new Array();
			var vidNodes = null;
			
			vidNodes = eval( "["+targetNodes+"]" ); //将string类型转换成json对象
			
			
			 $.each(vidNodes, function(index, vidNode){
		 			videoBoardBody.push("<div class='col-md-4'><div class='thumbnail'><img alt='300x200' src='/ActivityPic/" + vidNode.mSkchImgUrl + "' />" + "<div class='caption'><h3>" + vidNode.mVidName + "</h3>"
		 					+"<p>监控视频录制时间:" + vidNode.mVidGrnTime + "</p>"
		 					+"<p><a class='btn btn-primary' target='_blank' href='view/"+ vidNode.vidId + "/" + vidNode.mVidUrl + "'>播放</a></p>" + "<form class='layui-form selBox'><input type='checkbox' lay-filter='sendDelNodes' lay-skin='primary' title='选中' value='{\"vidType\":" + vidNode.vidType +",\"vidId\":" + vidNode.vidId +"}'></form>" +"</div></div></div>");
				
				}
	 		 )
	 		 
	 		layui.use(['laypage', 'layer'], function(){
	 			  var laypage = layui.laypage
	 			  ,layer = layui.layer;
	 			  
	 			
	 			  var nums = 6; //每页出现的数据量
	 			  
	 			  //模拟渲染
	 			  var render = function(videoBoardBody, curr){
	 			    var arr = []
	 			    ,thisData = videoBoardBody.concat().splice(curr*nums-nums, nums);
	 			    layui.each(thisData, function(index, item){
	 			      arr.push('<li>'+ item +'</li>');
	 			    });
	 			    return arr.join('');
	 			  };
	 			  
	 			  //调用分页
	 			  laypage({
	 			    cont: 'demo8'
	 			    ,pages: Math.ceil(videoBoardBody.length/nums)
	 			    ,skin: '#1E9FFF'
	 			    ,jump: function(obj){
	 			      document.getElementById('biuuu_city_list').innerHTML = render(videoBoardBody, obj.curr);
	 			    }
	 			  });
	 			  
	 			});
		}
		
		
		
		//-------------------------------------搜索栏表单验证 -----------------------------------
		
		layui.use(['form', 'layedit', 'laydate'], function(){
			  var form = layui.form()
			  ,layer = layui.layer
			  ,layedit = layui.layedit
			  ,laydate = layui.laydate;
			  
			  //创建一个编辑器
			  var editIndex = layedit.build('LAY_demo_editor');
			 
			  //自定义验证规则
			  form.verify({
			    title: function(value){
			      if(value.length < 5){
			        return '标题至少得5个字符啊';
			      }
			    }
			    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
			    ,content: function(value){
			      layedit.sync(editIndex);
			    }
			  });
			  
			  //监听指定开关
			  form.on('switch(switchTest)', function(data){
			    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
			      offset: '6px'
			    });
			    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
			  });
			  
			  //监听提交 
			  form.on('submit(demo1)', function(data){								 
			      var nullCount = 0;
				  console.log(data.field.startDate);
				  console.log(data.field);
				  $.each(data.field,function(name,value) {
					  if(value == ""){
						  nullCount++;
					  }					  
				  });
// 				  layer.alert(JSON.stringify(data.field), {
// 			    		title: '最终的提交信息'
// 			    	})
			      if(nullCount > 4){
			    	  layer.confirm('搜索条件为空，请检查', {
			    		  btn: ['好的'] //按钮
			    		});
			      } else if((data.field.mptInfoType != "") && (data.field.mptInfo == "")){
			    	  layer.confirm('请按您输入的关键词类型输入关键词！', {
			    		  btn: ['好的'] //按钮
			    		});
			      } else {
			    	  askSrchResult(data.field)
			      }
			    
			    return false; //false表示使用AJAX提交，否则会跳转
			  });
			  
			  
			})
			
	//-----------------------删除模块---------------------------------------------
		function toggleComdS(){
			$("#delComd").attr("class","layui-btn layui-btn-warm");
			$("#delComd").text("完成");
			$("#delComd").attr("onclick","toggleComdF()");
			$("#delComd").after("<button class='layui-btn layui-btn-danger' id='delNow' onclick='smtDelNodes()'>删除</button>");
			$(".selBox").show();
			
			layui.use(['form'], function(){
				  var form = layui.form();
				  form.render('checkbox');	
				  
				  form.on('checkbox(sendDelNodes)', function(data){					  
					  console.log("checked" + data.elem.checked); //是否被选中，true或者false
					  console.log("value" + data.value); //复选框value值，也可以通过data.elem.value得到					 
					}); 				  
				})
//---------------------------------				
		}
		
		function toggleComdF(){
			$("#delComd").attr("class","layui-btn");
			$("#delComd").text("编辑");
			$("#delComd").attr("onclick","toggleComdS()");
			$("#delNow").remove();
			$(".selBox").hide();
		}
		
		function smtDelNodes(){
			
			var delNodes = new Array();
		
			$("input[type=checkbox]").each(function(){
				 if($(this).prop("checked") == true){
					 delNodes.push($(this).val());
				 } 				 
				});
			
			
			var toJsonDNodes = eval( "["+delNodes+"]" );
			var UltNodes = new Array();
		
			$.each(toJsonDNodes,function(index,that){
				UltNodes.push({vidType:that.vidType, vidId:that.vidId});
				console.log(UltNodes[index]);
			});
			
		
			$.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : "post", //请求方式,post
				 traditional:true,
				 dataType:"json",
				 contentType:"application/json",
				 data:JSON.stringify(UltNodes),
				 url : "<%=request.getContextPath() %>/mVid/delVids", //请求链接 
				 error : function() {
					 alert('No it dosent work.');
				 },
				 success : function(data) {
					 alert("提交成功！正在更新数据...");
					 location.href = "toVideoBoard2";
				 }
			 });
			
		}
			
		  
	</script>
</body>
</html>