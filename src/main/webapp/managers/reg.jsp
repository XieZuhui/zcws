<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/8 0008
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">众筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form class="form-signin" id="userFrom" action="${pageContext.request.contextPath}/reg.do" role="form" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" name="loginacct" class="form-control" id="inputSuccess4" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" name="username" class="form-control" id="inputSuccess4" placeholder="请输入用户名" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" name="userpswd" class="form-control" id="inputSuccess4" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" name="reuserpswd" class="form-control" id="inputSuccess4" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" name="email" class="form-control" id="inputSuccess4" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="login.jsp">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="fromSubmit()" href="javascript:void(0)" > 注册</a>
    </form>
</div>
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function fromSubmit(){
        var formObj=document.getElementById("userFrom");
        formObj.submit();//手动提交表单
    }
</script>
</body>
</html>