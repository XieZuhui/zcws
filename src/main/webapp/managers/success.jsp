<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/25 0025
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inner navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">众筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <h2 id="msg" class="form-signin-heading">${msg},<span id="NextTo">5</span>秒后自动跳转</h2>
    <input type="hidden" id="isSuccess" value="${isSuccess}"/>
</div>
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../jquery/layer/layer.js"></script>
<script>
    $(function () {
        var isSuccess = $("#isSuccess").val();
        if(isSuccess=="success"){
            GoNext(5,"/managers/login.html");
        }else {
            GoNext(5,"/index.html");
        }
    });

    function GoNext(seconds,url){
        var next = document.getElementById('NextTo');
        next.innerHTML=seconds;
        if(--seconds>0){
            setTimeout("GoNext("+seconds+",'"+url+"')",1000);
        }
        else{
            location.href=url;
        }
    }
</script>
</body>
</html>
