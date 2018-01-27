<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--查询公文  -->
    <title>FindGovern</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet"
	href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="css/pintuer.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/pintuer.js"></script>
<script type="text/javascript" charset="utf8"
	src="js/jquery.dataTables.js"></script>
<style type="text/css">
 h4{display:inline;}
#title{width:80%;}
#context{margin-left:10%;margin-top:3%;}
#blackLine{width:100%;height:3px;background-color:black;margin-top:15px;margin-bottom:15px;}
#message{width:90%;margin-left:5%;}
body,td,th {font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #1d1007;}

td{text-align:center;}
</style>
  </head>
  
  <body>
	<div id="context">
		<h4>公文标题：</h4>
		<input type="text" id="title" /></br></br>
		<h4>公文文号：</h4>
		<input type="text" />&nbsp;&nbsp;&nbsp;&nbsp;
		<h4>发布时间:从</h4>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="date" id="pubDateStart"/>&nbsp;&nbsp;&nbsp;&nbsp;
		<h4>到</h4>&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="date" id="pubDateEnd"/></br></br>
		<input type="button" value="查询" class="button border-sub" id="btnFind"/>
	</div>
	<div id="blackLine"></div>
	<div id="message">
	      <table id="example"
				class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr>
					<td style="width:20%">发布日期</td>
					<td width="100">公文标题</td>
					<td width="100">公文文号</td>
					<td width="60">内容</td>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	     <!-- <span style="margin-left:40%">共</span><span id="sumPage"></span><span>页</span>
	     <span style="margin-left:2%">第</span><span id="numPage"></span><span>页</span>
	     <a>第一页</a><a>上一页</a><a>下一页</a><a>最后页</a> -->
	</div>
	<script type="text/javascript">
	
	 $(function(){
		 $("#btnFind").click(function(){
			 if($("#pubDateStart").val()==""){
				 alert("请输入开始时间");
				 return;
			 }
			 if($("#pubDateEnd").val()==""){
				 alert("请输入结束时间");
				 return;
			 }
			 dttable = $('#example').dataTable();
             dttable.fnClearTable(); //清空一下table
             dttable.fnDestroy(); 
			 $.post(
						"findGovern",
						{"pubDateStart":$("#pubDateStart").val(),"pubDateEnd":$("#pubDateEnd").val(),"infoTitle":$("#title").val()},
						 function(result){
							var lang = {
									"sProcessing" : "处理中...",
									"sLengthMenu" : "每页 _MENU_ 项",
									"sZeroRecords" : "没有匹配结果",
									"sInfo" : "当前显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
									"sInfoEmpty" : "当前显示第 0 至 0 项，共 0 项",
									"sInfoFiltered" : "(由 _MAX_ 项结果过滤)",
									"sInfoPostFix" : "",
									"sSearch" : "搜索:",
									"bSort" : false,
									 "bAutoWidth": false, 
									"sUrl" : "",
									"sEmptyTable" : "表中数据为空",
									"sLoadingRecords" : "载入中...",
									"sInfoThousands" : ",",
									"oPaginate" : {
										"sFirst" : "首页",
										"sPrevious" : "上页",
										"sNext" : "下页",
										"sLast" : "末页",
										"sJump" : "跳转"
									},
									"oAria" : {
										"sSortAscending" : ": 以升序排列此列",
										"sSortDescending" : ": 以降序排列此列"
									}
								};
								//初始化表格
								 table = $("#example")
										.dataTable(
												{
													language : lang,
													ajax : function(data, callback, settings) {
														//封装请求参数
														var param = {};

														callback(result);
													},
													//列表表头字段
													columns : [ {
														"data" : "publish_start"
													}, {
														"data" : "oblititle"
													}, {
														"data" : "infonum"
													}, {
														"data" : ""
													}, ],
													columnDefs : [
															{
																targets : 3,
																render : function(data, type, row,
																		meta) {
																	return '<a type="button" class="btn btn-success"  onclick=showContext(this) ><i class="Hui-iconfont">&#xe665;</i> 查看</a>';
																}
															}, {
																"orderable" : false,
																"targets" : 3
															}, ],
												}).api();

							
						});
			 
			 
			 
		 });/* 添加监听的后面括号 */
		
		 
		  
		 
	 });
	
	 function showContext(a){
		 
		   var data = table.row($(a).parents('tr')).data();
			
			
			window.open("getSingleDocument?InfoID="+data.info_id+"&Emid="+'${Emid}');
	 }
	
	</script>
</body>
</html>
