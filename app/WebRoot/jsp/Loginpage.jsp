<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>登录页面</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link href="css/h-ui/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/style.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/iconfont.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script language="JavaScript">
	if (window != top)
		top.location.href = location.href;
</script>
<style type="text/css">
#div1 {
	margin-left: 28%;
}

.loginWraper {
	position: absolute;
	width: 100%;
	left: 0;
	top: 0;
	bottom: 0;
	right: 0;
	z-index: 1;
}

.loginBox {
	position: absolute;
	width: 617px;
	height: 330px;
	left: 50%;
	top: 50%;
	margin-left: -309px;
	margin-top: -184px;
	padding-top: 38px
}

@media ( max-width :617px) {
	.loginbox {
		width: 100%;
		position: static;
		margin-top: 0;
		margin-left: 0;
		background-color: red;
	}
}

.loginBox .row {
	margin-top: 20px;
}

.loginBox .row .form-label .Hui-iconfont {
	font-size: 24px
}

.loginBox .input-text {
	width: 360px
}

@media ( max-width :617px) {
	.loginBox .input-text {
		width: 80%
	}
}

</style>
</head>

<body style="background:#4FADEA">

	<div id="div1" style="width: 200dp; height: 200dp">
		<h1>福建仲能网络科技有限公司慧为软件发布管理系统</h1>
	</div>

	<div class="loginWraper">
		<div id="loginform" class="loginBox">
			<form class="form form-horizontal">

				<div class="row cl">
					<label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
					<div class="formControls col-xs-8">
						<input id="text1" type="text" placeholder="请输入账号"
							class="input-text size-L" >
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
					<div class="formControls col-xs-8">
						<input id="text2" type="password" placeholder="请输入密码"
							class="input-text size-L">
					</div>
				</div>


				<div class="row cl">
					<div class="formControls col-xs-8 col-xs-offset-3">
						<input type="button" class="btn btn-success radius size-L"
							value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;" onclick="clicks()"
							id="btn" />

					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="footer" style="color: black;">福建省仲能网络科技有限公司Copy All Rigt 2017年12月</div>
	<script type="text/javascript">
		var reg1 = /^[a-zA-Z]\w*$/i;//由字符和数字组成并且由字符开头

		
		
		function clicks() {
			if ($("#text1").val() == "") {
				alert("用户名不能为空");
				return;
			}else if ($("#text2").val() == "") {
				alert("密码不能为空");
				return;

			} else {
				/*当都不为空时发送请求 Ret:-1说明为何没有查到相关用户信息。0-查询到一条匹配的信息，
				1-用户名不存在2-手机号码不存在3-微信openid不存在4-密码不正确5-用户昵称电子邮件手机号码格式不正
				 (如用户昵称全为数字,用户昵称小于六位,电子邮件格式不正确,手机号码格式不正确等)，6-微信公众号未绑定OA */
				 //"?time"+new Date()
				
				$.post("login", {
					"nike" : $("#text1").val(),
					"pwd" : $("#text2").val(),
					"code" : $("#text3").val()
				}, function(data) {

					if (data.result == "success") {
						/* alert("登录成功"); */
						location = "jsp/MoreComs.jsp";
					} else if (data.result == 'lose') {
						alert("登陆失败,请检查账号和密码是否有误");
					} else if (data.result == "losepwd") {
						/* alert("登录成功"); */
						alert("密码输入错误");
						$("#text2").val("");
					}
				});
			}

		}

		function authCode(image) {

			image.src = "imgCode?date=" + new Date().getTime();

		}
	</script>

</body>
</html>