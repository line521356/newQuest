<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 视频模块视频浏览查询主页面 正式网页 单页调试访问地址：/mVid/toVideoBoard -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layui/css/layui.css"  media="all">
<title>问卷管理</title>
</head>

<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div id="boardBody">
	
	
			</div>
		</div>
	</div>
</div>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>视频筛选器</legend>
</fieldset>

<form class="layui-form" action="${pageContext.request.contextPath }/mVid/srchVids" method="post" enctype='application/json'>
	<div class="layui-inline">
      <label class="layui-form-label">起始日期：</label>
      <div class="layui-input-inline">
        <input type="text" name="startDate" id="date1" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">终止日期：</label>
      <div class="layui-input-inline">
        <input type="text" name="endDate" id="date2" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
      </div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
	    </div>
  	</div>
</form>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>将一组监控视频分页展示</legend>
</fieldset>

 
<ul id="biuuu_city_list"></ul>   

<div id="demo8"></div>


<!--  保留完整的bootsrap栅格布局结构
<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="row">
				<div class="col-md-4">
					<div class="thumbnail">
						<img alt="300x200" src="/ActivityPic/${requestScope.currentActivity.actPicUrl }" />
						<div class="caption">
							<h3>
								${requestScope.currentActivity.actName }
							</h3>
							<p>
								${requestScope.currentActivity.actIntro } Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.
							</p>
							<p>
								 <a class="btn btn-primary" href="#">Action</a> <a class="btn" href="#">Action</a>
							</p>
						</div>
					</div>
				</div>
				
				
			</div>
		</div>
	</div>
</div>
-->
	
	
    
    
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/ZTree/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="/js/json2.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	    var vidNodes = null;
	    var videoBoardBody = new Array();
	
		$(document).ready( function(){
		 	onloadVideos();
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
	 			 	 console.log(data);
					 vidNodes = eval( "["+data+"]" ); //将string类型转换成json对象
					 console.log("transfered to JSON!");
					 //console.log(actNodes[2].actIntro);
					 $.each(vidNodes, function(index, vidNode){
				 			console.log("arrive loop!");
				 			//console.log(actNode.actName);
				 			videoBoardBody.push("<div class='col-md-4'><div class='thumbnail'><img alt='300x200' src='/ActivityPic/" + vidNode.mSkchImgUrl + "' />" + "<div class='caption'><h3>" + vidNode.mVidName + "</h3>"
				 					+"<p>Video Generated Date:" + vidNode.mVidGrnTime + " Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>"
				 					+"<p><a class='btn btn-primary' href='view/" + vidNode.mVidUrl + "'>播放</a> <a class='btn' href='#'>Action</a></p>" + "</div></div></div>");

							console.log("inside the loop:" + index);							
						
						}
			 		 )
			 		 
			 		//----------------------以下为实现分页----------------------------------
			 		 
			 		layui.use(['laypage', 'layer'], function(){
			 			  var laypage = layui.laypage
			 			  ,layer = layui.layer;
			 			  
			 			
			 			  var nums = 3; //每页出现的数据量
			 			  
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
			 });
		}
		
		//-------------------------------------搜索栏表单 -----------------------------------
		
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
			    layer.alert(JSON.stringify(data.field), {
			      title: '最终的提交信息'
			    })
			    
			  });
			  
			  
			})  
		  
	</script>
</body>
</html>