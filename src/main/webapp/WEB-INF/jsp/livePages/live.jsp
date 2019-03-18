<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>直播</title>
    <link href="/plugins/video/css/video-js.css" rel="stylesheet"/>
    <script src="/plugins/video/js/video.min.js"></script>
    <script src="/plugins/video/js/videojs-ie8.min.js"></script>
</head>
<body>
<div id="content">
    <video id="rtmpVideo" class="video-js vjs-default-skin vjs-big-play-centered" width="1366" height="768">
        <source src="rtmp://localhost/live/test" type="rtmp/flv">
        <p class="vjs-no-js">
            您的浏览器不支持HTML5，请升级浏览器。
        </p>
    </video>
</div>
</body>
<script>
    videojs.options.flash.swf = "/plugins/video/video-js.swf";
    // 初始化视频，设为全局变量
    var myPlayer = videojs('rtmpVideo', {
        autoplay: true,
        controls: true,//控制条
        techOrder: ["flash"],
        muted: true,// 静音
        preload: "auto",// 预加载
        language: "zh-CN",// 初始化语言
        playbackRates: [1, 2, 3, 4, 5, 8, 10, 20]// 播放速度
    }, function () {
        console.log("--------------成功初始化视频--------------");
        myPlayer.one("playing", function () {         // 监听播放
            console.log("开始播放");
        });
        myPlayer.one("error", function (error) {      // 监听错误
            console.error("监听到异常，错误信息：%o",error);
        });
    });
</script>
</html>
