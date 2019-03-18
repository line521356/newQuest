var canvas,context;
var img,//图片对象
    imgIsLoaded,//图片是否加载完成;
    imgX=0,
    imgY=0,
    imgScale=1,

    curZoomLevel = 0,    //DIY变量 1 ：当前放缩级别
    curTile = null,      //DIY变量 2 ：当前瓦片，img对象
    hasRoute = 0,        //DIY变量 3 ：当前是否需显示路径,应用场景就是把纯地图浏览不需要加载路线之类的信息与路径规划区分开来
    curPlanID = -1,		 //当前选取的方案ID，默认-1
    availablePlans = null;
    fpCofirmed = 0,      //火点确认状态，默认没有确认
	fpX = 0,			 //当前火点坐标
	fpY = 0,
	fpXOrigin = 0,	     //当前火点坐标,用于平移时的复原
	fpYOrigin = 0,
	fpXFixed = 0,	     //当前火点坐标（固定值）,设置这两个值的原因是上面四个值都会因为平移放缩而变化，而获取方案是根据一级地图的固定的火点
	fpYFixed = 0;

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
        drawImage2(curZoomLevel);
    }
    img.src="../image/tiles/map_LP_PoiAdded.png";
    //img.src="../image/tiles/map180_PoiAdded.png"
    curTile = img;
  
    imgL2=new Image();          //二级地图 分辨率180dp
    imgL2.onload=function(){
        imgIsLoaded=true;
    }
    imgL2.src="../image/tiles/map180_PoiAdded.png";
    //imgL2.src="../image/tiles/map_LP_PoiAdded.png";

    imgL3=new Image();          //三级地图 分辨率300dp
    imgL3.onload=function(){
        imgIsLoaded=true;
    }
    imgL3.src="../image/tiles/map300_PoiAdded.png";
}

function loadTiles(curZoomLevel){
	
    var stTile = 0;		//瓦片行号
    var edTile = 0;		//瓦片行号
    var stTileY = 0;		//瓦片列号
    var edTileY = 0;		//瓦片列号
	
    stTile = Math.floor((-imgX)/256);
    tileOffset = -(-imgX)%256;
    stTileY = Math.floor((-imgY)/256);
    tileOffsetY = -(-imgY)%256;
    
    if(curZoomLevel == 0){
    	if(stTile + 4 > 4){
    		edTile = 4;
    	} else {
    		edTile = stTile + 4;
    	}
    	if(stTileY + 7 > 7){
    		edTileY = 7;
    	} else {
    		edTileY = edTileY + 7;
    	}
    }
	
	var levStr = "lev" + level;
    var imgMatrix = new Array();
    for(var x=stTile;x<edTile;x++){
    	imgMatrix[x]=new Array();        //声明二维数组
        for(var y=stTileY;y<edTileY;y++){
        	imgMatrix[x][y]= new Image();          //数组初始化为0
        	//imgMatrix[x][y].src = "/ActivityPic/17/tile" + x + "_" + y +".png";  清华的校园图
        	imgMatrix[x][y].src = "/ActivityPic/" + levStr +"/tile" + x + "_" + y +".png";
        	console.log(imgMatrix[x][y]);
        }
    } 
}

//----------------------------------------------------------画图片------------------------------------------------
function drawImage(curImage){
    context.clearRect(0,0,canvas.width,canvas.height);  //在给定矩形内清空一个矩形：http://www.w3school.com.cn/tags/canvas_clearrect.asp
    context.drawImage(curImage,0,0,curImage.width,curImage.height,imgX,imgY,curImage.width*imgScale,curImage.height*imgScale);  //http://blog.csdn.net/zhaoruda/article/details/70233455
    console.log("Now draw this :" +  curImage + " " + curImage.width + " " +  curImage.height + " " + imgX + "," + imgY + " "  + imgScale);
}

