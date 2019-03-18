<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset='utf-8'>
		
		<title>临时小工具，获取图片像素坐标并存入数据库</title>
	    <style>
			html,body{
				margin:0px;
				padding:0px;
			}
			canvas{
				border: 1px solid #000;
			}
		</style>
	</head>
	<body>
	<!-- 0级地图宽高 1716 950 -->
	<!-- 1级地图宽高 2177 1224 -->
	<!-- 2级地图宽高 3618 2028 -->
		<canvas id="canvas" width="3618" height="2028"></canvas>
	</body>
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script>
		
		var sptOrdInRt = 2;  //控制按钮3：设置该点在路径中的序号
		var zmLev = 3;  //控制按钮1：设置该点的缩放级数
		var rtID = 37;  //控制按钮2：设置该点的道路ID
	
		$(document).ready(function(){
			canvas=document.getElementById('canvas');
		    context=canvas.getContext('2d');
		    loadImg();
		});
		
		function loadImg(){			
			img=new Image();              //一级地图 分辨率 90 +dp
		    img.onload=function(){
		        imgIsLoaded=true;
		        drawImage(img);
		    }
		    //img.src="../image/tiles/map180_PoiAdded.png";  //2级地图
		    //img.src="../image/tiles/map_LP_PoiAdded.png";
		    img.src="/image/tiles/map300_PoiAdded.png";
		}
		
		
		function drawImage(curImage){
		    context.clearRect(0,0,canvas.width,canvas.height);  //在给定矩形内清空一个矩形：http://www.w3school.com.cn/tags/canvas_clearrect.asp
		    context.drawImage(curImage,0,0);  //http://blog.csdn.net/zhaoruda/article/details/70233455
		    
		}
		
		canvas.onmousedown=function(event){            //监听鼠标点击的点下操作
			var e = event || window.event;
		       var scrollX = document.documentElement.scrollLeft || document.body.scrollLeft;
		       var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
		       var x = e.pageX || e.clientX + scrollX;
		       var y = e.pageY || e.clientY + scrollY;
		       //alert('x: ' + x + '\ny: ' + y);
		       //return { 'x': x, 'y': y };
		    console.log(x + "  " + y);
		    sendLoc(x,y,sptOrdInRt);
		    sptOrdInRt++;
		}
		
		function sendLoc(x,y,sptOrdInRt){  //将获取的坐标值（单个）传给后台
			
			var req = {"pointX":x, "pointY":y, "sptOrdInRt":sptOrdInRt, "zmLev":zmLev, "rtID":rtID};

			$.ajax( {
				 async : false, //这里不开异步，以防点数据赋值混乱
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "sendLoc", //请求链接
				 contentType:"application/json",
				 data:JSON.stringify(req),
				 error : function() {
					 alert('网络故障！');
				 },
				 success : function(data) {
					 if(data.msg == 1){
						 console.log("发送成功");
					 }
				 }
			 });
			
		}

		
	</script>
</html>