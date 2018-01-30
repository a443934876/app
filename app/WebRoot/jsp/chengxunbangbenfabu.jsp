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
		<div style="margin-left: 10px; padding-top: 10px;">
			<div>
				<span>程序包名称：</span> <span id="packageName">xxx</span>
			</div>
			<br>
			<div>
				<span>程序版本编号：</span> <input id="packageId" type="text"
					style="width: 335px;" />
			</div>
			<br>
			<div>
				<span>更新修改功能：</span>
				<textarea id="packageUpdateDetails" style="vertical-align: top;"
					rows="5" cols="65"></textarea>
			</div>
			<br>
			<div>
				<span>预备发布日期：</span> <input id="packageDate" type="text" />
			</div>
			<br>
			<div>
				<span>是否强制升级：</span> <input id="packageForceUpdate" type="checkbox" />
			</div>
			<br>
			<div style="float: left">
				<span>扫描上传：</span>
			</div>
			<div>
				<input type="file" style="float: left" /><input id="button"
					type="button" value="上传"">
			</div>
			<br> <br>
			<div>
				<input type="submit" id="submit" value="提交" style="margin-left: 30%">
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#button").click(function() {
			alert($("input#packageForceUpdate:checkbox").is(":checked"));

		});
		
		
		
		
		$("#submit").click(function() {
			if ($("#packageId").val() == "") {
				alert("程序版本编号不能为空");
				return;
			} else if ($("#packageUpdateDetails").val() == "") {
				alert("更新修改功能不能为空");
				return;
			} else if ($("#packageDate").val() == "") {
				alert("预备发布日期不能为空");
				return;
			} else {
				$.post("addPackageVersion", {
					"packageName" : $("packageName").val(),
					"packageId" : $("packageId").val(),
					"packageUpdateDetails" : $("packageUpdateDetails").val(),
					"packageDate" : $("packageDate").val(),
					"packageForceUpdate" : $("input#packageForceUpdate:checkbox").is(":checked")}
				, function(data){
						alert("1");
					});
					
					}
				});
		
		
	</script>




</body>

</html>
