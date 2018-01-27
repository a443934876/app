<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>登录</title>

   	  <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="theme.css" rel="stylesheet">

    <script src="js/ie-emulation-modes-warning.js"></script>

    
    <style type="text/css">
      #container1{
        
       margin: auto;

      }

      body{
      	margin-top: 12.5%;
        height: 100%;
        
         background-image: url(2.jpg);
         background-size: 100%;
      }
      html{
        height: 100%;

      }

    </style>
  
  </head>

  <body >
    
    <div class="container" id="container1" style="width: 25%;">
    <div style="font-family: 宋体;font-size: 300%;color: white;text-align: center;width: 100%;margin: auto;">OSTA后台管理系统</div>
      <form class="form-signin" action="1.html" method="get" style="width: 100%">
        <h2 class="form-signin-heading" style="width:100%;">登录</h2>
        
        <input type="email" id="inputEmail" class="form-control" placeholder="请输入账号" required autofocus style="width:100%;height: 50px;background-color: transparent;">
      
        <input type="password" id="inputPassword" class="form-control" placeholder="请输入密码" required style="width:100%;height: 50px;background-color: transparent">
        <!-- <div class="checkbox"　style="width: 50%;"> -->
          <label style="display: block;">
            <input type="checkbox" value="remember-me" > 记住密码
          </label>
        <!-- </div> -->
        <button class="btn btn-lg btn-danger"  type="submit" style="width:100%;">登录</button>
        <button class="btn btn-lg btn-primary btn-block" type="submit" style="width:100%;">注册</button>
      </form>

    </div> <!-- /container -->



  </body>
</html>