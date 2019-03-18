<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

<title>活动中心</title>
</head>

<body>
	
	<div id="allActsDisplay"></div>
	
	
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/react.js"></script>
	<script type="text/javascript" src="/js/react-dom.js"></script>
	<script type="text/javascript" src="/js/browser.min.js"></script>
	<script type="text/babel">

   	var actList = '';
    var activity = '';      //在这里定义

	function Activity(props){
		console.log("Arrive !" + props.value);
        return <li>ActName is  {props.value}  ,  ActIntro is {props.intro} </li>;
    }

    function ActivityList(props){

       $.get(props.source,function(result){        //后台获取活动列表

          actList = result;

          console.log(" 已获取活动列表 ！  " + actList);

          activity = actList.map((actItem) =>

            <Activity key = {actItem.actId.toString()} value = {actItem.actName} intro = {actItem.actIntro} />

          );

		  console.log("循环完毕" + activity[0].props.value);   //可正常输出


       }.bind(this));

		 console.log("outside ajax" + activity);  
		 console.log("outside ajax" + activity[0].props.value);  //提示 activity[0] is undefined

       return (
         <ul>
             {activity}
         </ul>
       );


    }


    ReactDOM.render(
      <ActivityList source="${pageContext.request.contextPath }/act/getAllActs" actList={actList} />,
      document.getElementById('allActsDisplay')
    );

    </script>
</body>
</html>