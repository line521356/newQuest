var canvas,context;
var img,//图片对象
    imgIsLoaded,//图片是否加载完成;
    imgX=0,
    imgY=0,
    imgScale=1,

    curZoomLevel = 1,    //DIY变量 1 ：当前放缩级别
    curTile = null,      //DIY变量 2 ：当前瓦片，img对象
//    hasRoute = 0,        //DIY变量 3 ：当前是否需显示路径,应用场景就是把纯地图浏览不需要加载路线之类的信息与路径规划区分开来
    curPlanID = -1;		 //当前选取的方案ID，默认-1
//    fpXFixed = 689,
//	fpYFixed = 584;

var Point = function (x, y) {
        this.startX = x;
        this.startY = y;
    };

    var driveWay = null;		//表示从后台取得的路径或线段
    var path = null;
    var segTerms = null;    //曾经线段测试用到的点集变量
    var materials = null;
    var watersource = null;
    //-----------------以下4个变量是为了存储原本从后台取得的原始值，用来做平移放缩的复原---------------------------
    var driveWayOringin = null;		//表示从后台取得的路径或线段
    var pathOringin = null;
    var materialsOringin = null;
    var watersourceOringin = null;


(function int(){
    canvas=document.getElementById('canvas');
    context=canvas.getContext('2d');
    loadImg();
})();

function loadImg(){
    img=new Image();              //一级地图 分辨率 90 +dp
    img.onload=function(){
        imgIsLoaded=true;
        drawImage(img);
        colorIt(materials, watersource);	//为什么这里要先画呢，因为miniMap的函数的加载顺序的问题，在testSegment中画了一遍才执行了地图的加载，所以画的路线被覆盖了
        countRoute3(driveWay, path);
    }
    img.src="../image/tiles/map_LP_PoiAdded.png";
    //img.src="../image/tiles/map180_PoiAdded.png"
    curTile = img;

    optImg=new Image();          //火点图标
    optImg.onload=function(){
        imgIsLoaded=true;
    }
    optImg.src="../image/icons/outbreakPoint.png";

    firecar=new Image();          //车图标
    firecar.onload=function(){
        imgIsLoaded=true;
    }
    firecar.src="../image/icons/firecar.png";

    walk=new Image();          //人行图标
    walk.onload=function(){
        imgIsLoaded=true;
    }
    walk.src="../image/icons/walk.png";

    goods=new Image();          //物资图标
    goods.onload=function(){
        imgIsLoaded=true;
    }
    goods.src="../image/icons/goods.png";

    water=new Image();          //水图标
    water.onload=function(){
        imgIsLoaded=true;
    }
    water.src="../image/icons/water.png";

    xiaofangshuan=new Image();          //消防栓图标
    xiaofangshuan.onload=function(){
        imgIsLoaded=true;
    }
    xiaofangshuan.src="../image/icons/xiaofangshuan.png";

    staff1=new Image();          //人员图标
    staff1.onload=function(){
        imgIsLoaded=true;
    }
    staff1.src="../image/icons/staff1.png";

    staff2=new Image();          //人员图标
    staff2.onload=function(){
        imgIsLoaded=true;
    }
    staff2.src="../image/icons/staff2.png";
}


//----------------------------------------------------------画图片------------------------------------------------
function drawImage(curImage){
    context.clearRect(0,0,canvas.width,canvas.height);  //在给定矩形内清空一个矩形：http://www.w3school.com.cn/tags/canvas_clearrect.asp
    context.drawImage(curImage,0,0,curImage.width,curImage.height,imgX,imgY,curImage.width*imgScale,curImage.height*imgScale);  //http://blog.csdn.net/zhaoruda/article/details/70233455
    console.log("Now draw this :" +  curImage + " " + curImage.width + " " +  curImage.height + " " + imgX + "," + imgY + " "  + imgScale);
}


//二代地图移动坐标点重新计算函数，路径现在是两层循环
function countRPLoc2(imgX, imgY){
    //console.log("现在的imgX和imgY是" + imgX + "  " + imgY);
    
	for(var i=0; i < driveWay.length; i++){
		var temp = driveWay[i];
		for(var j=0; j < temp.length; j++){
	      temp[j].pointX = temp[j].pointX + imgX;
	      temp[j].pointY = temp[j].pointY + imgY;
		}
	}
	
	for(var i=0; i < path.length; i++){
		var temp = path[i];
		for(var j=0; j < temp.length; j++){
	      temp[j].pointX = temp[j].pointX + imgX;
	      temp[j].pointY = temp[j].pointY + imgY;
		}
	}
	
    for (var i = 0; i < materials.length; i++) {
        materials[i].pointX = materials[i].pointX + imgX;
        materials[i].pointY = materials[i].pointY + imgY;
    }
    
    for (var i = 0; i < watersource.length; i++) {
        watersource[i].pointX = watersource[i].pointX + imgX;
        watersource[i].pointY = watersource[i].pointY + imgY;
    }

}

