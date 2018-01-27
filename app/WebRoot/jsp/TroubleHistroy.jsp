<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--隐患记录查询  -->
    <title>TroubleHistroy</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <link rel="stylesheet" type="text/css"
	href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript"
	src="js/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" charset="utf8"
	src="js/jquery.dataTables.js"></script>
	<style type="text/css">
	#btn{ position:absolute;
	     top:2%;
	    right:5%;
	}
	td{text-align:center;}
	#beginTime{width:39%}
	#endTime{width:39%}
	body,td,th {font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;color: #1d1007;}
	</style>
</head>
<body>
	<div style="width:85%;height:10%;padding:5px;">
	检查时间：<input type="date" id="beginTime" />-<input type="date" id="endTime"/><br></br>
	隐患类型： <select style="width:25%" id="troubleType">
	               <option>所有</option>
	                <option>一般</option>
	                <option>较大</option>
	                <option>重大</option>
	                <option>特大</option>
	       </select>
	 整改情况：<select style="width:20%" id="isFinished">
	                <option value="0">所有</option>
	                <option value="1">已完成</option>
	                <option value="2">未完成</option>	               
	       </select>
	复查情况：<select style="width:20%" id="isReviewed">
	                 <option value="0">所有</option>
	                <option value="1">已复查</option>
	                <option value="2">未复查</option>	       
	       </select>
	
	<input type="button" value="查询" class="btn btn-default btn-lg" id="btn"/></div>
	<div style="background-color:black;width:100%;height:3px;margin-bottom:30px;margin-top:30px;"></div>

	<table id="example"
				class="table table-border table-bordered table-bg table-hover table-sort">
		<thead>
			<tr>
			    <td style="width:20%">检查单位</td>
				<td style="width:20%">企业名称</td>
				<td >隐患类别</td>
				<td width="150">发现日期</td>
				<td width="100">隐患等级</td>
				<td width="150">整改期限</td>
				<td width="100">整改情况</td>
				<td width="60" >详情及整改上报</td>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
     <script type="text/javascript">
	
	 $(function(){
		 $("#btn").click(function(){
			
			 if($("#beginTime").val()==""){
				 alert("请选择开始的时间");
				 return;
			 }
			 if($("#endTime").val()==""){
				 alert("请选择结束时间");
				 return;
			 }
			
			 dttable = $('#example').dataTable();
             dttable.fnClearTable(); //清空一下table
             dttable.fnDestroy(); 
			 $.post(
						"troubleHistory",
						{"uEmid":'${Emid}',
							"isFinished":$("#isFinished").find("option:selected").val(),
							"isReviewed":$("#isReviewed").find("option:selected").val(),
							"cStart":$("#beginTime").val(),
							"cEnd":$("#endTime").val(),
							"hgrade":$("#troubleType").find("option:selected").text()},
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
													//列表表头字段actionComname
													columns : [{
														"data" : "actionOrgName"
													},  {
														"data" : "checkObject"
													}, {
														"data" : "safetyTrouble"
													}, {
														"data" : "checkDate"
													},{
														"data" : "troubleGrade"
													},{
														"data" : "limitDate"
													},{
														"data" : "finishDate"
													}, {
														"data" : ""
													}, ],
													"bProcessing" : true,
													columnDefs : [
															{
																targets : 7,
																render : function(data, type, row,
																		meta) {
																	return '<a type="button" class="btn btn-success"  onclick=showContext(this) ><i class="Hui-iconfont">&#xe665;</i> 查看</a>';
																}
															}, {
																"orderable" : false,
																"targets" : 7
															}, ],
												}).api();

							
						});
			 
			 
			 
		 });/* 添加监听的后面括号 */
		
		 
		  
		 
	 });
	
	 function showContext(a){
		 
		   var data = table.row($(a).parents('tr')).data();
			
		   window.open("getSingleTrouble?hiid="+data.hTroubleID);
		 
	 }
	
	</script>

</body>
</html>