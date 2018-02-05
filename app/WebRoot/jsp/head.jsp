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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet"
	href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link href="css/h-ui/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/style.css" rel="stylesheet" type="text/css" />
<link href="css/h-ui/iconfont.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="js/bootstrap-table.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.base64.js"></script>
<script type="text/javascript"
	src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-table.js"></script>
<script type="text/javascript" src="js/bootstrap-table-export.js"></script>
<style type="text/css">
.div1 {
	margin-top: 2%;
	width: 100%;
	height: 50px;
	background-color: #4399D8;
}

.nav {
	margin-left: 30%;
}

.nav>li {
	float: left;
}

.nav a {
	display: block;
	text-decoration: none;
	text-align: center;
	line-height: 50px;
	color: #C9E1F3;
	width: 100px;
	height: 50px;
	background-color: #4399D8;
	height: 50px;
}

.drop-down-content {
	padding: 0;
	display: none;
	position: absolute;
}

h3 {
	font-size: 30px;
	clear: both;
}

.drop-down-content li:hover a {
	background-color: #C9E1F3;
}

.nav .drop-down:hover .drop-down-content {
	display: block;
}
</style>
<title></title>
</head>

<body class="body">
	<div class="header">福建仲能网络科技有限公司慧为软件发布管理系统</div>
	<div class="div1">
		<ul class="nav">
			<li class="drop-down"><a href="jsp/index.jsp">首页</a>
				<ul class="drop-down-content">
					<li><a href="jsp/index.jsp">返回首页</a></li>
					<li><a onclick="exit()" href="jsp/Loginpage.jsp">退出系统</a></li>
				</ul></li>
			<li class="drop-down"><a href="jsp/chengxubaoguanli.jsp">程序包管理</a>
				<ul class="drop-down-content">
					<li><a href="jsp/chengxunbangbenfabu.jsp">增加程序包</a></li>
				</ul></li>
			<li class="drop-down"><a>版本控制</a>
				<ul class="drop-down-content">
					<li><a href="jsp/banbechaxun.jsp">版本查询</a></li>
				</ul></li>
			<li class="drop-down"><a>帮助</a>
				<ul class="drop-down-content">
					<li><a href="jsp/CopyRight.jsp">版权说明</a></li>
					<li><a href="jsp/FileUpload.jsp">测试</a></li>
				</ul></li>
		</ul>
	</div>
	<script type="text/javascript">
		function exit() {
			$.post("exit", function(data) {
				
			});
		}
	</script>
</body>
</html>