function drawImage2(curZoomLevel){			//加载多个图片
    context.clearRect(0,0,canvas.width,canvas.height);  //在给定矩形内清空一个矩形：http://www.w3school.com.cn/tags/canvas_clearrect.asp
    
    if(curZoomLevel == 0){
        var imgMatrix = new Array();
        for(var x=0;x<4;x++){
        	imgMatrix[x]=new Array();        //声明二维数组
            for(var y=0;y<7;y++){
            	imgMatrix[x][y]= new Image();          //数组初始化为0
            	//imgMatrix[x][y].src = "/ActivityPic/17/tile" + x + "_" + y +".png";  清华的校园图
            	imgMatrix[x][y].src = "/ActivityPic/lev1/tile" + x + "_" + y +".png";
            	console.log(imgMatrix[x][y]);
            }
        }
    }
    if(curZoomLevel == 1){
        var imgMatrix = new Array();
        for(var x=0;x<4;x++){
        	imgMatrix[x]=new Array();        //声明二维数组
            for(var y=0;y<7;y++){
            	imgMatrix[x][y]= new Image();          //数组初始化为0
            	imgMatrix[x][y].src = "/ActivityPic/lev2/tile" + x + "_" + y +".png";
            	console.log(imgMatrix[x][y]);
            }
        }
    }

    var stTile = 0;		//瓦片行号
    var edTile = 0;		//瓦片行号
    var stTileY = 0;		//瓦片列号
    var edTileY = 0;		//瓦片列号
    var tileOffset = 0;		//瓦片偏移量
    var tileOffsetY = 0;
//    imgX = -257;
//    imgY = -257;
    
    if (imgX > 0) {   //边界控制左上 粗暴版
        imgX = 0;
    }
    if (imgY > 0) {
        imgY = 0;
    }
    if((imgX < -206) && (curZoomLevel == 1)){	//边界控制右下，3级地图边界不同
    	imgX = -206;
    }
    if((imgY < -50) && (curZoomLevel == 1)){
    	imgY = -50;
    }
    
    stTile = Math.floor((-imgX)/256);
    tileOffset = -(-imgX)%256;
    stTileY = Math.floor((-imgY)/256);
    tileOffsetY = -(-imgY)%256;
    
    if(curZoomLevel == 0){
    	if(stTile + 4 > 4){
    		edTile = 4;
    	} else {
    		edTile = stTile + 4;
    	}
    	if(stTileY + 7 > 7){
    		edTileY = 7;
    	} else {
    		edTileY = edTileY + 7;
    	}
    }
    
    var vrtLoc = 0 + tileOffsetY;
    var hrzLoc = 0 + tileOffset;
    var cursorY = 0;
    var cursor = 0;
    for(var i=stTile; i<edTile; i++){   	
    	vrtLoc = vrtLoc + (cursorY * 256);
        for(var j=stTileY; j<edTileY; j++){
        	hrzLoc = hrzLoc + (cursor * 256);        	
            	//context.drawImage(imgMatrix[i][j],hrzLoc,vrtLoc,imgMatrix[i][j].width,imgMatrix[i][j].height);
        		context.drawImage(imgMatrix[i][j],0,0,imgMatrix[i][j].width,imgMatrix[i][j].height,hrzLoc,vrtLoc,imgMatrix[i][j].width*imgScale,imgMatrix[i][j].height*imgScale);
            	console.log("Now draw this tile:" +  imgMatrix[i][j].src + " " + imgMatrix[i][j].width + " " +  imgMatrix[i][j].height + " " + hrzLoc + "," + vrtLoc + " "  + imgScale);
            	cursor++;
            	hrzLoc = 0 + tileOffset;
        }
        cursorY++;
        vrtLoc = 0 + tileOffsetY;
        cursor = 0;
    }  
    
//    var vrtLoc = 0;
//    var hrzLoc = 0;
//    for(var i=0; i<4; i++){   	
//    	vrtLoc = i * 256 + imgY;
//        for(var j=0; j<7; j++){
//        	hrzLoc = j * 256 + imgX;        	
//            	//context.drawImage(imgMatrix[i][j],hrzLoc,vrtLoc,imgMatrix[i][j].width,imgMatrix[i][j].height);
//        		context.drawImage(imgMatrix[i][j],0,0,imgMatrix[i][j].width,imgMatrix[i][j].height,hrzLoc,vrtLoc,imgMatrix[i][j].width*imgScale,imgMatrix[i][j].height*imgScale);
//            	console.log("Now draw this tile:" +  imgMatrix[i][j].src + " " + imgMatrix[i][j].width + " " +  imgMatrix[i][j].height + " " + hrzLoc + "," + vrtLoc + " "  + imgScale);
//        }
//    }  
}

