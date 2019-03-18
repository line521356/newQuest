<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>用户登录</title>


<!-- 引入 Bootstrap -->
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
<link rel="stylesheet" type="text/css" href="/css/jumbotron.css">

</head>
<body style="background-image:url(../image/loginBg.jpg);">

	<br />
	<br />
	<br />
	<br />
	<!-- 使用Bootstrap 2017.04.24 make -->

	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column" id="panel">
				<div class="jumbotron">
					<h1>森林防火视频监控管理系统</h1>
					<p>森林防火视频监控管理系统为您提供视频与图片等火情影像资源管理、报警响应、监控数据统计与分析、扑救路径规划等功能。森林火灾是森林最危险的敌人，也是林业最可怕的灾害，它会给森林带来最有害，最具有毁灭性的后果。森林火灾不但烧毁成片的森林，伤害林内的动物，而且还降低森林的繁殖能力，引起土壤的贫瘠并破坏森林涵养水源，甚至会导致生态环境失去平衡。尽管当今世界的科学在日新月异地向前发展，但是，人类在制服森林火灾上，却依然尚未取得长久的进展。
					</p>
					<p>系统版本： V1.0</p>		
				</div>
				<div id="loginForm">
					<form role="form" action="/user/login" method="post">
						<div class="form-group">
							<label for="exampleInputText1"><p style="color:#FFFFFF;">用户名</p></label><input type="text"
								class="form-control" id="exampleInputText1" name="gnrUserName" />
						</div>
						<div class="form-group">
							<label for="exampleInputPassword1"><p style="color:#FFFFFF;">密码</p></label><input
								type="password" class="form-control" id="exampleInputPassword1" name="gnrUserPwd" />
						</div>
<!-- 						<div class="checkbox"> -->
<!-- 							<label><input type="checkbox" /><p style="color:#FFFFFF;">记住用户信息</p></label> -->
<!-- 						</div> -->
						<font color="red">${requestScope.message }</font>
						<br />
						<button type="submit" class="btn btn-lg btn-primary">登录</button>
						<button type="button" class="btn btn-lg btn-default" style="margin-left:0.5cm;" onclick="signUp()">注册</button>
					</form>	
				</div>			
			</div>
		</div>
	</div>

	<!-- 使用Bootstrap  2017.04.24 make -->
		
	<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<!-- 包括所有已编译的插件 -->
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
		//用户注册窗口
		function signUp(){
			layui.use('layer', function(){ //独立版的layer无需执行这一句
				  var $ = layui.jquery
				  , layer = layui.layer; //独立版的layer无需执行这一句  
			
			layer.open({
			        type: 2 //此处以iframe举例
			        ,title: '新用户注册'
			        ,area: ['570px', '600px']
			        ,shade: 0
			        ,maxmin: true
			        ,offset: "auto"
			        ,content: 'signUp'
			        ,btn2: function(){
			          layer.closeAll();   //关闭窗口
			        }			        
			        ,zIndex: layer.zIndex //重点1
			        ,success: function(layero){
			          layer.setTop(layero); //重点2
			        }
			      });
			});
		}
	</script>
</body>
</html>