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
<title>新用户注册</title>
</head>

<body>

  <fieldset class="layui-elem-field">
	<legend>新用户注册</legend>
	<form class="layui-form layui-form-pane" action="">
		  <br />
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">用户名</label>
		    <div class="layui-input-inline">
		       <input type="text" name="gnrUserName" id="gnrUserName" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|gnrUserName">
		    </div>
		    <div class="layui-form-mid layui-word-aux">用户名需5个字符以上</div>
		  </div>
		  			  
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">密码</label>
		    <div class="layui-input-inline">
		      <input type="password" name="gnrUserPwd" id="gnrUserPwd" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|gnrUserPwd">
		    </div>
		    <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
		  </div>
		  
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">部门</label>
		    <div class="layui-input-inline">
		      	<select name="gusClassName" id="gusClassName" lay-search="" lay-verify="required">
		          <option value="">直接选择或搜索选择</option>
		          <option value="巡防队">巡防队</option>
		          <option value="监控中心">监控中心</option>
		        </select>
		    </div>
		  </div>
		  
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">入职年份</label>
		    <div class="layui-input-inline">
		      <input type="text" name="gusGrade" id="gusGrade" placeholder="请输入" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  		  
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">联系邮箱</label>
		    <div class="layui-input-inline">
		      <input type="text" name="userEmail" id="userEmail" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|email">
		    </div>
		  </div>
		  
		  <div style="margin-left:1cm;" class="layui-form-item">
		    <label class="layui-form-label">联系电话</label>
		    <div class="layui-input-inline">
		      <input type="tel" name="userPhone" id="userPhone" placeholder="请输入" autocomplete="off" class="layui-input" lay-verify="required|phone">
		    </div>
		  </div>
		  		  
		  <button style="margin-left:5cm;" class="layui-btn" lay-submit="" lay-filter="demo1">确认修改</button>
    	  <button type="reset" class="layui-btn layui-btn-primary">重置</button> 
    	  <br />
	</form>
	</fieldset>

	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/page.js"></script>
	<script type="text/javascript" src="/plugins/layUI2/layui/layui.js"></script>
	<script>
	
	var tgUserID = -1;		//记录物资点的位置记录ID
	var userGroup = "";
	var userRight = -1;
	var userName = "";
	
	
	layui.use(['form', 'layedit', 'laydate'], function(){			//必须监听表单，否则某些样式出不来
		  var form = layui.form
		  ,laydate = layui.laydate;
	
		  laydate.render({ 
			  elem: '#gusGrade'
			  ,type: 'year'
			});
		  
		  form.verify({
			  gnrUserName: function(value){
			      if((value.length < 5) || (!/^[a-zA-Z\d]+$/.test(value))){
			        return '用户名至少得5个字符且需为字母与数字的组合';
			      }
			    }
			    ,gnrUserPwd: [/(.+){6,12}$/, '密码必须6到12位']
		  });
	  //提交整个表单
	  form.on('submit(demo1)', function(data){
	    		  
	    //整合所有数据拼成Material对象
		var req = {"gnrUserName":data.field.gnrUserName, "gnrUserPwd":data.field.gnrUserPwd, 
	    		"gusClassName":data.field.gusClassName, "gusGrade":data.field.gusGrade, 
	    		"userEmail":data.field.userEmail, "userPhone":data.field.userPhone}
	    		
		$.ajax( {
		     async : false, //这里不开异步，以防点数据赋值混乱
		     cache : false, //是否使用缓存
		     type : 'post', //请求方式,post
		     dataType : "json", //数据传输格式
		     url : "/user/signUpUser", //请求链接
		     contentType:"application/json",
		     data:JSON.stringify(req),
		     error : function() {
		       alert('网络故障！');
		     },
		     success : function(data) {
		       	 if(data.msg == 1){		       		
		       		layer.alert("注册成功！", function(index){
		       		  var index = parent.layer.getFrameIndex(window.name);
		       	 	  parent.layer.close(index);
		       		  layer.close(index);
		       		  });
		       	 }				    	 				       
		     }
		});
	    

	    	    
	    return false;
	  });
	});					
	</script>   
</body>
</html>