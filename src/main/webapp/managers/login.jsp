<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/15 0015
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
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
    <form class="form-signin"  id="userForm" role="form" action="/login.do" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>

        <div class="form-group has-success has-feedback">
            <input type="text" name="loginacct" class="form-control" id="loginacct" placeholder="请输入登录账号" autofocus>
            <span id="nerror" class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" name="userpswd" class="form-control" id="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
            <span id="perror" style="font-size:22px" class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option value="member">会员</option>
                <option value="user">管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
         <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
      <%--  <input type="submit" class="btn btn-lg btn-success btn-block" value="登录"/>--%>
    </form>
</div>
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script>
    function dologin() {
       var loginname = $("#loginacct");
       if(loginname.val() == ""){
           $("#nerror").html("不能为空");
           //alert("j2222221");
           return;
       }
    }
</script>
</body>
</html>
