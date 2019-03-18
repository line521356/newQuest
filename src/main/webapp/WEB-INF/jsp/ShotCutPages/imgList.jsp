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
<title>图片管理</title>
</head>

<body>

	<fieldset class="layui-elem-field">
		<legend>搜索图片</legend>
		<form class="layui-form layui-form-pane" action="">
			<div class="layui-form-item" style="margin-left: 1cm;">
				<div class="layui-inline">
					<label class="layui-form-label">关键词类型</label>
					<div class="layui-input-inline">
						<select name="srchType" lay-search="">
							<option value="">直接选择或搜索选择</option>
							<option value="1">监控点ID</option>
							<option value="2">监控点名称</option>
							<option value="3">图片ID</option>
						</select>
					</div>
					<div class="layui-input-inline" style="width: 300px;">
						<input type="text" name="keyWord" placeholder="请输入关键词"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">图片类型</label>
					<div class="layui-input-inline" >
						<select name="imgType" lay-search="">
							<option value="3">全部类型</option>
							<option value="1">手动截图</option>
							<option value="2">报警自动截图</option>
						</select>
					</div>
					<label class="layui-form-label">起始时间</label>
					<div class="layui-input-inline">
						<input type="text" name="recTime_st" id="recTime_st"
							autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label">截止时间</label>
					<div class="layui-input-inline">
						<input type="text" name="recTime_ed" id="recTime_ed"
							autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline">
						<button class="layui-btn" lay-submit="" lay-filter="demo1">搜索</button>
					</div>
				</div>
			</div>
		</form>
	</fieldset>


	<fieldset class="layui-elem-field">
		<legend>图片列表</legend>
		<div class="layui-field-box">
		<table class="layui-table" lay-filter="imgFilter" id="allImgs">				
		</table>
		</div>
	</fieldset>
			
    	<script type="text/html" id="toolBar">
		  <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>
		</script> 
		<script type="text/javascript" src="/js/jquery-latest.js"></script>
		<script type="text/javascript" src="/js/page.js"></script>
		<!-- <script type="text/javascript" src="../plugins/layui/layui.js"></script> -->
		<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
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
				    ,url: 'loadImgList' //数据接口
				    ,page: false //开启分页
				    ,cols: [[ //表头
			       	      {field: 'scImgId', title: '图片编号'}
			       	      ,{field: 'scImgName', title: '图片名称'}
			       	      ,{field: 'createTime', title: '截取时间', sort: true}
			       	      ,{field:'scImgUrl', title: '图片缩略图', style:'height:100px;line-height:100px!important;', templet: '<div><img src="/ActivityPic/{{ d.scImgUrl}}"></div>'}
			       	   	  ,{align: 'center', title: '操作', toolbar: '#toolBar'}
				    ]]
				  });
				  
					//监听工具条
				  table.on('tool(imgFilter)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
					  var data = obj.data; 				//获得当前行数据
					  var layEvent = obj.event; 		//获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
					  var tr = obj.tr; 					//获得当前行 tr 的DOM对象
					  var td = tr.find("td");
					  //alert(td.eq(0).text()); 		 
					  
					  if(layEvent === 'del'){ 	//删除
					    layer.confirm('确认删除该图片吗', function(index){
					      obj.del();     				//删除对应行（tr）的DOM结构，并更新缓存
					      layer.close(index);
					      var req = {"scImgId":td.eq(0).text()};
					      $.ajax( {
							     async : false, //这里不开异步，以防点数据赋值混乱
							     cache : false, //是否使用缓存
							     type : 'post', //请求方式,post
							     dataType : "json", //数据传输格式
							     url : "delImg", //请求链接
							     contentType:"application/json",
							     data:JSON.stringify(req),
							     error : function() {
							       alert('网络故障！');
							     },
							     success : function(data) {
							       	  if(data.msg == 1){
							       		layer.alert("删除图片成功");
							       	  }				       		 							       	  						 								       	 
							     }				    	 				       							     
							});
					    });
					  }					  					 
					});
				  				 					
					
				  //监听提交
				  form.on('submit(demo1)', function(data){
					  if(data.field.srchType == "" &&  data.field.keyWord == "" && data.field.recTime_st == "" && data.field.recTime_ed == "" && data.field.imgType == "3"){
					      layer.open({
					          id: 'infoWin' //防止重复弹出
					          ,content: '请输入搜索条件再进行搜索！'
					          ,btn: '好的'
					          ,btnAlign: 'c' //按钮居中
					          ,yes: function(){
					            layer.closeAll();
					          }
					        });
					  } else if((data.field.srchType == "" &&  data.field.keyWord != "") || (data.field.srchType != "" && data.field.keyWord == "")){
					      layer.open({
					          id: 'infoWin'  //防止重复弹出
					          ,content: '请完整填写搜索关键词！'
					          ,btn: '好的'
					          ,btnAlign: 'c' //按钮居中
					          ,yes: function(){
					            layer.closeAll();
					          }
					        });
					  } else {
							table.render({
							    elem: '#allImgs'
							    ,height: 500
							    ,url: 'srchImgs' //数据接口
							    ,where: {kwType: data.field.srchType, keyWord: data.field.keyWord,imgType: data.field.imgType, recTime_st: data.field.recTime_st, recTime_ed: data.field.recTime_ed}
							    ,page: false //开启分页
							    ,cols: [[ //表头
						       	      {field: 'scImgId', title: '图片编号'}
						       	      ,{field: 'scImgName', title: '图片名称'}
						       	      ,{field: 'createTime', title: '截取时间', sort: true}
						       	      ,{field:'scImgUrl', title: '图片缩略图', style:'height:100px;', templet: '<div><img src="/ActivityPic/{{ d.scImgUrl}}"></div>'}
						       	   	  ,{align: 'center', title: '操作', toolbar: '#toolBar'}
							    ]]
						    });	
					  }  
						       	 
				    return false;
				  });
					
					
			
			});
			
		
</script>   
</body>
</html>