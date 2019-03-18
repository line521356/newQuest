<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/StatCharts/style.css">
<link rel="stylesheet" href="/css/StatCharts/font-awesome.min.css">

<title>监控数据展示面板</title>
</head>

<body>

<div class="container">
	<div class="row clearfix">
		<div class="col-md-12 column">
		
			
			
			<!-- 第2行 -->
			<div class="row">
				<div class="col-lg-12">
		          <section class="panel">
		            <header style="font-size: 18px;" class="panel-heading">
		                               各监控点报警次数统计
		            </header>
		            <div class="btn-group" data-toggle="buttons">
		              <label class="btn btn-small btn-white active">
<!-- 		                <input type="radio" name="options" id="option1"> 天 -->
		                <a href="#" onclick="toYear()">年</a>
		              </label>
		              <label class="btn btn-small btn-white">
<!-- 		                <input type="radio" name="options" id="option2"> 周 -->
		                <a href="#" onclick="toMonth()">月</a>
		              </label>
		              <label class="btn btn-small btn-white">
<!-- 		                <input type="radio" name="options" id="option2"> 月 -->
		                <a href="#" onclick="toWeek()">周</a>
		              </label>
		              <label class="btn btn-small btn-white">
<!-- 		                <input type="radio" name="options" id="option2" onclick="toYear()"> 年 -->
							<a href="#" onclick="toDaily()">天</a>
		              </label>
		            </div>
		            <div class="line line-large pull-in"></div>
<!-- 		            <div class="sparkline" id="frequence" data-type="line" data-resize="true" data-height="200" data-width="100%" data-line-color="#bfea5f" data-fill-color="#f3fce3" data-highlight-line-color="#e1e5e9" data-spot-radius="5" data-composite-data="[20,20,17,18,25,25,20,20,28,27,31,25]" data-composite-line-color="#a3e2fe" data-composite-fill-color="#e3f6ff"></div> -->
		            <div id="frequence" style="width: 100%;height:200px;"></div>
<!-- 		            <ul class="list-inline text-muted axis"><li style="font-size: 15px;">监控点1</li><li style="font-size: 15px;">监控点2</li><li style="font-size: 15px;">监控点3</li><li style="font-size: 15px;">监控点4</li><li style="font-size: 15px;">监控点5</li><li style="font-size: 15px;">监控点6</li><li style="font-size: 15px;">监控点7</li><li style="font-size: 15px;">监控点8</li><li style="font-size: 15px;">监控点9</li><li style="font-size: 15px;">监控点10</li><li style="font-size: 15px;">监控点11</li><li style="font-size: 15px;">监控点12</li></ul> -->
		          </section>
		        </div>		        
			</div>
			
	 <div class="row">
        <div class="col-lg-6">
          <section class="panel">
            <header class="panel-heading" style="font-size: 18px;">视频存储情况</header>
            <div class="text-center">              
<!--               <div class="sparkline inline" data-type="pie" data-height="175" data-slice-colors="['#233445','#3fcf7f','#ff5f5f','#f4c414','#13c4a5']">43,17,5,35</div> -->
              <div id="storage" style="width: 100%;height:175px;"></div>
              <div class="line pull-in"></div>
<!--               <div class="text-mini"> -->
<!--                 <i class="icon-circle text-info"></i><a style="font-size: 15px;">监控视频</a> -->
<!--                 <i class="icon-circle text-success"></i><a style="font-size: 15px;">手动录制视频</a> -->
<!--                 <i class="icon-circle text-danger"></i><a style="font-size: 15px;">报警视频</a> -->
<!--                 <i class="icon-circle text-warning"></i><a style="font-size: 15px;">空闲内存</a> -->
<!--               </div> -->
            </div>
          </section>
        </div>
        <div class="col-lg-6">
          <section class="panel">
            <header class="panel-heading" style="font-size: 18px;">报警频次总计</header>
            <div class="text-center">
              <div class="inline">
