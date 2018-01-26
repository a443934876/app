<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!--首页导航栏-->

<title>FirstPage</title>

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


<style type="text/css">
#div1 {
	width: 200dp;
	height: 200dp;
	margin-top: 3%;
	margin-left: 28%;
}

#divMenu {
	background-color: #00CCFF;
	margin-top: 3%;
	width: 100%;
	height: 35px;
}



/* center {
	width: 100%;
	position: fixed;
	top: 96%;
} */

button {
	background-color: #4399D8;
	font-size: 16;
	font-weight:800;
	/* text-shadow:5px 1px 6px #F93 ; */
}

#btn_sys {
	margin-left: 20%;
	margin-right: 4%;
	width: 100px;
}

#btn_govern {
	margin-right: 4%;
	width: 100px;
}

#btn_document {
	margin-right: 4%;
	width: 100px;
}
</style>
</head>

<body style="background-color:#35A2E8">
	<div id="div1">
		<img src="image/banner.png">
	</div>

	<div id="divMenu" class="btn-group">
		<!--系统的菜单组  -->
		<div class="button-group border-blue" id="btn_sys">
			<button type="button" class="button dropdown-hover">
				系统 <span class="downward"></span>
			</button>
			<ul class="drop-menu">
				<li><a onclick="returnFirst()">返回首页</a></li>
				<li><a href="jsp/UserSet.jsp"  target="iframe">用户设置</a></li>
				<!-- <li><a href="jsp/Permissions.jsp" target="iframe" >权限管理</a></li> -->
				<li><a onclick="closeWindow()">退出系统</a></li>
			</ul>
		</div>


		<!--隐患治理的菜单组  -->
		<div class="button-group border-blue" id="btn_govern">
			<button type="button" class="button dropdown-hover">
				隐患治理<span class="downward"></span>
			</button>
			<ul class="drop-menu">
				<li><a href="jsp/TroubleHistroy.jsp" target="iframe">隐患查询</a></li>
			</ul>
		</div>
		<!--公文菜单组  -->
		<div class="button-group border-blue" id="btn_document">
			<button type="button" class="button dropdown-hover">
				公文传送<span class="downward"></span>
			</button>
			<ul class="drop-menu">
				<li role="presentation"><a role="menuitem" tabindex="-1"
					href="jsp/FindGovern.jsp" target="iframe">公文查阅</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1"
					href="jsp/FileUpload.jsp" target="iframe">文件上传</a></li>
			</ul>
		</div>
		<!--帮助菜单  -->
		<div class="button-group border-blue" id="btn_help">
			<button type="button" class="button dropdown-hover">
				帮助<span class="downward"></span>
			</button>
			<ul class="drop-menu">
				<!-- <li role="presentation"><a role="menuitem" tabindex="-1"
					href="jsp/CopyRight.jsp" target="iframe">版权说明</a></li> -->
				<li role="presentation"><a role="menuitem" tabindex="-1"
					href="jsp/UsingHelp.jsp" target="iframe">使用帮助</a></li>
			</ul>
		</div>

	</div>


	<iframe
			src="getGovern?Emid=${Emid}";
			style="width: 70%;
	margin-left: 15%;
	margin-top: 2%;
	height: 100%;" name="iframe" id="iframeId"></iframe>

	<center>
		<span>福建省仲能网络科技有限公司Copy All Rigt 2017年12月</span>
	</center>
	<script type="text/javascript">
	
	 $(function(){
		 $("a").click(function(){
			alert('${Uid}'=="");
			  if('${Uid}'==""){
				 parent.location.replace("jsp/LoginPage.jsp");
				  return false;
			 }; 
			 
			 
		 });
		 
	 });
	
	  function closeWindow(){
		  parent.location.replace("jsp/LoginPage.jsp");
	  };
	
		function returnFirst(){
			location="jsp/MoreComs.jsp";
		};
		
		$(function(){
			var iframe = document.getElementById('iframeId');
			iframe.onload = function() {
			    iframe.contentDocument.onclick = function () {
			    	$(".button-group, .drop").removeClass("open");
			    };
			}
		});
	</script>
</body>
</html>
