<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/28 0028
  Time: 15:02
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
            margin:10px 10px;
            border:1px solid #ddd;
            padding : 4px;
            font-size:14px;
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
                                <a rel="nofollow" href="minecrowdfunding.html"><i class="glyphicon glyphicon-user"></i> 我的众筹</a>
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
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">1. 项目及发起人信息</div>
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
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">2. 回报设置</div>
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
                                            回报设置
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column">
                                    <form id="returnform" action="/Project/saveReturnTemp.do" method="post">
                                    <table class="table table-bordered" style="text-align:center;">
                                        <thead>
                                        <tr style="background-color:#ddd;">
                                            <td>序号</td>
                                            <td>支付金额</td>
                                            <td>名额</td>
                                            <td>单笔限购</td>
                                            <td>回报内容</td>
                                            <td>回报时间</td>
                                            <td>运费</td>
                                            <td>操作</td>
                                        </tr>
                                        </thead>

                                        <tbody id="returntbody">

                                        <tr>
                                            <td    scope="row">1</td>
                                            <td>￥1.00</td>
                                            <td>无限制</td>
                                            <td>1</td>
                                            <td>1</td>
                                            <td>项目结束后的30天</td>
                                            <td>包邮</td>
                                            <td>
                                                <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                                <button type="button" class="btn btn-danger btn-xs" onclick="deletetr(this)"><i class=" glyphicon glyphicon-remove"></i></button>
                                            </td>
                                            <%--<input type="hidden" name="datas[0].supportmoney" value="1">
                                            <input type="hidden" name="datas[0].signalpurchase" value="0">
                                            <input type="hidden" name="datas[0].purchase" value="1">
                                            <input type="hidden" name="datas[0].content" value="1">
                                            <input type="hidden" name="datas[0].rtndate" value="30">
                                            <input type="hidden" name="datas[0].freight" value="0">--%>
                                            <input type="hidden" name="datas[0].supportmoney" value="111">
                                            <input type="hidden" name="datas[0].type" value="0">
                                            <input type="hidden" name="datas[0].content" value="goggoog">
                                            <input type="hidden" name="datas[0].signalpurchase" value="666">
                                            <input type="hidden" name="datas[0].purchase" value="6666">
                                            <input type="hidden" name="datas[0].rtndate" value="777">
                                            <input type="hidden" name="datas[0].freight" value="69595">
                                            <input type="hidden" name="datas[0].count" value="545">
                                            <input type="hidden" name="datas[0].invoice" value="1">
                                        </tr>


                                        </tbody>

                                    </table>
                                    </form>

                                    <button type="button" class="btn btn-primary btn-lg" onclick="addform()"><i class="glyphicon glyphicon-plus"></i> 添加回报</button>
                                    <div style="border:10px solid #f60;border-bottom-color: #eceeef;border-width: 10px;width:20px;margin-left:20px;
                                             border-left-color: rgba(221, 221, 221, 0);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                    "></div>
                                    <div class="panel panel-default" style="border-style: dashed;background-color:#eceeef">
                                        <div class="panel-body">

                                            <div class="col-md-12 column">
                                                <form class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">回报类型</label>
                                                        <div class="col-sm-10">
                                                            <label class="radio-inline">
                                                                <input type="radio" name="type" id="real" value="0"> 实物回报
                                                            </label>
                                                            <label class="radio-inline">
                                                                <input type="radio" name="type" id="virtual" value="1"> 虚拟物品回报
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">支持金额（元）</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="supportmoney" id="supportmoney" class="form-control" style="width:100px;" >
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">回报内容</label>
                                                        <div class="col-sm-10">
                                                            <textarea name="content" id="content" class="form-control" rows="5" placeholder="简单描述回报内容，不超过200字"></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">回报数量（名）</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" name="count" id="count" class="form-control" style="width:100px;display:inline" >
                                                            <label class="control-label">“0”为不限回报数量</label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-2 control-label">单笔限购</label>
                                                        <div class="col-sm-10">
                                                            <label class="radio-inline">
                                                                <input type="radio" name="signalpurchase" id="signalpurchase1" value="0"> 不限购
                                                            </label>
                                                            <label class="radio-inline">
                                                                <input type="radio" name="signalpurchase" id="signalpurchase2" value="1"> 限购
                                                            </label>
                                                            <div>
                                                            <input type="text" id="purchase" name="purchase" class="form-control" style="width:100px;display:inline" >
                                                            <label class="radio-inline">默认数量为1，且不超过上方已设置的回报数量</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">运费(元)</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" id="freight" name="freight" class="form-control" style="width:100px;display:inline" value="0" >
                                                            <label class="control-label">“0”为包邮</label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-2 control-label">发票</label>
                                                        <div class="col-sm-10">
                                                            <label class="radio-inline">
                                                                <input type="radio" name="invoice" id="invoice1" value="0"> 不可开发票
                                                            </label>
                                                            <label class="radio-inline">
                                                                <input type="radio" name="invoice" id="invoice2" value="1"> 可开发票（包括个人发票和自定义抬头发票）
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="rtndate" class="col-sm-2 control-label">回报时间</label>
                                                        <div class="col-sm-10">
                                                            <label class="radio-inline">
                                                                项目结束后
                                                            </label>
                                                            <input type="text" id="rtndate" name="rtndate" class="form-control" style="width:100px;display:inline" >
                                                            <label class="radio-inline">天，向支持者发送回报</label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="col-sm-2 control-label"></label>
                                                        <div class="col-sm-10">
                                                            <button type="button" class="btn btn-primary">确定</button>
                                                            <button type="button" class="btn btn-default">取消</button>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>


                                        </div>
                                    </div>
                                </div>

                                <div class="container">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <blockquote>
                                                <p >
                                                    <i class="glyphicon glyphicon-info-sign" style="color:#2a6496;"></i> 提示
                                                </p> <small>3个以上的回报：多些选择能提高项目的支持率。几十、几百、上千元的支持：3个不同档次的回报，能让你的项目更快成功。回报最好是项目的衍生品：<br>与项目内容有关的回报更能吸引到大家的支持。</small>
                                            </blockquote>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                    <div class="panel-footer" style="text-align:center;">
                        <button type="button" class="btn  btn-default btn-lg" onclick="window.location.href='start-step-1.html'">上一步</button>
                        <button type="button" class="btn  btn-warning btn-lg" onclick="onform()">下一步</button>
                        <a class="btn" > 预览 </a>
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
                        <a rel="nofollow" href="http://www. zc.com">关于我们</a> | <a rel="nofollow" href="http://www. zc.com">服务条款</a> | <a rel="nofollow" href="http://www. zc.com">免责声明</a> | <a rel="nofollow" href="http://www. zc.com">网站地图</a> | <a rel="nofollow" href="http://www.zc.com">联系我们</a>
                    </div>
                    <div class="copyRight">
                        Copyright ?2017-2017 zc.com 版权所有
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
<script src="../jquery/layer/layer.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
    function onform() {
        //var type = $("input[name='rd']:checked").val();
        var form = $("#returnform");
        form.submit();
    }
 /*   <td>序号</td>
    <td>支付金额</td>
    <td>名额</td>
    <td>单笔限购</td>
    <td>回报内容</td>
    <td>回报时间</td>
    <td>运费</td>
    <td>操作</td>*/
    returncount = 0;
    function addform() {
        var supportmoney = $("#supportmoney").val();//支持金额
        var type = $('input[name="type"]:checked').val();//回报类型0实物，1虚拟
        var content = $("#content").val();//回报内容
        var signalpurchase = $('input[name="signalpurchase"]:checked').val();//0限购，1不限
        var purchase = $("#purchase").val();//限购数量

        var rtndate = $("#rtndate").val();//回报时间
        var freight = $("#freight").val();//运费,0为包邮
        var freight1;
        if(freight==0){
            freight1="包邮";
        }else {freight1=freight;}
        var count = $("#count").val();//回报数量，0为不限
        var signalpurchase1;
        if(count==0){
            signalpurchase1="不限购";
        }else{signalpurchase1=count;}
        var invoice = $('input[name="invoice"]:checked').val();//发票，0不开，1开
        if(type==""||supportmoney==""||signalpurchase==""||content==""||purchase==""||rtndate==""||
            freight==""||count==""||invoice==""){
            layer.msg("不能为空，每项数据都需要填写！",{time:1500, icon:5, shift:6});
            return;
        }

        var returnContent = "" ;
            returnContent+="<tr>";
            returnContent+="<td    scope='row'>"+(returncount+1)+"</td>";
            returnContent+="<td>￥"+supportmoney+"</td>";
            returnContent+="<td>"+signalpurchase1+"</td>";
            returnContent+="<td>"+purchase+"</td>";
            returnContent+="<td>"+content+"</td>";
            returnContent+="<td>项目结束后的"+rtndate+"天</td>";
            returnContent+="<td>"+freight1+"</td>";
            returnContent+="<td>";
            returnContent+="<button type='button' class='btn btn-primary btn-xs'><i class=' glyphicon glyphicon-pencil'></i></button>";
            returnContent+="<button type='button' class='btn btn-danger btn-xs' onclick='deletetr(this)'><i class=' glyphicon glyphicon-remove'></i></button>";
            returnContent+="</td>"
            returnContent+="<td><input type='hidden' name='datas["+returncount+"].supportmoney' value='"+supportmoney+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].type' value='"+type+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].content' value='"+content+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].signalpurchase' value='"+signalpurchase+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].purchase' value='"+purchase+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].rtndate' value='"+rtndate+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].freight' value='"+freight+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].count' value='"+count+"'>"
        returnContent+="<input type='hidden' name='datas["+returncount+"].invoice' value='"+invoice+"'>"
        returnContent+="</td></tr>"
        $("#returntbody").append(returnContent);
            returncount++;
    }

    function deletetr(ob) {
       var tr =  $(ob).parent().parent();
       tr.remove();
    }

</script>
</body>
</html>