<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<!-- 公司的选择页面 -->
<title>公司选择</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link href="css/h-ui/H-ui.login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.min.js"></script>

<style type="text/css">


#div1 {
	margin-top: 10%;
	margin-left: 28%;
}

ul {
	margin-left: 30%;
	font-size: 20;
	list-style: none;
}

li {
	line-height: 80px;
}

a {
	text-decoration: none;
}

.choice {
	margin-top: 5%;
	margin-left: 25%;
	font-size: 20px;
	margin-left: 25%;
}
</style>
</head>

<body class="body">
	<div class="header">福建仲能网络科技有限公司慧为软件发布管理系统</div>
	<div class="choice">请选择企业：</div>
	<ul id="ul">
	</ul>

	<script type="text/javascript">
		$(function() {
			var mun = '${Uid}';
			
			if (mun == "") {
				alert("为空");
				return;
			}
			$.post("getCompany", {
				"personId" : mun
			}, function(data) {

				var result = data.result;
				if (result.length == 1) {

					location = "GoIndexPage?Emid=" + result[0].Emids;
				}
				for (var i = 0; i < result.length; i++) {

					$("#ul").append(
							"<li><a onclick=changeLocation(this) id='"
									+ result[i].comid + "'>"
									+ result[i].comname + "</a></li>");
									
				}
			}

			);

		});

		function changeLocation(a) {
			
			location = "GoIndexPage?comid=" + a.id;
		}
	</script>
</body>
</html>
