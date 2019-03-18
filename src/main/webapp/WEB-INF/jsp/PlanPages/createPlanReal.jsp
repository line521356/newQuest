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
<title>创建扑火预案</title>
</head>

<body>

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>创建扑火预案</legend>
	</fieldset>


	<form class="layui-form" action="">
	<div class="layui-collapse" lay-filter="test">
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">方案名称与扑火方式</h2>
	    <div class="layui-colla-content">

	       <div class="layui-form-item">
    			<label class="layui-form-label">方案名称</label>
    			<div class="layui-input-inline">
      				<input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  		   </div>

	       <br />
<!-- 	       <h1 style="font-size: 18px;">扑救方案介绍、扑火方式与注意事项</h1> -->
		   <hr class="layui-bg-green">
		   <div class="layui-form-item layui-form-text">
				<label class="layui-form-label">扑救方案介绍、扑火方式与注意事项</label>
					 <div class="layui-input-block">
	  				<textarea placeholder="请输入内容" class="layui-textarea"></textarea>
				</div>
 		   </div>
		   <br />
		   <h1 style="font-size: 18px;">扑火方式与注意事项</h1>
		   <hr class="layui-bg-green">
		   <h1 style="font-size: 12px;"><i class="layui-icon" style="font-size: 20px;">&#xe602;</i>在火焰高度不超过1. 5 m时可采取直接扑救。森林火灾无论如何燃烧和蔓延，约有一半以上长度的火线燃烧强度不高，如火尾、主火头两侧、逆风火以及山势大转折(主要是坡向大转折)等，扑火人员在这些地段进行直接扑救，消除燃烧火源。直接扑救常可使用的工具有树枝、灭火鞭、木棒以及风力灭火机、灭火弹等。扑救方法是背着火举起工具(如树枝、灭火鞭)朝火线先打后拖，必须一打一拖，而不是直上直下地打，以避免火星四溅引燃未燃烧的杂草，同时要重打轻抬、边打边进，找准火边扑打，俗称外线火，就是未燃烧可燃物与正在燃烧可燃物之间的部位。如果使用木棒扑火，也可以就地取材，木棒长度约2.3m，粗细
