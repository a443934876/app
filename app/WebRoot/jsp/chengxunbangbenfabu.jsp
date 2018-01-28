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

<title>增加程序包</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link href="css/h-ui/H-ui.login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<style type="text/css">
.heart {
	margin: 1px auto;
	background-color: #E7E7E7;
	height: 410px;
	width: 550px;
}
</style>

</head>

<body class="body">
	<div><jsp:include page="head.jsp" /></div>
	<div class="heart">
		<div style="margin-left: 10px;padding-top: 10px;">
			<div>
				<span>程序包名称：</span> <span>xxx</span>
			</div>
			<br>
			<div>
				<span>程序版本编号：</span> <input type="text" style="width:335px;" />
			</div>
			<br>
			<div>
				<span>更新修改功能：</span>
				<textarea style="vertical-align: top;" rows="5" cols="65"></textarea>
			</div>
			<br>
			<div>
				<span>预备发布日期：</span> <input type="text" />
			</div>
			<br>
			<div>
				<span>是否强制升级：</span> <input type="checkbox" />
			</div>
			<br>
			<div style="float:left">
				<span>扫描上传：</span>
			</div>
			<div>
				<input type="file" style="float:left" /><input type="submit"
					value="上传">
			</div>
			<br> <br>
			<div>
				<input type="submit" value="提交" style="margin-left: 30%">
			</div>
		</div>
	</div>





</body>
</html>
