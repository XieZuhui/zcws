function fromSubmit(){
    var userpswd = $("#userpswd").val();
    var reuserpswd = $("#reuserpswd").val();
    if(userpswd == ""||reuserpswd==""){
        layer.msg("密码不能为空！",{time:1500,icon:5,shift:6});
        return;
    }
    if(reuserpswd!=userpswd){
        layer.msg("两次密码不相同！",{time:1500,icon:5,shift:6});
        return;
    }
    var id = $("#memberid");
    $.ajax({
        url:"/updataMemberPwd.do",
        type:"POST",
        dataType:"json",
        data:{
            "id":id,
            "userpswd":userpswd
        },
        beforeSend: function () {
            loadingIndex = layer.msg('处理中',{icon:16});
        },
        success:function (result) {
            layer.close(loadingIndex);
            if(result.success){
                layer.msg("恭喜您密码修改成功",{time:4000,icon:6,shift:6});
                GoNext(4,"/mamagers/login.html");
            }else{
                layer.msg("修改密码失败了！",{time:2000,icon:5,shift:6});
            }
        },
        error:function () {
            layer.msg("账号名不存在，请重新输入",{time:2000,icon:5,shift:6});
        }
    });

}

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