适合舞动就行，扑火时不能举起木棒直上直下扑打，而是把木棒伸进可燃物底部，用力左右上下搅动击打可燃物，可燃物被击打振动后，正在燃烧部位与未燃烧部位脱断，然后再举起木棒压打可燃物，火就被扑灭。如果发生森林火灾燃烧猛烈，形成树冠火，风力又大，伴随火旋风，火焰高度超过1.5m时，四周温度高，热浪烫人、浓烟呛鼻，扑火人员很难靠近火线，这时只能采用间接扑救来消除燃烧的可燃物，可采用有开设隔火带阻隔和以火攻火等手段。</h1>
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">扑救人员</h2>
	    <div class="layui-colla-content">
	      <p>在前端技术快速变革的今天，layui 仍然坚持语义化的组织模式，甚至于模块理念都是采用类AMD组织形式，并非是有意与时代背道而驰。layui 认为以jQuery为核心的开发方式还没有到完全消亡的时候，而早期市面上基于jQuery的UI都普通做得差强人意，所以需要有一个新的UI去重新为这一领域注入活力，并采用一些更科学的架构方式。
	      <br><br>
	      因此准确地说，layui 更多是面向那些追求开发简单的前端工程师们，以及所有层次的服务端程序员。</p>
	    </div>
	  </div>
	  <div class="layui-colla-item">
	  	<h2 class="layui-colla-title">覆盖范围与扑救路线</h2>
	    <div class="layui-colla-content">
		<form class="layui-form layui-form-pane" action="">
			<div  style="margin-left:4cm;" class="layui-form-item">
	    		<label class="layui-form-label">起点</label>
			    <div class="layui-input-inline">
			      <select name="quiz1">
			        <option value="">请选择省</option>
			        <option value="浙江" selected="">海淀区消防支队</option>
			        <option value="你的工号">江西省</option>
			        <option value="你最喜欢的老师">福建省</option>
			      </select>
			    </div>
		    	<label class="layui-form-label">终点路径ID</label>
		    	<div class="layui-input-inline">
		      		<input type="text" name="username" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
		    	</div>
		    	<button class="layui-btn layui-btn-danger">选择终点</button>
	    		<button class="layui-btn layui-btn-normal">计算路线</button>
	  		</div>
		</form>
    	<table style="margin-top:0.5cm;" class="layui-table">
				  <colgroup>
				    <col width="70">
				    <col width="70">
				    <col width="70">
				    <col width="70">
				    <col width="70">
				    <col width="90">
				    <col>
				  </colgroup>
				  <thead>
				    <tr>
				      <th>路径ID</th>
				      <th>路径类型</th>
				      <th>路径宽度</th>
				      <th>路径长度</th>
				      <th>预计通过时间</th>
				      <th>操作</th>
				    </tr> 
				  </thead>
				  <tbody>
				    <tr>
				      <td>3</td>
				      <td>防火公路</td>
				      <td>10</td>
				      <td>1.2km</td>
				      <td>1min</td>
				      <td>
				      	  <button class="layui-btn layui-btn-small">修改</button>
				      	  <button class="layui-btn layui-btn-small layui-btn-danger">删除</button>
				      </td>
				    </tr>
				    <tr>
				      <td>17</td>
				      <td>防火小路</td>
				      <td>5</td>
				      <td>3.1km</td>
				      <td>20min</td>
				      <td>
				      	  <button class="layui-btn layui-btn-small">修改</button>
				      	  <button class="layui-btn layui-btn-small layui-btn-danger">删除</button>
				      </td>
				    </tr>
				  </tbody>
		</table>
		<button style="margin-left:12cm;" class="layui-btn layui-btn-danger">添加路径</button>
		<button class="layui-btn layui-btn-normal">预览路线</button>
	    <button class="layui-btn" lay-submit="" lay-filter="demo1">确定</button>	    
      	<button type="reset" class="layui-btn layui-btn-primary">重置</button> 
	      
	    
	    </div>
	  </div>
	  
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">扑救物资</h2>
	    <div class="layui-colla-content">
	     		
	     		
	     		<form class="layui-form layui-form-pane" action="">
		     		<div class="layui-form-item">
		     		
		     		<label class="layui-form-label">行内选择框</label>
				    <div class="layui-input-inline">
				      <select name="quiz1">
				        <option value="">请选择省</option>
				        <option value="浙江" selected="">浙江省</option>
				        <option value="你的工号">江西省</option>
				        <option value="你最喜欢的老师">福建省</option>
				      </select>
				    </div> 
			 		</div>
		 		</form>
		 
		 
		 
		    
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">水源</h2>
	    <div class="layui-colla-content">
	      <p>man！ 所以这个问题不要再出现了。。。</p>
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">不可启用条件</h2>
	    <div class="layui-colla-content">
	      <p>man！ 所以这个问题不要再出现了。。。</p>
	    </div>
	  </div>
	</div>
	
	<br />
	<button style="margin-left:15cm;" class="layui-btn" lay-submit="" lay-filter="demo1">创建预案</button>
    <button type="reset" class="layui-btn layui-btn-primary">重置</button> 
 	</form>
	<script type="text/javascript" src="/js/jquery-latest.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	layui.use('element', function(){
		  var $ = layui.jquery
		  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块		  
		});	
	
	layui.use(['form', 'layedit', 'laydate'], function(){			//必须监听表单，否则某些样式出不来
			var form = layui.form
			,layer = layui.layer
			,layedit = layui.layedit
			,laydate = layui.laydate;	



	  		form.on('submit(demo1)', function(data){								 

			  console.log(data.field);
			  $.each(data.field,function(name,value) {
				  console.log(name, value);				  
			  });

		    
		    return false; //false表示使用AJAX提交，否则会跳转
		  });



		});



						
	</script>   
</body>
</html>