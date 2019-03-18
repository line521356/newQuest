<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 这是测试网页 正式网页看actBoard2.jsp -->
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

<!-- 分页 -->

 

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>将一段已知数组分页展示</legend>
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
		
	    var actNodes = null;
	    var actBoardBody = new Array();
	
		$(document).ready( function(){
		 	onloadActs();
		});
		
		
		function onloadActs(){
			 
			 $.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "/act/getAllActs", //请求链接
				 error : function() {
					 alert('亲，网络有点不给力呀！');
				 },
				 success : function(data) {
	 			 	 console.log(data);
					 actNodes = eval( "["+data+"]" ); //将string类型转换成json对象
					 console.log("transfered to JSON!");
					 //console.log(actNodes[2].actIntro);
					 $.each(actNodes, function(index, actNode){
				 			console.log("arrive loop!");
				 			//console.log(actNode.actName);
				 			actBoardBody.push("<div class='col-md-4'><div class='thumbnail'><img alt='300x200' src='/ActivityPic/" + actNode.actPicUrl + "' />" + "<div class='caption'><h3>" + actNode.actName + "</h3>"
				 					+"<p>" + actNode.actIntro + " Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>"
				 					+"<p><a class='btn btn-primary' href='#'>Action</a> <a class='btn' href='#'>Action</a></p>" + "</div></div></div>");

							console.log("inside the loop:" + index);							
							$("#boardBody").html(actBoardBody); 
						}
			 		 )
			 		$.parser.parse($("#boardBody").parent());
			 		
				 }
			 });
		}
		
		  //----------------------以下为实现分页----------------------------------
		  
		  layui.use(['laypage', 'layer'], function(){
		  var laypage = layui.laypage
		  ,layer = layui.layer;
		  
		  //将一段数组分页展示
		  
		  //测试数据
		
		  var data = new Array();
		  data.push("<h1>test string 1 </h1><input type='radio' />");
		  data.push("<h1>test string 2 </h1><input type='radio' />");
		  data.push("<h1>test string 3 </h1><input type='radio' />");
		
		 
		  var nums = 2; //每页出现的数据量
		  
		  //模拟渲染
		  var render = function(data, curr){
		    var arr = []
		    ,thisData = data.concat().splice(curr*nums-nums, nums);
		    layui.each(thisData, function(index, item){
		      arr.push('<li>'+ item +'</li>');
		    });
		    return arr.join('');
		  };
		  
		  //调用分页
		  laypage({
		    cont: 'demo8'
		    ,pages: Math.ceil(data.length/nums) 
		    ,jump: function(obj){
		      document.getElementById('biuuu_city_list').innerHTML = render(data, obj.curr);
		    }
		  });
		  
		});
	</script>
</body>
</html>