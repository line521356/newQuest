<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>填写问卷问卷信息</title>
<script src="/js/jquery-1.11.1.min.js"></script>
<script src="/js/DynDeviseInput.js"></script>

</head>
<body>


<!-- 该版本页面主要用来测试整段HTML代码复制 -->

	 <fieldset>  
        <legend>log:</legend>  
        <div>  
            <textarea id="txtMsg" style="width: 100%; height: 100px;"></textarea>  
        </div>  
    </fieldset>  
  
    <fieldset>  
        <legend>dynamicCon:</legend>  
        <div class="dynamicCon">  
            <table style="width: 100%;">  
                <tr class="temp">  
                    <td><span class="dynamicCon-Index"></span></td>  
                    <td>  
                        <input type="text" id="txtA" class="dynamicCon-autoCreateIdIndex" /></td>  
                    <td>  
                       	 问题描述<input type="text" name="isThisName" /></td>  
                    <td>  
                                                               问题备注<input type="text"/></td>
                    <td>  
                       	 单选<input type="radio"/></td>    
                    <td>
                    	多选<input type="radio"/></td>
                    <td>  
                        <a href="javascript:void(0);" class="addBtn">添加</a>  
                        <a href="javascript:void(0);" class="delBtn">删除</a>  
                    </td>  
                </tr>  
                <tr class="items">  
                    <td><span class="dynamicCon-Index"></span></td>  
                    <td>  
                        <input type="text" id="txtA" class="dynamicCon-autoCreateIdIndex" /></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <a href="javascript:void(0);" class="addBtn">添加</a>  
                        <a href="javascript:void(0);" class="delBtn">删除</a>  
                    </td>  
                </tr>  
            </table>  
        </div>  
    </fieldset>  
  
    <fieldset>  
        <legend>dynamicCon2:</legend>  
        <div class="dynamicCon2">  
            <table style="width: 100%;">  
                <tr class="temp">  
                    <td><span class="dynamicCon-Index"></span></td>  
                    <td>  
                        <input type="text" id="txtB" class="dynamicCon-autoCreateIdIndex" /></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <a href="javascript:void(0);" class="addBtn">添加</a>  
                        <a href="javascript:void(0);" class="delBtn">删除</a>  
                    </td>  
                </tr>  
                <tr class="items">  
                    <td><span class="dynamicCon-Index"></span></td>  
                    <td>  
                        <input type="text" id="txtB" class="dynamicCon-autoCreateIdIndex" /></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <input type="text"/></td>  
                    <td>  
                        <a href="javascript:void(0);" class="addBtn">添加</a>  
                        <a href="javascript:void(0);" class="delBtn">删除</a>  
                    </td>  
                </tr>  
            </table>  
        </div>  
    </fieldset>  
  
    <script type="text/javascript">  
        $(function () {  
            var $msg = $("#txtMsg"), line = 1;  
            //dynamicCon  
            $.DynamicCon({  
                beforeAddOrDel: function (type) { $msg.val($msg.val() + (line++)+"   增加或删除行之前：" + type + "\r\n"); return true; },  
                afterAddOrDel: function (type) {  
                    $msg.val($msg.val() + (line++) + "   增加或删除行之后：" + type + "\r\n");  
                    $msg.scrollTop($msg[0].scrollHeight);  
                },  
                overflowMsg: function (msg) {  
                    $msg.val($msg.val() + (line++) + "   " + msg + "\r\n");  
                    $msg.scrollTop($msg[0].scrollHeight);  
                    return false;  
                }  
            });  
            //dynamicCon2  
            $.DynamicCon({  
                container: ".dynamicCon2",  
                beforeAddOrDel: function (type) { $msg.val($msg.val() + (line++) + "   增加或删除行之前：" + type + "\r\n"); return true; },  
                afterAddOrDel: function (type) {  
                    $msg.val($msg.val() + (line++) + "   增加或删除行之后：" + type + "\r\n");  
                    $msg.scrollTop($msg[0].scrollHeight);  
                },  
                overflowMsg: function (msg) {  
                    $msg.val($msg.val() + (line++) + "   " + msg + "\r\n");  
                    $msg.scrollTop($msg[0].scrollHeight);  
                    return false;  
                }  
            });  
        });  
    </script>  


</body>
</html>