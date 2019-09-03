<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/27 0027
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="navbar-wrapper">
    <div class="container">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.html" style="font-size:32px;">众筹网-创意产品众筹平台</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse" style="float:right;">
                    <c:if test="${loginedUser!=null}">
                        <ul class="nav navbar-nav navbar-right">
                            <li style="padding-top:8px;">
                                <div class="btn-group">
                                    <button id="userText" type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                                        <i class="glyphicon glyphicon-user"></i>${loginedUser.username} <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li><a href="/member/member.jsp"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                                        <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                                        <li class="divider"></li>
                                        <li><a href="index.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </c:if>
                </div>
            </div>
        </nav>

    </div>
</div>

<div class="container theme-showcase" role="main">
    <div class="page-header">
        <h1>实名认证 - 申请</h1>
    </div>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" ><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation" ><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation" ><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation" class="active"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form role="form" id="validateform" action="/member/SaveandDoValidate.do" method="post" style="margin-top:20px;">
        <input type="hidden" name="id" value="${realnameMember.id}">
        <input type="hidden" name="username" value="${realnameMember.username}">
        <input type="hidden" name="email" value="${realnameMember.email}">
        <div class="form-group">
            <label for="validatecode">验证码</label>
            <input type="text" class="form-control" name="validatecode" id="validateCode" placeholder="请输入你邮箱中接收到的验证码">
        </div>
        <button type="button" onclick="javascript:;" class="btn btn-primary">重新发送验证码</button>
        <button type="button" onclick="formsubmit()"  class="btn btn-success">申请完成</button>
    </form>
    <hr>
</div> <!-- /container -->
<div class="container" style="margin-top:20px;">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="footer">
                <div class="footerNav">
                    <a rel="nofollow" href="http://www. zcw.com">关于我们</a> | <a rel="nofollow" href="http://www. zcw.com">服务条款</a> | <a rel="nofollow" href="http://www. zcw.com">免责声明</a> | <a rel="nofollow" href="http://www. zcw.com">网站地图</a> | <a rel="nofollow" href="http://www. zcw.com">联系我们</a>
                </div>
                <div class="copyRight">
                    Copyright ?2017-2017  zc.com 版权所有
                </div>
            </div>

        </div>
    </div>
</div>
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../script/docs.min.js"></script>
<script src="../jquery/layer/layer.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    });

    function formsubmit() {
        var validateCode = $("#validateCode");
        if(validateCode.val()==""||validateCode.val().length!=6){
            layer.msg("请输入6位验证码！",{time:2000, icon:5, shift:6});
            validateCode.focus();
            return ;
        }
        var form = $("#validateform");
        form.submit();
    }
</script>
</body>
</html>
