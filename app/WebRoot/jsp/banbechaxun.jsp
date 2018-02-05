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
<script type="text/javascript" src="js/bootstrap-table.js"></script>
<script type="text/javascript" src="js/bootstrap-table-export.js"></script>
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

.table th,.table td {
	text-align: center;
}
</style>
<script type="text/javascript">
	var comid = ${comid};
	$(document).ready(function() {
		getPackage(comid);
	});

	function getPackage(comid) {
		$.post("getPackage", {
			"packageid" : 0,
			"comid" : comid,
		}, function(date) {
			var result = date.result;
			$.each(result, function(i, item) {
				$("#select").append(
						"<option value="+result[i].promaid+">"
								+ result[i].promaname + "</option>");
			});
		});
	};
	function onDelete() {

		var pverid = JSON.stringify($("#reportTable").bootstrapTable(
				'getSelections'));
		$.post("dropPackageVersion", {
			"pveridlist" : pverid,
		}, function(date) {

			window.location.reload();
		});
	};
	function query() {
		$
				.post(
						"getPackageVersion",
						{
							"packageid" : $("#select option:selected").val(),
							"ver " : $("#ver").val(),
							"comid" : comid,
						},
						function(date) {
							var result = date.result;
							var datas = [];
							$.each(result, function(i, item) {
								datas[i] = {
									"fpath" : result[i].fpath,
									"proverid" : result[i].proverid,
									"proname" : result[i].proname,
									"plat" : result[i].plat,
									"mainfun" : result[i].mainfun,
									"ver" : result[i].ver,
								};
							});
							$("#reportTable").bootstrapTable('destroy');
							$("#reportTable")
									.bootstrapTable(
											{
												method : "post",
												cache : false,
												height : 250,
												striped : true,
												pagination : true,
												pageSize : 5,
												pageNumber : 1,
												pageList : [ 10, 20, 50, 100,
														200, 500 ],
												sidePagination : 'client',
												exportTypes : [ 'csv', 'txt',
														'xml' ],
												clickToSelect : true,
												columns : [
														{

															field : "proname",
															title : "程序包名称",
															align : "center",
															valign : "middle",
															sortable : "true"
														},
														{
															field : "plat",
															title : "兼容平台",
															align : "center",
															valign : "middle",
															sortable : "true"
														},
														{
															field : "mainfun",
															title : "功能简述",
															align : "center",
															valign : "middle",
															sortable : "true"
														},
														{
															field : "ver",
															title : "最新版本",
															align : "center",
															formatter : function(
																	value, row,
																	index) {
																return '<a  href='+row.fpath+' download >'
																		+ value
																		+ '</a> ';
															}
														}, {
															title : "删除",
															align : "center",
															valign : "middle",
															checkbox : true,

														} ],
												data : datas,
											});

						});
	};
</script>

</head>

<body>
	<div><jsp:include page="head.jsp" /></div>
	<div class="heart">
		<div style="margin-left: 10px;padding-top: 10px;">
			<div>
				<span>程序包名称：&nbsp;&nbsp;</span><select id="select"
					style="width: 400px">
					<option selected="selected" value="0">所有</option>
				</select>
			</div>
			<br>

			<div>
				<span>版本关键词：&nbsp;&nbsp;</span><input type="text" id="ver"
					style="width: 400px;">

			</div>
			<br>

			<div>
				<input type="button" value="查&nbsp;&nbsp;&nbsp;&nbsp;询"
					style="width: 100px" onclick="query()">

			</div>


		</div>
	</div>
	<div class="heart1">
		<table id="reportTable"
			class="table table-bordered table-hover table-responsive">
			<thead>
				<tr>
					<th>程序包名称</th>
					<th>兼容平台</th>
					<th>功能简述</th>
					<th>最新版本</th>
					<th>删除</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="margin:auto;width: 550px;">
		<input onclick="onDelete()" type="button" value="提交删除"
			style="width: 100px ;" />
	</div>






</body>
</html>

