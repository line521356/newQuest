<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  

<html>

	<head>
		<meta charset="utf-8">
		<title>森林防火视频监控管理系统</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">

		<link rel="stylesheet" href="/plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="/css/global.css" media="all">
		<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">

	</head>

	<body>
		<div class="layui-layout layui-layout-admin">
			<div class="layui-header header header-demo">
				<div class="layui-main">
					<div class="admin-login-box">
						<a class="logo" style="left: 0;" href="#">
							<span style="font-size: 18px; position:fixed;left:68px;top:21px;">北京林业大学</span>
						</a>
						<div class="admin-side-toggle">
							<i class="fa fa-bars" aria-hidden="true"></i>								
						</div>
					</div>
					<img alt="北京林业大学" src="image/bjfu.jpg" style="position:fixed;left:5px;top:5px;">
					<span style="font-size: 30px;position:fixed;left:300px;top:11px;color:#228B22;">森林防火视频监控管理系统</span>	
					<ul class="layui-nav admin-header-item">
<!-- 						<li class="layui-nav-item"> -->
<!-- 							<a href="javascript:;">清除缓存</a> -->
<!-- 						</li> -->
<!-- 						<li class="layui-nav-item"> -->
<!-- 							<a href="javascript:;">浏览网站</a> -->
<!-- 						</li> -->
<!-- 						<li class="layui-nav-item" id="video1"> -->
<!-- 							<a href="javascript:;">视频</a> -->
<!-- 						</li> -->
						<li class="layui-nav-item">
							<a href="javascript:;" class="admin-header-user">
								<img src="image/1.jpg" />
								<span>${sessionScope.userName }</span>
							</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="#" onclick="showMyInfo()"><i class="fa fa-user-circle" aria-hidden="true"></i> 个人信息</a>
									<!-- 0527 make 还需修改成动态获取用户ID -->
								</dd>
<!-- 								<dd> -->
<!-- 									<a href="javascript:;"><i class="fa fa-gear" aria-hidden="true"></i> 设置</a> -->
<!-- 								</dd> -->
								<dd id="lock">
									<a href="javascript:;">
										<i class="fa fa-lock" aria-hidden="true" style="padding-right: 3px;padding-left: 1px;"></i> 锁屏 (Alt+L)
									</a>
								</dd>
								<dd>
									<a href="user/logOff"><i class="fa fa-sign-out" aria-hidden="true"></i> 注销</a>
								</dd>
							</dl>
						</li>
					</ul>
					<ul class="layui-nav admin-header-item-mobile">
						<li class="layui-nav-item">
							<a href="loginForm"><i class="fa fa-sign-out" aria-hidden="true"></i> 注销</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="layui-side layui-bg-black" id="admin-side">
				<div class="layui-side-scroll" id="admin-navbar-side" lay-filter="side"></div>
			</div>
			<div class="layui-body" style="bottom: 0;border-left: solid 2px #1AA094;" id="admin-body">
				<div class="layui-tab admin-nav-card layui-tab-brief" lay-filter="admin-tab">
					<ul class="layui-tab-title">
						<li class="layui-this">
							<i class="fa fa-dashboard" aria-hidden="true"></i>
							<cite>Welcome</cite>
						</li>
					</ul>
					<div class="layui-tab-content" style="min-height: 150px; padding: 5px 0 0 0;">
						<div class="layui-tab-item layui-show">
							<iframe src="html/main.html"></iframe>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-footer footer footer-demo" id="admin-footer">
				<div class="layui-main">
					<p>2018 &copy;
						<a href="#" target="_blank">北京林业大学</a>  Silent Whale 
					</p>
				</div>
			</div>
			<div class="site-tree-mobile layui-hide">
				<i class="layui-icon">&#xe602;</i>
			</div>
			<div class="site-mobile-shade"></div>
			
			<!--锁屏模板 start-->
			<script type="text/template" id="lock-temp">
				<div class="admin-header-lock" id="lock-box">
					<div class="admin-header-lock-img">
						<img src="image/0.jpg"/>
					</div>
					<div class="admin-header-lock-name" id="lockUserName">beginner</div>
					<input type="text" class="admin-header-lock-input" value="输入密码解锁.." name="lockPwd" id="lockPwd" />
					<button class="layui-btn layui-btn-small" id="unlock">解锁</button>
				</div>
			</script>
			<!--锁屏模板 end -->
			
			<script type="text/javascript" src="/plugins/layui/layui.js"></script>
			<script type="text/javascript" src="/datas/navGnr.js"></script>
			<script src="js/indexGnr.js"></script>
			<script>
			
				var curUserID = ${sessionScope.eosoperatorID };
				
				function sendUserID(){
					return curUserID;
				}
			
				layui.use('layer', function() {
					var $ = layui.jquery,
						layer = layui.layer;

					$('#video1').on('click', function() {
						layer.open({
							title: 'YouTube',
							maxmin: true,
							type: 2,
							content: 'video.html',
							area: ['800px', '500px']
						});
					});

				});
				
				function showMyInfo(){
					layui.use('layer', function() {
						var $ = layui.jquery,
							layer = layui.layer;

				      layer.open({
					        type: 2 //此处以iframe举例
					        ,title: '个人用户信息'
					        ,area: ['570px', '570px']
					        ,shade: 0
					        ,maxmin: true
					        ,offset: "auto"
					        ,content: 'user/revUserWin'
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

					});
				}
				
				//这个函数是为了和修改用户信息公用一个接口不报错，本来是刷新用户列表，在这里实际什么也不做
				function refreshUsers(){
					
				}
				
			</script>
		</div>
	</body>

</html>