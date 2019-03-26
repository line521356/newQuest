<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- <link rel="stylesheet" href="../plugins/layui/css/layui.css" media="all" /> -->
    <link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="/css/global.css" media="all">
    <link rel="stylesheet" href="/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css/table.css" />
    <!-- <link rel="stylesheet" href="../css/templetPic.css" /> -->
    <style>
        .layui-table-fixed-r td{height:40px!important;}
        .layui-table-fixed-r th{height:40px!important;}
        .layui-table img {
            max-width: 100px;min-height: 100px;
        }

        .laytable-cell-3-scImgUrl ,.laytable-cell-1-scImgUrl,.laytable-cell-2-scImgUrl,.laytable-cell-3-scImgUrl,.laytable-cell-4-scImgUrl,.laytable-cell-5-scImgUrl,.laytable-cell-6-scImgUrl,.laytable-cell-7-scImgUrl,.laytable-cell-8-scImgUrl,.laytable-cell-9-scImgUrl,.laytable-cell-10-scImgUrl,.laytable-cell-11-scImgUrl,.laytable-cell-12-scImgUrl,.laytable-cell-13-scImgUrl,.laytable-cell-14-scImgUrl{
            width: 100px!important;;padding:0px!important;height: 100px!important;;
            line-height: 100px!important;;
        }
    </style>
    <title>监控点列表</title>
</head>

<body>


<fieldset class="layui-elem-field">
    <legend>监控点列表</legend>
    <div class="layui-field-box">
        <table class="layui-table" lay-filter="imgFilter" id="allImgs">
        </table>
    </div>
</fieldset>

<script type="text/javascript" src="/js/jquery-latest.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
<script type="text/html" id="toolBar">
    <a class="layui-btn layui-btn-normal layui-btn-sm" lay-event="detail">查看监控</a>
</script>
<script>



    //LayUI table 必需监听
    layui.use(['table','form', 'laydate'], function(){
        var table = layui.table
            ,form = layui.form
            ,laydate = layui.laydate;


        //日期与时间选择器
        laydate.render({
            elem: '#recTime_st'
            ,type: 'date'
        });
        laydate.render({
            elem: '#recTime_ed'
            ,type: 'date'
        });



        //第一个实例
        table.render({
            elem: '#allImgs'
            ,height: 500
            ,url: '/live/getAllPoint' //数据接口
            ,page: false //开启分页
            ,cols: [[ //表头
                {field: 'mptName', title: '监控点名称'}
                ,{field: 'mptIP', title: '监控点ip'}
                ,{field:'mptIP', title: '查看监控', toolbar: '#toolBar'}
            ]]
        });

        //监听工具条
        table.on('tool(imgFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; 				//获得当前行数据
            var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr;
            //获得当前行 tr 的DOM对象
            var td = tr.find("td");
            if(layEvent === 'detail'){ 	//查看
                window.open("/live/video?ip="+td.eq(1).text());
            }
        });



    });


</script>
</body>
</html>