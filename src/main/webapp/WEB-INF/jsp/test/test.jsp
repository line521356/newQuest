<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>推送消息</title>
    <link href="/plugins/video/css/video-js.css" rel="stylesheet"/>
    <script src="/plugins/video/js/video.min.js"></script>
    <script src="/plugins/video/js/videojs-ie8.min.js"></script>
    <link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
    <script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
</head>
<body>
<div>


    <div class="layui-row">
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <div class="layui-col-xs6">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                        <legend>监控点名称，监控点1</legend>
                    </fieldset>
                    <hr class="layui-bg-blue">
                    <video id="rtmpVideo" class="video-js vjs-default-skin vjs-big-play-centered" width="800" height="600">
                        <source src="这里改成你的直播路径" type="rtmp/flv">
                        <p class="vjs-no-js">
                            您的浏览器不支持HTML5，请升级浏览器。
                        </p>
                    </video>
                </div>
            </div>
        </div>
        <div class="layui-col-xs6">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>火情判定</legend>
            </fieldset>
            <hr class="layui-bg-blue">
            <div class="grid-demo">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">火情:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="huoqing" value="小" title="小">
                            <input type="radio" name="huoqing" value="中" title="中">
                            <input type="radio" name="huoqing" value="大" title="大">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">火势:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="huoshi" value="上山火" title="上山火">
                            <input type="radio" name="huoshi" value="下山火" title="下山火">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">移动方向:</label>
                        <div class="layui-input-block">
                            <select name="city" lay-verify="">
                                <option value="">请选择一个方向</option>
                                <option value="010">东</option>
                                <option value="010">南</option>
                                <option value="010">西</option>
                                <option value="010">北</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">移动速度:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="huoshi" value="较慢" title="较慢">
                            <input type="radio" name="huoshi" value="中等" title="中等">
                            <input type="radio" name="huoshi" value="较快" title="较快">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" lay-submit="" lay-filter="demo1">确认</button>
                            <button type="reset" class="layui-btn layui-btn-primary">归入异常报警</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    layui.use('form', function(){
        var form = layui.form;
    });
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
