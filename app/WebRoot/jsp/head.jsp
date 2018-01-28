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
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet"
	href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="css/common/common.css" />
<link rel="stylesheet" href="css/common/sapar.css" />
<link rel="stylesheet" href="css/common/index_inner.css" />
<link rel="stylesheet" href="css/h-ui/H-ui.login.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
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

ul a {
	display: block;
	text-decoration: none;
	width: 100px;
	height: 50px;
	text-align: center;
	line-height: 50px;
	color: #C9E1F3;
	background-color: #4399D8;
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
					<li><a href="jsp/index.jsp">退出系统</a></li>
				</ul></li>
			<li class="drop-down"><a href="jsp/chengxubaoguanli.jsp">程序包管理</a>
				<ul class="drop-down-content">
					<li><a href="jsp/chengxunbangbenfabu.jsp">增加程序包</a></li>
				</ul></li>
			<li class="drop-down"><a href="jsp/index.jsp">版本控制</a>
				<ul class="drop-down-content">
					<li><a href="jsp/banbechaxun.jsp">版本查询</a></li>
				</ul></li>
			<li class="drop-down"><a href="jsp/index.jsp">帮助</a>
				<ul class="drop-down-content">
					<li><a href="jsp/index.jsp">版权说明</a></li>
					<li><a href="jsp/index.jsp">使用帮助</a></li>
				</ul></li>
		</ul>
	</div>
</body>
</html>

