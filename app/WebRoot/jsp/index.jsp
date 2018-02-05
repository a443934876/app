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
* {
	border: 0px solid transparent !important;
}

.box {
	width: 500px;
	margin-left: 32%;
	margin-top: 50px;
	font-size: 15px;
}

</style>
<script type="text/javascript" src="js/index_inner.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var comid = ${comid};
				$.post("getNewPackageVersion", {
					"comid" : comid
				}, function(data) {
					var result = data.result;
					for (var i = 0; i < result.length; i++) {
						var tr = $("<tr><th>" + result[i].proname + "</th><th>"
								+ result[i].pubdate + "</th><tr>");
						$("#tbody").append(tr);

					}
				});

			});
</script>
<title>企业系统</title>
</head>

<body class="body">
	<div><jsp:include page="head.jsp" /></div>
	<div class="box">
		<table class="table">
			<thead>
				<tr>
					<th>新版本发布信息:</th>
				</tr>
				<tr>
					<th>程序包名称</th>
					<th>程序包发布日期</th>
				</tr>
			</thead>
			<tbody id="tbody">
			</tbody>
		</table>

	</div>
</body>

</html>

