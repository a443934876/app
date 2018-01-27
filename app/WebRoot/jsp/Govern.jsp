<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--公文标题 整改信息等面  -->
    <title>Govern</title>
    
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

<link rel="stylesheet" href="css/common/common.css" />
<link rel="stylesheet" href="css/common/sapar.css" />


<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/pintuer.js"></script>
<style type="text/css">

#divText {
	/* background-color: #00CCFF; */
	width: 100%;
	
	height: 100%;
	
}
 h2{display:inline;} 
/* .show{
width:100%;background-color:#BFEFFF;color:white;
} */
table{margin-left:5%;border-spacing:50px;border-collapse:separate; border-spacing:10px;}
</style>
  </head>
  
  <body>
   <!--公文展示框  -->
	<div id="divText">
		<div style="width:100%;overflow:auto">
			<div class="subfiled clearfix"><img src="image/write.png"/><h2>公文信息:</h2></div>
			<table width="95%" id="table1"  >
				<c:forEach items="${TitleList}" var="title">
					<tr>
						<td style="width:60%;margin-left:100px;margin-right:10%">&#8226;${title.InfoTitle}</td>
						<td style="width:10%;"></td>
						<td style="width:20%">
						      <a onclick="watchInfo(this)"  
							id="${title.InfoID}" name="${title.Emid}">${title.state}</a>
							</td>
					</tr>
				</c:forEach>

			</table>
		</div>
       
		<div
			style="width:100%;border-collapse:collapse;overflow:auto ;margin-top:3%;">
			<div class="subfiled clearfix"><h2>隐患治理:</h2><img src="image/trouble.png"/></div>
			<table width="95%" id="table2">
				<c:forEach items="${GovernList}" var="Govern">
					<tr>
						<td style="width:60%;margin-left:100px;margin-right:10%">&#8226;${Govern.actionOrgName}&nbsp;&nbsp;${Govern.checkDate}&nbsp;&nbsp;${Govern.safetyTrouble}</td>
						<td style="width:10%;"></td>
						<td style="width:20%"><a onclick="watchTrouble(this)" id="${Govern.hTroubleID}">查看</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<script type="text/javascript">
	function freshen(){
		
    	location.reload() ;
    }
	
	
	
	function watchInfo(a){
		
		 window.open("getSingleDocument?InfoID="+a.id+"&Emid="+a.name);
		
    }
	
	function watchTrouble(a){
		
		 window.open("getSingleTrouble?hiid="+a.id);
		
	}
	</script>
  </body>
</html>
