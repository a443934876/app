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
			</thead>
			<tbody>
				<tr>
					<td>慧为安全生产平台软件安服通201710.0.1版本发布</td>
					<td>2017-12-17</td>
				</tr>
			</tbody>
		</table>

	</div>

	<%-- <div id="container">
    <div id="bd">
    	<div class="wrap clearfix">
        	<div class="sidebar">
            	<h2 class="sidebar-header"><p>功能导航</p></h2>
                <ul class="nav" style="height:80%">
                	<li class="office current">
                        <div class="nav-header"><a onclick="returnFirst()" class="clearfix"><span>返回首页</span><i class="icon"></i></a></div>
                    </li>
                    <li class="gongwen">
                        <div class="nav-header"><a href="jsp/TroubleHistroy.jsp"  target="iframe" class="clearfix"><span>隐患查询</span><i class="icon"></i></a></div>
                    </li>
                    <li class="konwledge">
                    	<div class="nav-header"><a href="jsp/FindGovern.jsp" class="clearfix" target="iframe"><span>公文查阅</span><i class="icon"></i></a></div>
                    </li>
                    <li class="nav-info">
                        <div class="nav-header">
                            <a href="jsp/FileUpload.jsp" class="clearfix" target="iframe"><span>公文上传</span><i class="icon"></i>
                            </a>
                        </div>
                    </li>
                    <li class="agency">
                        <div class="nav-header"><a href="jsp/UserSet.jsp" class="clearfix" target="iframe"><span>用户设置</span><i class="icon"></i></a></div>
                    </li>
                    <li class="system">
                        <div class="nav-header">
                            <a href="javascript:;"  class="clearfix">
                                <span>系统</span>
                                <i class="icon"></i>
                            </a>
                        </div>
                        <ul class="subnav">
                            <li><a onclick="closeWindow()">退出系统</a></li>
                            <li><a href="jsp/UsingHelp.jsp" target="iframe">使用帮助</a></li>
                           
                        </ul>
                    </li>
                   
                </ul>
            </div>
            <div class="content">
                
            	<iframe src="getGovern?Emid=${Emid}" id="iframeId" name="iframe" width="100%" height="100%" frameborder="0"></iframe>
            </div>
        </div>
    </div>
</div> --%>
</body>
<script type="text/javascript" src="js/index_inner.js"></script>
<script type="text/javascript">
	function closeWindow() {
		parent.location.replace("./index.jsp");
	};

	function returnFirst() {
		location = "jsp/MoreComs.jsp";
	};
</script>
</html>