//------------------------------------------图片平移------------------------------------------------
canvas.onmousedown=function(event){            //监听鼠标点击的点下操作
    var pos=windowToCanvas(canvas,event.clientX,event.clientY);
    canvas.onmousemove=function(event){           //鼠标在点下状态开始移动，此时图片发生平移
        canvas.style.cursor="move";
        var pos1=windowToCanvas(canvas,event.clientX,event.clientY);
        var x=pos1.x-pos.x;
        var y=pos1.y-pos.y;
        pos=pos1;
        imgX+=x;
        imgY+=y;
        if (imgX > 0) {   //边界控制 粗暴版
            imgX = 0;
        }
        if (imgY > 0) {
            imgY = 0;
        }
        drawImage(curTile);
    }
    canvas.onmouseup=function(){        //鼠标弹上，不再监听鼠标移动和鼠标弹上
       
        driveWay = JSON.parse(JSON.stringify(driveWayOringin));
        path = JSON.parse(JSON.stringify(pathOringin));
        materials = JSON.parse(JSON.stringify(materialsOringin));
        watersource = JSON.parse(JSON.stringify(watersourceOringin));
        countRPLoc2(imgX, imgY);
        colorIt(materials, watersource);     
        countRoute3(driveWay,path);

        
        canvas.onmousemove=null;
        canvas.onmouseup=null;
        canvas.style.cursor="default";
    }
}




//----------------------------------坐标转换---------------------------------------------------------
function windowToCanvas(canvas,x,y){
    var bbox = canvas.getBoundingClientRect();
    return {
        x:x - bbox.left - (bbox.width - canvas.width) / 2,
        y:y - bbox.top - (bbox.height - canvas.height) / 2
    };
}

//目前这个函数比较完整了，根据火点位置加载POI，后续可以改函数名，注意rtID是指预案ID，不改只是为了和Location对象绑定
function testSegment(zmLev, planID){
  
	  //var req = {"zmLev":zmLev,"rtID":planID, "pointX":fpXFixed, "pointY":fpYFixed};   //这里传的是路径ID不再是getRoute里面的方案ID
	  var req = {"zmLev":zmLev,"rtID":planID};
	
	  $.ajax( {
	     async : false, //这里不开异步，以防点数据赋值混乱
	     cache : false, //是否使用缓存
	     type : 'post', //请求方式,post
	     dataType : "json", //数据传输格式
	     url : "testSegment", //请求链接
	     contentType:"application/json",
	     data:JSON.stringify(req),
	     error : function() {
	       alert('网络故障！');
	     },
	     success : function(data) {
	       if(data.msg == 1){
	    	 console.log("后台已获取距离火点最近的路径!");
	         driveWay = data.driveWay;
	         path = data.path;
	         materials = data.materials;
	         watersource = data.watersource;
	         curPlanID = data.scorePlanID;
	         
	         driveWayOringin = JSON.parse(JSON.stringify(data.driveWay));
	         pathOringin = JSON.parse(JSON.stringify(data.path));
	         materialsOringin = JSON.parse(JSON.stringify(data.materials));
	         watersourceOringin = JSON.parse(JSON.stringify(data.watersource));
	         
	         colorIt(materials, watersource);
	         countRoute3(driveWay, path);
	         
	         

	       }

	     }
	   });

}


//第三代画路径函数，时间复杂度会比较高，但是实现了路径的双向绘制，可以无视路径点的录入顺序，也可以无视路径连接的顺序
function countRoute3(massRoutes, path){
	for(var i=0; i<massRoutes.length; i++){
		var temp = massRoutes[i];
		context.beginPath();
		context.moveTo(temp[0].pointX, temp[0].pointY);
	    for(var j=1; j < temp.length; j++){
		   context.lineTo(temp[j].pointX, temp[j].pointY);
	       context.lineWidth = 5;    //线条的样式
	       context.lineJoin = "round";
	       context.strokeStyle = 'rgba(0,0,255,1)';
	       context.stroke();
	    }
	}
	for(var i=0; i<path.length; i++){
		var temp = path[i];
		context.beginPath();
		context.moveTo(temp[0].pointX, temp[0].pointY);
	    for(var j=1; j < temp.length; j++){
		   context.lineTo(temp[j].pointX, temp[j].pointY);
	       context.lineWidth = 5;    //线条的样式
	       context.lineJoin = "round";
	       context.strokeStyle = 'rgba(255,0,0,1)';
	       context.stroke();
	    }
	}
}

//标绘物资点与水源
function colorIt(materials, watersource){
	
    for(var i=0; i < materials.length; i++){
       context.drawImage(goods,materials[i].pointX-15,materials[i].pointY-15,30,35);		//偏移位置可能还需要微调
    }
    for(var i=0; i < watersource.length; i++){
       context.drawImage(xiaofangshuan,watersource[i].pointX-15,watersource[i].pointY-15,20,25);
    }
}

