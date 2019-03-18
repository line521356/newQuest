<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/css/videoPlayer/videoCT.css">
<link rel="stylesheet" href="/css/videoPlayer/enforcedPlayer.css">
<title>视频播放</title>
</head>
<body>

	<br />
	<br />
	<br />
	<div class="container-fluid">
		<div class="row clearfix">
			<div class="col-lg-2 column">
				<blockquote class="layui-elem-quote">
					<h1 style="font-size: 25px; color: #01814A;"><i class="layui-icon" style="font-size: 24px; color: #01814A;">&#xe60a;</i> 视频详情</h1>
					<hr class="layui-bg-green">
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>视频名称:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.vidName }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>监控点3_20170707112213</h3> -->
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>录制起始时间:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.startTime }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>2017-07-07</h3> -->
					<hr class="layui-bg-green">
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>监控点名称:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.mptName }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>监控点2</h3> -->
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>监控点IP:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.mptIP }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>192.168.1.1</h3> -->
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>拍摄经度:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.longtitude }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>116.221145</h3> -->
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>拍摄纬度:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.lattitude }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>40.512438</h3> -->
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>拍摄高度:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.height }</h3>
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>112.35</h3> -->
					<hr class="layui-bg-green">
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>当值人员:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>工号7754</h3>
					<br />
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>联系方式:</h3>
					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>131--------</h3>
					<br />
					<br />
					<br />
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>报警时间:</h3> -->
<%-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.alarmTime }</h3> --%>
<!-- 					<br /> -->
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>确认状态:</h3> -->
<%-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.isConfirm }</h3> --%>
<!-- 					<br /> -->
<!-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>报警状态:</h3> -->
<%-- 					<h3 style="font-size: 15px;"><i class="layui-icon" style="font-size: 12px; color: #01814A;">&#xe602;</i>${requestScope.detInfo.isAlarmed }</h3> --%>
					
				</blockquote>			
			</div>
			<div class="col-lg-9 column">
				<div class="thumbnail">
<!-- 				<div id="videoWin"> -->
					<section>
						<video width="100%" height="100%" id="video1"></video>
					</section>
				</div>
			
			</div>
			<div class="col-lg-1 column">
<!-- 				<fieldset class="layui-elem-field"> -->
<!-- 					<legend>拍摄位置定位</legend> -->
<!-- 					<div class="layui-field-box"> -->
<!-- 					<img src="../../../../image/map2.jpg" width="300px" height="550px" alt="smile" /> -->
<!-- 					</div> -->
<!-- 				</fieldset> -->

			</div>
		</div>
	</div>
	 
	 
	<!--  <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script> -->
	<script type='text/javascript' src="/js/jquery-1.11.1.min.js"></script>
	<script type='text/javascript' src="/plugins/layUI2/layui/layui.js"></script>
    <script type='text/javascript' src="/js/videoPlayer/videoCT.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <!--   <script type='text/javascript' src="../../../js/videoPlayer/enforcedPlayer.js"></script> -->
	<script type="text/javascript">
	
	
//------------使用VLC插件----------------------------------------------
// 		$(document).ready(function(){
				   
// 		   var context = "${pageContext.request.contextPath}";   
//            var restrictedFName = "${requestScope.videoUrl }";	
	
// 		   var videoCont = new Array();
// 		   videoCont.push("<object type='application/x-vlc-plugin' id='vlc' events='True' width='900' height='540' pluginspage='http://www.videolan.org' codebase='http://downloads.videolan.org/pub/videolan/vlc-webplugins/3.0.0/npapi-vlc-3.0.0.tar.xz'>");
// 		   videoCont.push("<param name='mrl' value='" + context + "/EpicWorkVideos/" + restrictedFName + "' /> ");
// 		   videoCont.push("<param name='volume' value='50' /> ");
// 		   videoCont.push("<param name='autoplay' value='true' /> ");
// 		   videoCont.push("<param name='toolbar' value='true' /> ");
// 		   videoCont.push("<param name='loop' value='true' /> ");
// 		   videoCont.push("<param name='fullscreen' value='true' /> ");
// 		   videoCont.push("</object>");
// 		  $("#videoWin").append(videoCont.join(""));
	
// 		});



	
	
	
	
		
		'user strict';
	
		window.onload = function () {
			
			var context = "${pageContext.request.contextPath}";   
			var restrictedFName = "${requestScope.videoUrl }";		//获取视频播放地址
			
	
		    //初始化
		    var video = $('#video1').videoCt({
		        title: '森林防火视频监控管理系统',              //标题
		        volume: 0.2,                //音量
		        barrage: true,              //弹幕开关
		        comment: false,              //弹幕
		        reversal: true,             //镜像翻转
		        playSpeed: true,            //播放速度
		        update: true,               //下载
		        autoplay: false,            //自动播放
		        clarity: {
		            type: ['原画','流畅'],            //清晰度
		            src: [ context + "/EpicWorkVideos/" + restrictedFName,
		            	context + "/EpicWorkVideos/" + restrictedFName]      //链接地址
		        },
		        commentFile: '/datas/videoPlayer/comment.json'           //导入弹幕json数据
		    });
	
		    //扩展
		    video.title;                    //标题
		    video.status;                   //状态
		    video.currentTime;              //当前时长
		    video.duration;                 //总时长
		    video.volume;                   //音量
		    video.clarityType;              //清晰度
		    video.claritySrc;               //链接地址
		    video.fullScreen;               //全屏
		    video.reversal;                 //镜像翻转
		    video.playSpeed;                //播放速度
		    video.cutover;                  //切换下个视频是否自动播放
		    video.commentTitle;             //弹幕标题
		    video.commentId;                //弹幕id
		    video.commentClass;             //弹幕类型
		    video.commentSwitch;            //弹幕是否打开
		    $('#video1').bind('ended', function() {
		        console.log('弹幕json数据：\n'+ video.comment());              //获取弹幕json数据
		    });
		}

	</script>
</body>


</html>