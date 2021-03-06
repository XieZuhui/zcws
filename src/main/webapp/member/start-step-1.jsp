<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/27 0027
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
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
        #topcontrol {
            color: #fff;
            z-index: 99;
            width: 30px;
            height: 30px;
            font-size: 20px;
            background: #222;
            position: relative;
            right: 14px !important;
            bottom: 11px !important;
            border-radius: 3px !important;
        }

        #topcontrol:after {
            /*top: -2px;*/
            left: 8.5px;
            content: "\f106";
            position: absolute;
            text-align: center;
            font-family: FontAwesome;
        }

        #topcontrol:hover {
            color: #fff;
            background: #18ba9b;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }

        .label-type, .label-status, .label-order {
            background-color: #fff;
            color: #f60;
            padding : 5px;
            border: 1px #f60 solid;
        }
        #typeList  :not(:first-child) {
            margin-top:20px;
        }
        .label-txt {
            margin:5px 5px;
            border:1px solid #ddd;
            padding : 2px;
            font-size:14px;
            border-radius: 5px;
            color: white;
            background-color: #666;
        }
        .panel {
            border-radius:0;
        }

        .progress-bar-default {
            background-color: #ddd;
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
                                        <li><a href="member.jsp"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
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

    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <nav class="navbar navbar-default" role="navigation">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li>
                                <a rel="nofollow" href="index.html"><i class="glyphicon glyphicon-home"></i> 众筹首页</a>
                            </li>
                            <li >
                                <a rel="nofollow" href="projects.html"><i class="glyphicon glyphicon-th-large"></i> 项目总览</a>
                            </li>
                            <li class="active">
                                <a rel="nofollow" href="javascript:;"><i class="glyphicon glyphicon-edit"></i> 发起项目</a>
                            </li>
                            <li>
                                <a rel="nofollow" href="minezc.jsp"><i class="glyphicon glyphicon-user"></i> 我的众筹</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div class="panel panel-default" >
                    <div class="panel-heading" style="text-align:center;">
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;    position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">1. 项目及发起人信息</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(92, 184, 92, 1);
                                             border-top-color: rgba(92, 184, 92, 0);
                                             border-bottom-color: rgba(92, 184, 92, 0);
                                             border-right-color: rgba(92, 184, 92, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">2. 回报设置</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">3. 确认信息</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">4. 完成</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            项目及发起人信息
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column">
                                    <div class="page-header" style="    border-bottom-style: dashed;">
                                        <h3>
                                            项目信息
                                        </h3>
                                    </div>
                                    <form class="form-horizontal" id="projectForm" action="">
                                        <input type="hidden" id="tagIds" name="tagIds"/>
                                        <div class="form-group">
                                            <label   class="col-sm-2 control-label">分类信息</label>
                                            <div class="col-sm-10" id="prjType">

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label  class="col-sm-2 control-label">标签</label>
                                            <div class="col-sm-10">
                                                <ul style="list-style: none;padding-left: 0;" id="prjTag" >

                                                </ul>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">项目名称</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="prjname" name="prjname" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">一句话简介</label>
                                            <div class="col-sm-10">
                                                <textarea id="remark" name="remark" class="form-control" rows="5"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">筹资金额（元）</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="money" name="money" class="form-control" style="width:100px;" >
                                                <label class="control-label">筹资金额不能低于100元,不能高于1000000000元</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">筹资天数（天）</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="day" name="day" class="form-control" style="width:100px;" >
                                                <label class="control-label">一般10-90天，建议30天</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">项目头图</label>
                                            <div class="col-sm-10">
                                                <input type="file" name="iconpath" class="btn btn-primary btn-lg active">上传图片</input>
                                                <label class="control-label">图片上无文字,支持jpg、jpeg、png、gif格式，大小不超过2M，建议尺寸：740*457px</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">项目详情</label>
                                            <div class="col-sm-10">
                                                <input type="file" name="imgpath" class="btn btn-primary btn-lg active">上传图片</input>
                                                <label class="control-label">支持jpg、jpeg、png、gif格式，大小不超过2M，建议尺寸：宽740px</label>
                                            </div>
                                        </div>
                                    </form>


                                    <div class="page-header" style="    border-bottom-style: dashed;">
                                        <h3>
                                            发起人信息
                                        </h3>
                                    </div>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">自我介绍</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="introduce" name="introduce" class="form-control" placeholder="一句话自我介绍，不超过40字">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">详细自我介绍</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" id="particulars" name="particulars" rows="5" placeholder="向支持者详细介绍你自己或你的团队及项目背景，让支持者在最短时间内了解你，不超过160字"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">联系电话</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="contactTel" name="contactTel" class="form-control" placeholder="此信息不会显示在项目页面">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">客服电话</label>
                                            <div class="col-sm-10">
                                                <input type="text" id="customerTel" name="customerTel" class="form-control" placeholder="此信息显示在项目页面">
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer" style="text-align:center;">
                        <button type="button" class="btn  btn-warning btn-lg" onclick="fromSubmit()">下一步</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="container" style="margin-top:20px;">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div id="footer">
                    <div class="footerNav">
                        <a rel="nofollow" href="http://www.zc.com">关于我们</a> | <a rel="nofollow" href="http://www.zc.com">服务条款</a> | <a rel="nofollow" href="http://www.zc.com">免责声明</a> | <a rel="nofollow" href="http://www.zc.com">网站地图</a> | <a rel="nofollow" href="http://zc.com">联系我们</a>
                    </div>
                    <div class="copyRight">
                        Copyright ?2017-2017layoutit.cn 版权所有
                    </div>
                </div>

            </div>
        </div>
    </div>

</div> <!-- /container -->
<script src="../jquery/jquery-2.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.min.js"></script>
<script src="../script/docs.min.js"></script>
<script src="../script/back-to-top.js"></script>
<script src="../jquery/jquery.form.js"></script>
<script src="../jquery/layer/layer.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })

    window.onload = function () {
        $.ajax({
            type: "POST",
            url: "/Project/loadTypeData.do",
            data: {},
            dataType:"json",
            success: function(types){

                console.log(types);
                $.each(types, function(i,item){
                    $("#prjType").append('<label class="radio-inline"> <input type="radio" name="typeid" '
                        +i+'" value="'+item.id+'">'+item.name+'</label>');
                });
            }
        });

        $.ajax({
            type: "POST",
            url: "/Project/loadTagData.do",
            data: {},
            dataType:"json",
            success: function(tagData){
                console.log(tagData);
                var tagNames = new Array();
                var index=0;
                $.each(tagData, function(i,item){
                    if(item.pid==0){
                        tagNames[index] = '<li style="margin:10px 0">'+item.name;
                        index++;
                    }
                });
                var id=0;
                var pid=0;
                var taglbl='';
                index=0;
                $.each(tagData, function(i,item){
                    if(item.pid != 0){
                        taglbl+='<input type="button" class="label-txt" onclick="selectTag(this,'+item.id+')" value="'+item.name+'"></input>';
                    }else if(i!=0 && item.pid == 0){
                        $("#prjTag").append(tagNames[index]+''+taglbl+'</li>');
                        index++;
                        taglbl='';//重新清空
                    }
                });
//添加最后一项
                $("#prjTag").append(tagNames[index]+''+taglbl+'</li>');
            }
        });

    }

    var tagId="";//标签id,多个之间用逗号分隔
    //标签选择
    function selectTag(btnObj,id){
        btnObj.style.backgroundColor ="#f60";
        tagId += id+",";
        //alert(tagId);
        console.log(tagId);
        $("#tagIds").val(tagId);
    }


    function fromSubmit(){
        var loadingIndex = -1;
        $("#projectForm").ajaxSubmit({
            type: 'post',
            url: '/Project/savaProjectTemp.do',
            dataType:"json",
            data:{
                "typeid":$("input[name='typeid']:checked").val(),
                "tagIds":$("#tagIds").val(),
                "prjname":$("#prjname").val(),
                "remark":$("#remark").val(),
                "money":$("#money").val(),
                "day":$("#day").val(),
                "introduce":$("#introduce").val(),
                "particulars":$("#particulars").val(),
                "contactTel":$("#contactTel").val(),
                "customerTel":$("#customerTel").val()
            },
            beforeSubmit : function() {
                loadingIndex = layer.load(2, {time: 10*1000});
            },
            success : function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    layer.msg("项目信息保存成功", {time:1000, icon:6}, function(){
                        window.location.href = "start-step-2.jsp";
                    });
                } else {
                    layer.msg("项目信息保存失败", {time:1000, icon:5, shift:6});
                }
            }
        });
    }
</script>
</body>
</html>
