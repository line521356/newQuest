<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <title>推送消息</title>
    <link href="/plugins/video/css/video-js.css" rel="stylesheet"/>
    <script src="/plugins/video/js/video.min.js"></script>
    <script src="/plugins/video/js/videojs-ie8.min.js"></script>
    <link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
    <script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
    <script type="text/javascript" src="/js/jquery-latest.js"></script>
</head>
<body>
<div>


    <div class="layui-row">
        <div class="layui-col-xs6">
            <div class="grid-demo grid-demo-bg1">
                <div class="layui-col-xs6">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                        <legend>监控点名称:${monitorPoint.mptName}</legend>
                    </fieldset>
                    <hr class="layui-bg-blue">
                    <video id="rtmpVideo" class="video-js vjs-default-skin vjs-big-play-centered" width="800" height="600">
                        <source src="${url}" type="rtmp/flv">
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
                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label">火情:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="condition" value="小" title="小">
                            <input type="radio" name="condition" value="中" title="中">
                            <input type="radio" name="condition" value="大" title="大">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">火势:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="intensity" value="上山火" title="上山火">
                            <input type="radio" name="intensity" value="下山火" title="下山火">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">移动方向:</label>
                        <div class="layui-input-block">
                            <select name="direction" lay-verify="">
                                <option value="">请选择一个方向</option>
                                <option value="东">东</option>
                                <option value="南">南</option>
                                <option value="西">西</option>
                                <option value="北">北</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">移动速度:</label>
                        <div class="layui-input-block">
                            <input type="radio" name="speed" value="较慢" title="较慢">
                            <input type="radio" name="speed" value="中等" title="中等">
                            <input type="radio" name="speed" value="较快" title="较快">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">发送人:</label>
                        <div class="layui-input-block">
                           <input name="user" type="text"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button type="button" lay-submit class="layui-btn" lay-filter="submitFrom">确认</button>
                            <button type="button" lay-filter="exceptionAlarm" class="layui-btn layui-btn-primary">归入异常报警</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    layui.use('form', function(){
        var form = layui.form;
        form.on('submit(submitFrom)',function(data){
           var json = {
               condition:data.field.condition,
               intensity:data.field.intensity,
               direction:data.field.direction,
               speed:data.field.speed,
               user:data.field.user
           };

            layer.confirm('确认发送消息吗', {btn: ['确定', '取消'], title: "提示"},function(){

                $.ajax( {
                    async : false, //是否异步
                    cache : false, //是否使用缓存
                    type : 'post', //请求方式,post
                    dataType : "json", //数据传输格式
                    data:JSON.stringify(json),
                    url : "<%=request.getContextPath() %>/alrmRec/sendAlarmMsg", //请求链接
                    error : function() {
                        alert('亲，网络有点不给力呀！');
                    },
                    success : function(data) {
                        alert('已发送');
                    }
                });
            });
        });

        form.on('submit(exceptionAlarm)',function(data){
            layer.confirm('确认归入异常告警吗', {btn: ['确定', '取消'], title: "提示"},function(){
                var aRecId = getQueryString("aRecId")
                $.ajax( {
                    async : false, //是否异步
                    cache : false, //是否使用缓存
                    type : 'get', //请求方式,post
                    url : "<%=request.getContextPath() %>/alrmRec/updateToExceptionAlarm?aRecId="+aRecId, //请求链接
                    error : function() {
                        alert('亲，网络有点不给力呀！');
                    },
                    success : function(data) {
                        alert('已发送');
                    }
                });
            });
        });

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
