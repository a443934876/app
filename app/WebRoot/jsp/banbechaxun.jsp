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
<title>版本查询</title>
<style type="text/css">
.heart {
	margin: 1px auto;
	background-color: #E7E7E7;
	height: 120px;
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
	<div class="heart">
		<div style="margin-left: 10px;padding-top: 10px;">
			<div>
				<span>程序包名称：&nbsp;&nbsp;</span><select class="select"
					style="width: 400px;">
					<option selected="selected">所有</option>
				</select>
			</div>
			<br>

			<div>
				<span>程序包名称：&nbsp;&nbsp;</span><input type="text"
					style="width: 400px;">

			</div>
			<br>

			<div>
				<input type="button" value="查&nbsp;&nbsp;&nbsp;&nbsp;询"
					style="width: 100px">

			</div>


		</div>
	</div>
	<div class="heart1">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>程序包名称</th>
					<th>兼容平台</th>
					<th>功能简述</th>
					<th>最新版本</th>
					<th>删除</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>慧为安监通_android</td>
					<td>android</td>
					<td>安全检查、设施设备</td>
					<td>ver201212.2.1</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
				<td>慧为安监通_android</td>
					<td>android</td>
					<td>安全检查、设施设备</td>
					<td>ver201212.2.1</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
					<td>慧为安监通_android</td>
					<td>android</td>
					<td>安全检查、设施设备</td>
					<td>ver201212.2.1</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
					<td>慧为安监通_android</td>
					<td>android</td>
					<td>安全检查、设施设备</td>
					<td>ver201212.2.1</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
					<td></td>
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
					<td></td>
				</tr>
				<tr>
					<td></td>
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
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="margin:auto;width: 550px;">
		<input type="button" value="提交删除" style="width: 100px ; float:left;" /><span
			style="float:right; ">第1页/共3页&nbsp;&nbsp;第1页|下一页|上一页|最末页</span>
	</div>


</body>
</html>

