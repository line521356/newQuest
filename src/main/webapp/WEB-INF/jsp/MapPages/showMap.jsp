<!DOCTYPE html>  
<html>
<head>  
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>Hello, World</title>  
<style type="text/css">  
html{height:100%}  
body{height:100%;margin:0px;padding:0px}
.BMap_cpyCtrl {  
    display: none;  
}  
  
.anchorBL {  
    display: none;  
}    
#container{height:100%}  
</style>  
<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=iOhOVn5Gw3BHaHbdjWwFln8vlAaAedaQ">
//v3.0版本的引用方式：src="http://api.map.baidu.com/api?v=3.0&ak=您的密钥"
</script>
</head>  
 
<body>  
<div id="container"></div> 
<script type="text/javascript"> 

//-----------------------------设置地图参数----------------------
	var map = new BMap.Map("container",{minZoom:15,maxZoom:17,enableMapClick:false});	// 创建地图实例 
	var point = new BMap.Point(116.086286,40.061584);                                   // 创建点坐标  
	map.centerAndZoom(point, 15);														// 初始化地图，设置中心点坐标和地图级别  
	map.enableScrollWheelZoom(true);
	map.disableDragging(); 
	map.enableKeyboard();

//----------------------------开始绘图---------------------------
	var canvasLayer = new BMap.CanvasLayer({
	        update: update
	    });
	    
	function update() {
        var ctx = this.canvas.getContext("2d");

        if (!ctx) {
            return;
        }

        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);

        var temp = {};
        ctx.fillStyle = "rgba(50, 50, 255, 0.7)";
        ctx.beginPath();
        var data = [
            new BMap.Point(116.086031,40.067978)
        ];
        var pixel = map.pointToPixel(data[0]);
        var img=new Image();
        img.src="/image/tiles/1.jpg";
    
        ctx.drawImage(img,pixel.x, pixel.y);
        //for (var i = 0, len = data.length; i < len; i++) {
            var pixel = map.pointToPixel(data[0]);
            //ctx.fillRect(pixel.x, pixel.y, img.width, img.height);
        //}
    }
    map.addOverlay(canvasLayer);

</script>  
</body>  
</html>