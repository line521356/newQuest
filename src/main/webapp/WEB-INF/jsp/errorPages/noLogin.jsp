<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>  
<html>  
<head>   
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>请登录</title>  
    <style>  
        body{font-size: 14px;font-family: 'helvetica neue',tahoma,arial,'hiragino sans gb','microsoft yahei','Simsun',sans-serif; background-color:#fff; color:#808080;}  
        .wrap{margin:200px auto;width:510px;}  
        td{text-align:left; padding:2px 10px;}  
        td.header{font-size:22px; padding-bottom:10px; color:#000;}  
        td.check-info{padding-top:20px;}  
        a{color:#328ce5; text-decoration:none;}  
        a:hover{text-decoration:underline;}  
    </style>  
</head>  
<body>  
    <div class="wrap">  
        <table>  
            <tr>  
                <td rowspan="5" style=""><img src="https://ws1.sinaimg.cn/large/a15b4afegy1fhsfdznep4j2020020web.jpg" alt="又一个极简的错误页面"></td>  
                <td class="header">很抱歉！您无权限查看此页面</td>  
            </tr>  
            <tr><td>原因一：您还未登陆</td></tr>  
            <tr><td>原因二：您所属的用户组无权限查看此页面</td></tr>  
            <tr><td>如果刷新页面没能解决问题，您可以尝试<a href="http://localhost:8088/Questionnaire/">重新登陆</a></td></tr>  
            <tr><td class="check-info">或者，您也可以<a href="https://mkblog.cn/">联系系统管理员</a></td></tr>  
        </table>  
    </div>  
</body>  
</html> 