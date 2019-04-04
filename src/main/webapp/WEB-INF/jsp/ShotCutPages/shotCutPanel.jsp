<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 截图模块浏览查询主页面  -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/plugins/layUI2/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="/css/Viewer/viewer.min.css">
<style>
* { margin: 0; padding: 0;}
#imgShowSection { width: 700px; margin: 0 auto; font-size: 0;}
#imgShowSection li { display: inline-block; width: 32%; margin-left: 1%; padding-top: 1%;}
#imgShowSection li img { width: 100%;}
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
							autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
					</div>
					<label class="layui-form-label">截止时间</label>
					<div class="layui-input-inline">
						<input type="text" name="recTime_ed" id="recTime_ed"
							autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
					</div>
					<div class="layui-input-inline">
						<button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="demo1">搜索</button>
					</div>
				</div>
			</div>
		</form>
	</fieldset>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
  <legend>图片列表</legend>
</fieldset>



<ul id="imgShowSection"></ul>
<div id="demo9" align="center"></div>

    
    
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/ZTree/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="/js/Viewer/viewer-jquery.min.js"></script>
	<script type="text/javascript" src="/js/json2.js"></script>
	<script type="text/javascript" src="/plugins/layui/layui.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		
	   
	
		$(document).ready( function(){
			onloadVideos();                //加载所有节点	0727暂时注释，先测试页面效果    
			$(".selBox").hide();
	
		});
		
		
		
		
		function onloadVideos(){
			 
			 $.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "<%=request.getContextPath() %>/shotcut/loadAllShots", //请求链接 
				 error : function() {
					 alert('亲，网络有点不给力呀！');
				 },
				 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 						
 				 	var shotcutList = data.shotCutImgs;
 				 	renderNodesNew(shotcutList);  //新版图片列表
				 }
			 });
		}
		
		function askSrchResult(keyWords){
			
			console.log("Arrive askSrchResult() !" + keyWords.endDate);
			
			$.ajax({
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'post', //请求方式,post
				 dataType : "json", //数据传输格式
				 contentType:"application/json",
				 data:JSON.stringify(keyWords),
				 url : "<%=request.getContextPath() %>/mVid/getKeyWords", //请求链接 
				 error : function() {
					 alert('不好意思，又TM出BUG了');
				 },
				 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
					 var shotcutList = data.shotCutImgs;
	 				 renderNodesNew(shotcutList);  //新版图片列表	ViewerJS
				 }
			 });
			
		}
		
		
		function renderNodesNew(targetNodes){
			
			var imgBoardBody = new Array();
			var imgNodes = targetNodes;
			
			$.each(imgNodes, function(index, imgNode){
				if(imgNode.scImgType == 1){
					var tempType = "手动截取";
				} else {
					var tempType = "报警自动截取";
				}				
				//imgBoardBody.push("<li><img data-original='/ActivityPic/" + imgNode.scImgUrl + "' src='/ActivityPic/" + imgNode.scImgUrl +"' alt='图片编号：" + imgNode.scImgId + " 图片名称：" + imgNode.scImgUrl + " 来自监控点：" + imgNode.srcMonitor.mptName  +" 类型： " + tempType + " 当值人员：" + imgNode.srcCrew.crewName+ "'></li>");	
				imgBoardBody.push("<li><img data-original='/ActivityPic/" + imgNode.scImgUrl + "' src='/ActivityPic/" + imgNode.scImgUrl +"' alt='图片编号：" + imgNode.scImgId + " 图片名称：" + imgNode.scImgUrl + "'></li>");
				}
 		 	)

 		 	
 		 	layui.use(['laypage', 'layer'], function(){
	 			  var laypage = layui.laypage
	 			  ,layer = layui.layer;
	 			  
	 			
	 			  var nums = 9; //每页出现的数据量
	 			  
	 			  //模拟渲染
	 			  var render = function(imgBoardBody, curr){
	 			    var arr = []
	 			    ,thisData = imgBoardBody.concat().splice(curr*nums-nums, nums);
	 			    layui.each(thisData, function(index, item){
	 			      arr.push(item);
	 			    });
	 			    return arr.join('');
	 			  };
	 			  
	 			  //调用分页
	 			  laypage({
	 			    cont: 'demo9'
	 			    ,pages: Math.ceil(imgBoardBody.length/nums)
	 			    ,skin: '#1E9FFF'
	 			    ,jump: function(obj){
	 			      $("#imgShowSection").empty(); 
	 			      document.getElementById('imgShowSection').innerHTML = render(imgBoardBody, obj.curr);	 			       
	 			      $('#imgShowSection').viewer({
		 					url: 'data-original',
		 				});
	 			      $("#imgShowSection").viewer('update');
	 			    }
	 			  });
	 			  
	 			});
			
		}
		
	
		//-------------------------------------搜索栏表单验证 -----------------------------------
		
		layui.use(['form', 'layedit', 'laydate'], function(){
			  var form = layui.form()
			  ,layer = layui.layer
			  ,layedit = layui.layedit
			  ,laydate = layui.laydate;
			  
			  			  			  
			  //创建一个编辑器
			  var editIndex = layedit.build('LAY_demo_editor');
			 
			  //自定义验证规则
			  form.verify({
			    title: function(value){
			      if(value.length < 5){
			        return '标题至少得5个字符啊';
			      }
			    }
			    ,pass: [/(.+){6,12}$/, '密码必须6到12位']
			    ,content: function(value){
			      layedit.sync(editIndex);
			    }
			  });
			  
			  //监听指定开关
			  form.on('switch(switchTest)', function(data){
			    layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
			      offset: '6px'
			    });
			    layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
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
					    //整合所有数据
						var req = {"scImgId":data.field.srchType, "scImgName":data.field.keyWord, 
					    		"scImgType":data.field.imgType, "scImgUrl":data.field.recTime_st, "createTime":data.field.recTime_ed}
					    		
						$.ajax( {
						     async : false, //这里不开异步，以防点数据赋值混乱
						     cache : false, //是否使用缓存
						     type : 'post', //请求方式,post
						     dataType : "json", //数据传输格式
						     url : "srchImgsForView", //请求链接
						     contentType:"application/json",
						     data:JSON.stringify(req),
						     error : function() {
						       alert('网络故障！');
						     },
						     success : function(data) {
						       	 if(data.msg == 1){		       		
									 var shotcutList = data.shotCutImgs;
					 				 renderNodesNew(shotcutList);  
						       	 }				    	 				       
						     }
						});	
				  } 					       	 
			    return false;
			  });
			  
			  
			})
			
	//-----------------------删除模块---------------------------------------------
		function toggleComdS(){
			$("#delComd").attr("class","layui-btn layui-btn-normal layui-btn layui-btn-normal-warm");
			$("#delComd").text("完成");
			$("#delComd").attr("onclick","toggleComdF()");
			$("#delComd").after("<button class='layui-btn layui-btn-normal layui-btn layui-btn-normal-danger' id='delNow' onclick='smtDelNodes()'>删除</button>");
			$(".selBox").show();
			
			layui.use(['form'], function(){
				  var form = layui.form();
				  form.render('checkbox');	
				  
				  form.on('checkbox(sendDelNodes)', function(data){					  
					  console.log("checked" + data.elem.checked); //是否被选中，true或者false
					  console.log("value" + data.value); //复选框value值，也可以通过data.elem.value得到					 
					}); 				  
				})	
		}
		
		function toggleComdF(){
			$("#delComd").attr("class","layui-btn layui-btn-normal");
			$("#delComd").text("编辑");
			$("#delComd").attr("onclick","toggleComdS()");
			$("#delNow").remove();
			$(".selBox").hide();
		}
		
		function smtDelNodes(){
			
			var delNodes = new Array();
		
			$("input[type=checkbox]").each(function(){
				 if($(this).prop("checked") == true){
					 delNodes.push($(this).val());
				 } 				 
				});
			
			
			var toJsonDNodes = eval( "["+delNodes+"]" );
			var UltNodes = new Array();
		
			$.each(toJsonDNodes,function(index,that){
				UltNodes.push({vidType:that.vidType, vidId:that.vidId});
				console.log(UltNodes[index]);
			});
			
		
			$.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : "post", //请求方式,post
				 traditional:true,
				 dataType:"json",
				 contentType:"application/json",
				 data:JSON.stringify(UltNodes),
				 url : "<%=request.getContextPath() %>/mVid/delVids", //请求链接 
				 error : function() {
					 alert('No it dosent work.');
				 },
				 success : function(data) {
					 alert("提交成功！正在更新数据...");
					 location.href = "toVideoBoard2";
				 }
			 });
			
		}
			
		  
	</script>
</body>
</html>