<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>程序包管理</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.heart {
	margin: 1px auto;
	background-color: #E7E7E7;
	height: 195px;
	width: 550px;
}

.heart1 {
	margin: 10px auto;
	background-color: #E7E7E7;
	width: 550px;
}

thead {
	background-color: #CCCCCC;
}

.table th, .table td {
	text-align: center;
}
</style>
</head>

<body>
	<div><jsp:include page="head.jsp" /></div>
	<div>
		<div class="heart">
			<div style="margin-left: 10px; padding-top: 10px;">
				<div>
					<span>程序包名称：&nbsp;&nbsp;</span><input type="text"
						style="width: 400px;">

				</div>
				<br>

				<div>
					<span>兼容平台：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text"
						style="width: 400px;">

				</div>
				<br>

				<div>
					<span>程序包功能：&nbsp;</span>
					<textarea style="vertical-align: top;" rows="3" cols="76"></textarea>

				</div>
				<br>

				<div>
					<input type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交"
						style="width: 100px">

				</div>


			</div>
		</div>
		<div class="heart1">
			<table class="table table-bordered table-hover table-responsive">
				<thead>
					<tr>
						<th>程序包名称</th>
						<th>兼容平台</th>
						<th>功能简述</th>
						<th>发布新版</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>慧为安监通_android</td>
						<td>android</td>
						<td>安全检查、设施设备</td>
						<td><a>进入</a></td>
						
					</tr>
					<tr>
						<td>慧为安监通_android</td>
						<td>android</td>
						<td>安全检查、设施设备</td>
						<td><a>进入</a></td>
					</tr>
					<tr>
						<td>慧为安监通_android</td>
						<td>android</td>
						<td>安全检查、设施设备</td>
						<td><a>进入</a></td>
					</tr>
					<tr>
						<td>慧为安监通_android</td>
						<td>android</td>
						<td>安全检查、设施设备</td>
						<td><a>进入</a></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						
					</tr>
					<tr>
						
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
					
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div style="margin: auto; width: 550px;">
			<span
				style="float: right;">第1页/共3页&nbsp;&nbsp;第1页|下一页|上一页|最末页</span>
		</div>

	</div>

</body>
</html>