function countRPLoc(imgX, imgY){
    //console.log("现在的imgX和imgY是" + imgX + "  " + imgY);
    for (var i = 0; i < driveWay.length; i++) {
      driveWay[i].pointX = driveWay[i].pointX + imgX;
      driveWay[i].pointY = driveWay[i].pointY + imgY;
    }
    for (var i = 0; i < path.length; i++) {
      path[i].pointX = path[i].pointX + imgX;
      path[i].pointY = path[i].pointY + imgY;
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

//这个方法只有火点的坐标重定位
function recountFP(imgX, imgY){
	fpX = fpX + imgX;
	fpY = fpY + imgY;
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
        //drawImage(curTile);
        drawImage2(curZoomLevel);
    }
    canvas.onmouseup=function(){        //鼠标弹上，不再监听鼠标移动和鼠标弹上
        if (hasRoute != 0) {
        	//getRoute(curZoomLevel,1);  //重新请求复原坐标
          driveWay = JSON.parse(JSON.stringify(driveWayOringin));
          path = JSON.parse(JSON.stringify(pathOringin));
          materials = JSON.parse(JSON.stringify(materialsOringin));
          watersource = JSON.parse(JSON.stringify(watersourceOringin));
          countRPLoc2(imgX, imgY);
          colorIt(materials, watersource);     
          countRoute3(driveWay,path);

        }
        if(fpCofirmed > 0){
          fpX = fpXOrigin;
          fpY = fpYOrigin;
          recountFP(imgX, imgY);
          drawFP();
        }
        canvas.onmousemove=null;
        canvas.onmouseup=null;
        canvas.style.cursor="default";
    }
}

//---------------------------------------图片缩放----------------------------------------------------
canvas.onmousewheel=canvas.onwheel=function(event){
    var pos=windowToCanvas(canvas,event.clientX,event.clientY);   //这个POS用于跟随鼠标放大
    console.log(event.clientX + "  " + event.clientY);


    event.wheelDelta=event.wheelDelta?event.wheelDelta:(event.deltaY*(-40));
    if(event.wheelDelta>0){    //向上滑轮
        console.log("当前操作：放大 ， 当前放缩等级 ： " + curZoomLevel);
        if (curZoomLevel > 1) {
          alert("已放大到最大级别！");
        } else {
          curTile = selTileZi(event.clientX,event.clientY,curZoomLevel);  //根据鼠标位置选择要操作的瓦片
          if (curZoomLevel == 0) {
            imgX=imgX*2-pos.x + 400;
            imgY=imgY*2-pos.y + 300;
          }
          if (curZoomLevel == 1) {
            imgX=imgX*2-pos.x + 400;
            imgY=imgY*2-pos.y + 200;
          }
          //console.log(curTile);
          if (imgX > 0) {   //边界控制
            imgX = 0;
          }
          if (imgY > 0) {
            imgY = 0;
          }
          curZoomLevel++;
          drawImage2(curZoomLevel);          
          if(hasRoute != 0){
	    	testSegment(curZoomLevel, curPlanID);
	          if((imgX != 0) || (imgY != 0)){                    //这个地方不为0的判断好像有点多余
	        	  countRPLoc2(imgX, imgY);
	          }
            colorIt(materials, watersource);
            countRoute3(driveWay, path);
          }
          if(fpCofirmed != 0){
        	  repositionFP(curZoomLevel, fpXFixed, fpYFixed);
        	  if((imgX != 0) || (imgY != 0)){                    //这个地方不为0的判断好像有点多余
	        	  recountFP(imgX, imgY);
	          }
        	  drawFP();
          }
        }
    } else {                   //向下滑轮
        console.log("当前操作：缩小 ， 当前放缩等级 ： " + curZoomLevel);
        if (curZoomLevel < 2) {
          alert("已缩小到最小级别！");
        } else {
          curTile = selTileZo(event.clientX,event.clientY,curZoomLevel);
          if (curZoomLevel == 2) {
            imgX = 0;           //缩小到1级则复原
            imgY = 0;
          }
          if (curZoomLevel == 3) {
            imgX=imgX*0.5+pos.x*0.5 - 100;
            imgY=imgY*0.5+pos.y*0.5 - 100;
          }
          //console.log(curTile);
          drawImage(curTile);
          curZoomLevel--;
          if(hasRoute != 0){
        	  testSegment(curZoomLevel, curPlanID);
	          if((imgX != 0) || (imgY != 0)){
	        	  countRPLoc2(imgX, imgY);
	          }
	          colorIt(materials, watersource);
	          countRoute3(driveWay, path);
          }
          if(fpCofirmed != 0){
        	  repositionFP(curZoomLevel, fpXFixed, fpYFixed);
        	  if((imgX != 0) || (imgY != 0)){                    
	        	  recountFP(imgX, imgY);
	          }
        	  drawFP();
          }
        }
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

//------------------------------根据位置选择瓦片(放大)--------------------------------------------------
function selTileZi(x,y,zoomlevel){

      var resTile = img;
      if (zoomlevel == 1) {
        resTile = imgL2;
      }
      if (zoomlevel == 2) {
        resTile = imgL3;
      }

      return resTile;
}

//------------------------------根据位置选择瓦片(缩小)--------------------------------------------------
function selTileZo(x,y,zoomlevel){
      var resTile = null;
      if (zoomlevel == 2) {             //从2级缩小到1级
        resTile = img;
      }
      if (zoomlevel == 3) {
        resTile = imgL2;
      }
      return resTile;
}

function countRoute(segTerms){        //这个画线方法是有动画效果的画线，注意与2区分

	 console.log("进入 CountRoute 现在segTerms 是： ");
	 console.log(segTerms);
  //goto first point
  context.beginPath();
  context.strokeStyle = "red";
  context.moveTo(segTerms[0].pointX, segTerms[0].pointY);

  var counter = 1,
  inter = setInterval(function() {
      //create interval, it will
      //iterate over pointes and when counter > length
      //will destroy itself
      var point = segTerms[counter++];
      context.lineTo(point.pointX, point.pointY);
      console.log("瞄点，目标是：" +point.pointX + "  " +point.pointY);
      context.lineWidth = 5;    //线条的样式
      context.lineJoin = "round";
      context.strokeStyle = 'rgba(255,0,0,1)';
      context.stroke();
      if (counter >= segTerms.length) {
         clearInterval(inter);
      }
  }, 200);
  context.stroke();
  context.closePath();
}

//已经弃用，留着只是可能检查需要
function countRouteNew2(driveWay, path){

//	  console.log("公路点：");
//	  console.log(driveWay);
//	  console.log("小路点：");
//	  console.log(path);

	  if((driveWay != null) && (driveWay.length != 0)){

		  context.beginPath();
		  context.moveTo(driveWay[0].pointX, driveWay[0].pointY);

		  for(var i=1; i < driveWay.length; i++){
			  context.lineTo(driveWay[i].pointX, driveWay[i].pointY);
		      context.lineWidth = 5;    //线条的样式
		      context.lineJoin = "round";
		      context.strokeStyle = 'rgba(0,0,255,1)';
		      context.stroke();
		  }

	  }

	  context.beginPath();
	  context.moveTo(path[0].pointX, path[0].pointY);

	  for(var i=1; i < path.length; i++){
	    context.lineTo(path[i].pointX, path[i].pointY);
	    //console.log("描点" + "  目标是  ： " + path[i].pointX + "  " + path[i].pointY);
	      context.lineWidth = 5;    //线条的样式
	      context.lineJoin = "round";
	      context.strokeStyle = 'rgba(255,0,0,1)';
	      context.stroke();
	  }
}


//check use only函数
function getRoute(zmLev,rtID){

	fpXFixed = 689;	   
	fpYFixed = 584;
	fpCofirmed = 1;
	testSegment(zmLev, rtID);
	
}

//目前这个函数比较完整了，根据火点位置加载POI，后续可以改函数名，注意rtID是指预案ID，不改只是为了和Location对象绑定
function testSegment(zmLev, planID){

  if(fpCofirmed < 1){
	  alert("请先定位火点");
  } else {
	  
	  var req = {"zmLev":zmLev,"rtID":planID, "pointX":fpXFixed, "pointY":fpYFixed};   //这里传的是路径ID不再是getRoute里面的方案ID

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
	         if(availablePlans == null){
	            availablePlans = data.availablePlans; 
	         }
	         
	         driveWayOringin = JSON.parse(JSON.stringify(data.driveWay));
	         pathOringin = JSON.parse(JSON.stringify(data.path));
	         materialsOringin = JSON.parse(JSON.stringify(data.materials));
	         watersourceOringin = JSON.parse(JSON.stringify(data.watersource));

	         if (hasRoute == 0) {
	           colorIt(materials, watersource);
	           countRoute3(driveWay, path);
	           hasRoute = 1;
	         }

	       }

	     }
	   });
	  	  
  }
  
	

}

