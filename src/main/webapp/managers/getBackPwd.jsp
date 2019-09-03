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
    <form class="form-signin"  id="userForm" role="form" action="/updataMemberPwd.do" method="post">
        <c:if test="${username != null}">
            <div class="alert alert-info" role="alert">${username}， 请输入您新的密码
            </div>
        </c:if>
        <input type="hidden" id="memberid" name="id" value="${memberid}"/>
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 重设密码</h2>

        <div class="form-group has-success has-feedback">
            <input type="password"  name="userpswd" class="form-control" id="userpswd" placeholder="请输入新的密码" style="margin-top:10px;">

        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" onblur="" name="reuserpswd" class="form-control" id="reuserpswd" placeholder="请输入新的密码" style="margin-top:10px;">

        </div>
        <div class="checkbox">


            <label style="float:left">
                <a href="/managers/login.html">我要登录</a>
            </label>
            <label style="float:right">
                <a href="/managers/reg.html">我要注册</a>
            </label>
        </div>
        <br>
        <a class="btn btn-lg btn-success btn-block" onclick="fromSubmit()">确定</a>
       <%-- <input type="submit" class="btn btn-lg btn-success btn-block" value="确定"/>--%>
      <%--<input type="submit" class="btn btn-lg btn-success btn-block" value="登录"/>--%>
    </form>
</div>
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../jquery/layer/layer.js"/>
<script type="text/javascript">
    function pwd() {
            alert(1111111111);
    }
</script>
<script type="text/javascript">
    function fromSubmit(){
        var userpswd = $("#userpswd");
        var reuserpswd = $("#reuserpswd");
        if(userpswd.val()==""){
            layer.msg("密码不能为空！",{time:1000,icon:5,shift:6},function () {
                userpswd.focus();
            })
            return;
        }
        if(reuserpswd.val()==""){
            layer.msg("密码不能为空！",{time:1000,icon:5,shift:6},function () {
                reuserpswd.focus();
            })
            return;
        }
        if(reuserpswd.val()!=userpswd.val()){
            layer.msg("两次密码不相同！",{time:1000,icon:5,shift:6},function () {
                reuserpswd.focus();
            })
            return;
        }
        var id = $("#memberid");
        $.ajax({
            url:"/member/updataMemberPwd.do",
            type:"POST",
            dataType:"json",
            data:{
                "id":id.val(),
                "userpswd":userpswd.val()
            },
            beforeSend: function () {
                loadingIndex = layer.msg('处理中',{icon:16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("提交成功！",{time:4000,icon:6,shift:6});
                    GoNext(4,"/managers/login.html");
                }else{
                    layer.msg("提交失败",{time:2000,icon:5,shift:6});
                }
            },
            error:function () {
                layer.msg("修改失败",{time:2000,icon:5,shift:6});
            }
        });
    }

    function GoNext(seconds,url){
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
