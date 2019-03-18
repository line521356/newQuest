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
<title>扑救资源定位</title>
</head>

<body>

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>扑救资源定位</legend>
	</fieldset>
 
	<div style="display: inline-block; margin-left:5px; width: 180px; height: 300px; padding: 10px; border: 1px solid #ddd; overflow: auto;">
	  <ul id="demo1"></ul>
	</div>
 
	<script type="text/javascript" src="/js/jquery-latest.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/js/map/map.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	//Demo
	layui.use(['tree', 'layer'], function(){
	  var layer = layui.layer
	  ,$ = layui.jquery; 
	  
	  layui.tree({
	    elem: '#demo1' //指定元素
	    ,target: '_blank' //是否新选项卡打开（比如节点返回href才有效）
	    ,click: function(item){ //点击节点回调
	      layer.msg('当前节名称：'+ item.name + '<br>全部参数：'+ JSON.stringify(item));
	      console.log(item);
	    }
	    ,nodes: [ //节点
	      {
	        name: '水源点'
	        ,id: 1
	        ,alias: 'changyong'
	        ,children: [
	          {
	            name: '消防栓1'
	            ,id: 11
	            ,href: 'http://www.layui.com/'
	            ,alias: 'weidu'
	          }, {
	            name: '消防栓2'
	            ,id: 12
	          }, {
		         name: '消防栓3'
			     ,id: 12
			  }, {
			     name: '消防栓4'
			     ,id: 12
			  },{
	            name: '水塘1'
	            ,id: 13
	          }, {
		        name: '蓄水池1'
			    ,id: 13
			  }
	          , {
		        name: '蓄水池2'
			    ,id: 13
			  }
	        ]
	      }, {
	        name: '物资点'
		        ,id: 1
		        ,alias: 'changyong'
		        ,children: [
		          {
		            name: '物资点1'
		            ,id: 11
		            ,href: 'http://www.layui.com/'
		            ,alias: 'weidu'
		          }, {
		            name: '物资点2'
		            ,id: 12
		          }, {
		            name: '物资点3'
		            ,id: 13
		          }, {
			        name: '物资点4'
				    ,id: 13
				  }, {
			        name: '物资点5'
				    ,id: 13
				  }, {
				    name: '物资点6'
					,id: 13
				  }, {
					name: '物资点7'
					,id: 13
				}, {
					name: '物资点8'
						,id: 13
				}, {
					name: '物资点9'
					,id: 13
				}, {
					name: '物资点10'
					,id: 13
				}, {
					name: '物资点11'
					,id: 13
				}, {
					name: '物资点12'
					,id: 13
				}, {
					name: '物资点13'
					,id: 13
				}, {
					name: '物资点14'
					,id: 13
				}, {
					name: '物资点15'
					,id: 13
				}, {
					name: '物资点16'
					,id: 13
				}, {
					name: '物资点17'
					,id: 13
				}
		        ]
		      },{
	        name: '消防队驻扎点'
	        ,id: 3
	        ,alias: 'changyong'
	        ,children: [
	          {
	            name: '爱情动作片'
	            ,id: 31
	            ,alias: 'love'
	          }, {
	            name: '技术栈'
	            ,id: 12
	            ,children: [
	              {
	                name: '前端'
	                ,id: 121
	              }
	              ,{
	                name: '全端'
	                ,id: 122
	              }
	            ]
	          }
	        ]
	      }
	    ]
	  });
	  	  
	});
			
						
	</script>   
</body>
</html>