//火点定位
function fpPositioning(fireptX, fireptY){		
	fpX = fireptX;
	fpY = fireptY;
	fpXOrigin = fireptX;
	fpYOrigin = fireptY;
	fpXFixed = fireptX;
	fpYFixed = fireptY;
	fpCofirmed = 1;
	drawFP();	
}

function drawFP(){
	context.beginPath();
	context.arc(fpX,fpY,40,0,2*Math.PI);
	context.fillStyle="rgba(0,0,255,0.5)";	//填充颜色,默认是黑色
	context.fill();							//画实心圆
	context.closePath();
	context.drawImage(optImg,fpX-25,fpY-40,50,50);
}

function repositionFP(zmLev, fpXFixed, fpYFixed){
	var req = {"zmLev":zmLev, "pointX":fpXFixed, "pointY":fpYFixed};
	$.ajax( {
	     async : false, //这里不开异步，以防点数据赋值混乱
	     cache : false, //是否使用缓存
	     type : 'post', //请求方式,post
	     dataType : "json", //数据传输格式
	     url : "repositionFP", //请求链接
	     contentType:"application/json",
	     data:JSON.stringify(req),
	     error : function() {
	       alert('网络故障！');
	     },
	     success : function(data) {
	       if(data.msg == 1){
	    	 console.log("已重新计算火点位置！");
	    	 fpX = data.fpX;
	    	 fpY = data.fpY;
    		 fpXOrigin = data.fpX;
    		 fpYOrigin = data.fpY;			//这里只有这四个用于不同放缩级别平移的值会重新赋值，fixed值在用户点击火点定位前不会在任何情况发生改变
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

//以下4个函数皆为为子页面提供接口：获取预案ID、当前可用的预案信息，清除画布上的标绘，重新画路
function sendCurPlanID(){
	return curPlanID;
}

function sendAvPlans(){
	return availablePlans;
}

function sendHasroute(){
	return hasRoute;
}

function clearCanvas(){
	context.clearRect(0,0,canvas.width,canvas.height);
}

function drawSwitchRoutes(){
	drawImage(curTile);
    if((imgX != 0) || (imgY != 0)){
  	  countRPLoc2(imgX, imgY);
  	  recountFP(imgX, imgY);
    }
	drawFP();
    colorIt(materials, watersource);
    countRoute3(driveWay, path);
}

//临时定位资源，要修改
function getSrcLoc(){
	context.drawImage(goods,737,296,30,35);
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
