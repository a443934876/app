<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
<title>程序包管理</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css/h-ui/H-ui.login.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.base64.js"></script>
<script type="text/javascript"
	src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-table.js"></script>
<script type="text/javascript" src="js/bootstrap-table-export.js"></script>

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

.table th,.table td {
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		var comid = 6;
		getPackage(comid);
		$("#button").click(function() {
			$.ajax({
				type : "POST",
				url : "addPackage",
				async : false,
				scriptCharset : 'utf-8',
				data : {
					"packageName" : $("#packageName").val(),
					"plat" : $("#plat").val(),
					"funDetail" : $("#funDetail").val(),
					"comid" : comid
				},
				success : function() {
					window.location.reload();
				}
			});
		});

	});

	function getPackage(comid) {
		$.post("getPackage", {
			"packageid" : 0,
			"comid" : comid,

		}, function(date) {
			var result = date.result;
			var datas = [];
			$.each(result, function(i, item) {
				datas[i] = {
					"promaname" : result[i].promaname,
					"plat" : result[i].plat,
					"profun" : result[i].profun,
					"promaid" : result[i].promaid

				};

			});
			$("#reportTable").bootstrapTable({
				method : "post",
				cache : false,
				height : 250,
				striped : true,
				pagination : true,
				pageSize : 5,
				pageNumber : 1,
				pageList : [ 10, 20, 50, 100, 200, 500 ],
				sidePagination : 'client',
				exportTypes : [ 'csv', 'txt', 'xml' ],
				clickToSelect : true,
				columns : [ {

					field : "promaname",
					title : "程序包名称",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "plat",
					title : "兼容平台",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "profun",
					title : "功能简述",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					title : "发布新版",
					field : "promaid",
					align : "center",
					formatter : function(value, row, index) {
						sessionStorage.setItem("promaname", row.promaname);
						sessionStorage.setItem("promaid", row.promaid);
						return '<a href="jsp/chengxunbangbenfabu.jsp">进入</a> ';
					}
				} ],
				data : datas,
			});

		});

	}
</script>
</head>

<body>
	<div><jsp:include page="head.jsp" /></div>

	<div>
		<div class="heart">
			<div style="margin-left: 10px; padding-top: 10px;">
				<div>
					<span>程序包名称：&nbsp;&nbsp;</span><input id="packageName" type="text"
						style="width: 400px;">

				</div>
				<br>

				<div>
					<span>兼容平台：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input id="plat"
						type="text" style="width: 400px;">

				</div>
				<br>

				<div>
					<span>程序包功能：&nbsp;</span>
					<textarea id="funDetail" style="vertical-align: top;" rows="3"
						cols="64"></textarea>

				</div>
				<br>

				<div>
					<input id="button" type="button" value="提&nbsp;&nbsp;&nbsp;&nbsp;交"
						style="width: 100px">

				</div>


			</div>
		</div>
		<div class="heart1">
			<table id="reportTable"
				class="table table-bordered table-hover table-responsive">

			</table>
		</div>
	</div>

</body>
</html>