<!--                 <div class="sparkline inline" data-type="bar" data-height="145" data-bar-width="20" data-bar-spacing="10" data-bar-color="#a3e2fe" data-composite-data="[10,8,12,13,22,15,18]" data-composite-line-color="#bfea5f" data-composite-fill-color="#f3fce3" data-highlight-line-color="#e1e5e9" data-spot-radius="3">5,15,12,18,20,17,13</div> -->
<!--                 <ul class="list-inline text-muted axis"><li style="font-size: 13px;">Jan.<br>5%</li><li style="font-size: 13px;">Feb.<br>15%</li><li style="font-size: 13px;">Mar.<br>12%</li><li style="font-size: 13px;">Apr.<br>18%</li><li style="font-size: 13px;">May.<br>20%</li><li style="font-size: 13px;">June.<br>17%</li><li style="font-size: 13px;">July.<br>13%</li></ul> -->
              	 <div id="total" style="width:300px; height:175px;"></div>
              </div>
              <div class="line pull-in"></div>
<!--               <div class="text-small">&nbsp&nbsp&nbsp&nbsp</div> -->
            </div>
          </section>
        </div>
        
      </div>
			
			
			
		</div>
	</div>
</div>

	
	
    
    
	<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
 
	<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type='text/javascript' src="/js/StatCharts/app.data.js"></script>
	<script type='text/javascript' src="/js/StatCharts/app.js"></script>
	<script type='text/javascript' src="/js/StatCharts/app.plugin.js"></script>
	<script type='text/javascript' src="/js/StatCharts/jquery.easy-pie-chart.js"></script>
	<script type='text/javascript' src="/js/StatCharts/jquery.sparkline.min.js"></script>
	<script type='text/javascript' src="/js/StatCharts/echarts.min.js"></script>
	<script type="text/javascript">
	
	    $(document).ready(function(){		//默认显示年数据
	    	toYear();
	    	renderStorage();
	    	renderTotal();
	    	chkStorage();
		});
	    
	    function renderTotal(){
	    	var myChart = echarts.init(document.getElementById('total'));
	        var option = {
	        	    color: ['#FF9900'],
	        	    tooltip : {
	        	        trigger: 'axis',
	        	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	        	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        	        }
	        	    },
	        	    grid: {
	        	        left: '3%',
	        	        right: '4%',
	        	        bottom: '3%',
	        	        containLabel: true
	        	    },
	        	    xAxis : [
	        	        {
	        	            type : 'category',
	        	            data : ['Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
	        	            axisTick: {
	        	                alignWithLabel: true
	        	            }
	        	        }
	        	    ],
	        	    yAxis : [
	        	        {
	        	            type : 'value'
	        	        }
	        	    ],
	        	    series : [
	        	        {
	        	            name:'报警频次总计',
	        	            type:'bar',
	        	            barWidth: '60%',
	        	            data:[23, 25, 15, 11, 7, 8, 11]
	        	        }
	        	    ]
	        	};

		        // 使用刚指定的配置项和数据显示图表。
		        myChart.setOption(option);
	    }
	
	    function renderStorage(){
	    	var myChart = echarts.init(document.getElementById('storage'));
	        var option = {
	        	    tooltip : {
	        	        trigger: 'item',
	        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	        	    },
	        	    legend: {
	        	        orient: 'vertical',
	        	        left: 'left',
	        	        data: ['监控视频','录制视频','报警视频','空闲内存']
	        	    },
	        	    series : [
	        	        {
	        	            name: '存储空间',
	        	            type: 'pie',
	        	            radius : '55%',
	        	            center: ['50%', '60%'],
	        	            data:[
	        	                {value:335, name:'监控视频'},
	        	                {value:234, name:'录制视频'},
	        	                {value:135, name:'报警视频'},
	        	                {value:1548, name:'空闲内存'}
	        	            ],
	        	            itemStyle: {
	        	                emphasis: {
	        	                    shadowBlur: 10,
	        	                    shadowOffsetX: 0,
	        	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	        	                }
	        	            }
	        	        }
	        	    ]
	        	};

		        // 使用刚指定的配置项和数据显示图表。
		        myChart.setOption(option);
	    }
	    
	    function chkStorage(){
	    	$.ajax( {
				 async : true, //是否异步
				 cache : false, //是否使用缓存
				 type : 'get', //请求方式,post
				 dataType : "json", //数据传输格式
				 url : "<%=request.getContextPath() %>/stat/chkStoreVid", //请求链接 
				 error : function() {
					 alert('网络故障！');
				 },
				 success : function(data) {       //success函数主要将Json数据转化为带有规范样式的节点	 			 	
					console.log("取数据成功");
					var myChart = echarts.init(document.getElementById('storage'));
					var option = {			        	    
			        	    series : [
			        	        {
			        	            name: '存储空间',
			        	            type: 'pie',
			        	            radius : '55%',
			        	            center: ['50%', '60%'],
			        	            data: data,			        	            
			        	        }
			        	    ]
			        	};
					myChart.setOption(option);
				 }
			 });
	    }
	
		function toYear(){
			//$("#frequence").sparkline([34,43,43,35,44,32,44,52],{type:"line",width:"100%",height:"200",lineColor:"#1ab394",fillColor:"#ffffff"});
	        var myChart = echarts.init(document.getElementById('frequence'));

	        // 指定图表的配置项和数据
	        var option = {
	            tooltip: {},
	            legend: {
	                data:['报警频次']
	            },
	            xAxis: {
	                data: ["大门坨","五龙泉","萝芭地","四平亭","茧兰坡","虎头崖","寨尔峪","丹霞岭","红叶谷","沐春亭","望京塔","将军台"]
	            },
	            yAxis: {},
	            series: [{
	                name: '报警频次',
	                type: 'line',
	                data: [7, 12, 11, 16, 9, 19, 21, 25, 26, 13, 11, 5],
	                itemStyle: {
                        normal: {
                            color: '#33CCFF'
                        }
                    },
	                areaStyle: {}
	            }]
	        };

	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);			
		}
		
		function toMonth(){
			//$("#frequence").sparkline([34,43,43,35,44,32,44,52],{type:"line",width:"100%",height:"200",lineColor:"#1ab394",fillColor:"#ffffff"});
	        var myChart = echarts.init(document.getElementById('frequence'));

	        // 指定图表的配置项和数据
	        var option = {
	            tooltip: {},
	            legend: {
	                data:['报警频次']
	            },
	            xAxis: {
	                data: ["大门坨","五龙泉","萝芭地","四平亭","茧兰坡","虎头崖","寨尔峪","丹霞岭","红叶谷","沐春亭","望京塔","将军台"]
	            },
	            yAxis: {},
	            series: [{
	                name: '报警频次',
	                type: 'line',
	                data: [5, 7, 10, 3, 3, 1, 2, 5, 7, 3, 5, 7],
	                itemStyle: {
                        normal: {
                            color: '#33CCFF'
                        }
                    },
	                areaStyle: {}
	            }]
	        };

	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);			
		}
		
		function toWeek(){
			//$("#frequence").sparkline([34,43,43,35,44,32,44,52],{type:"line",width:"100%",height:"200",lineColor:"#1ab394",fillColor:"#ffffff"});
	        var myChart = echarts.init(document.getElementById('frequence'));

	        // 指定图表的配置项和数据
	        var option = {
	            tooltip: {},
	            legend: {
	                data:['报警频次']
	            },
	            xAxis: {
	                data: ["大门坨","五龙泉","萝芭地","四平亭","茧兰坡","虎头崖","寨尔峪","丹霞岭","红叶谷","沐春亭","望京塔","将军台"]
	            },
	            yAxis: {},
	            series: [{
	                name: '报警频次',
	                type: 'line',
	                data: [2, 3, 2, 4, 4, 4, 3, 2, 1, 1, 1, 2],
	                itemStyle: {
                        normal: {
                            color: '#33CCFF'
                        }
                    },
	                areaStyle: {}
	            }]
	        };

	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);			
		}
		
		function toDaily(){
			//$("#frequence").sparkline([34,43,43,35,44,32,44,52],{type:"line",width:"100%",height:"200",lineColor:"#1ab394",fillColor:"#ffffff"});
	        var myChart = echarts.init(document.getElementById('frequence'));

	        // 指定图表的配置项和数据
	        var option = {
	            tooltip: {},
	            legend: {
	                data:['报警频次']
	            },
	            xAxis: {
	                data: ["大门坨","五龙泉","萝芭地","四平亭","茧兰坡","虎头崖","寨尔峪","丹霞岭","红叶谷","沐春亭","望京塔","将军台"]
	            },
	            yAxis: {
	            	minInterval : 1,
	            	boundaryGap : [0, 0.1],
	            },
	            series: [{
	                name: '报警频次',
	                type: 'line',
	                data: [0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0],
	                itemStyle: {
                        normal: {
                            color: '#33CCFF'
                        }
                    },
	                areaStyle: {}
	            }]
	        };

	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);			
		}
	
	</script>
	
</body>
</html>