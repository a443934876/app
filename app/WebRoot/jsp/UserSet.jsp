<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--用户设置  -->
    <title>UserSet </title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<link rel="stylesheet" type="text/css" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/common/common.css" />
<link rel="stylesheet" href="css/common/sapar.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
    <style type="text/css">
    h4{display:inline;}
   input{border-radius:3px;border:1px solid #000;}
    #submit{margin-left:5%;width:20%;}
    #tishi{display:none;margin-left:10px;color:red;font-size:20;}
    .loginBox{ position:absolute; width:617px; height:330px; background:url(image/login_pro1.png) no-repeat; left:50%; top:40%; margin-left:-309px; margin-top:-184px; padding-top:38px;padding-left:100px;}
    </style>
  </head>
  
  <body style="background-color:#BFEFFF">
  <div class="subfiled clearfix" style="background-color:#B4EEB4"><img src="image/user.png"/><h2 style="margin-top:10px;">&nbsp;用&nbsp;户&nbsp;设&nbsp;置&nbsp;</h2></div>
   <div id="loginform" class="loginBox">
   <h4 style="margin-top:5%">   新用户名&nbsp;：</h4><input type="text" id="newname"/><span id="tishi"></span></br></br>
    <h4>   原&nbsp;密&nbsp;码&nbsp;&nbsp;：</h4><input type="password" id="oldpwd" /></br></br>
     <h4>   新&nbsp;密&nbsp;码&nbsp;&nbsp;：</h4><input type="password" id="newpwd"/></br></br>
      <h4>   确&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认&nbsp;：</h4><input type="password" id="confirm"/></br></br>
       <h4>   手机号码&nbsp;：</h4><input type="text" id="phone"/></br></br></br>
       <input type="button" id="submit" value="确认提交" class="btn btn-default" />
       </div>
       <script type="text/javascript">
      
       
       $(function(){
    	   
    	   /*用户名验证  */
    	   $("#newname").blur(function(){//失去焦点的时候验证新名字
    		   if($("#newname").val()==""){
    			   alert("请输入新用户名");
    			 
    			   return;
    		   }
    		   var reg1=/^[a-zA-Z]\w*$/i;//由字符和数字组成并且由字符开头
    		   if(reg1.test($("#newname").val())==false){
    			   alert("请以字母开头，不得包含特殊字符");
    			   
    			   return;
    		   }
    		   if($("#newname").val().length < 6){
    			   alert("用户名最少六位");
    			 
    			   return;
    		   }
    		   $.post(
    			 "verifyName",
    			 {"newName":$("#newname").val()},
    			 function(data){
    				 if(data.result=='lose'){
    					 
    					 $("#tishi").css("display","inline").text("*该用户名已存在");
    				 };
    				 if(data.result=='suc'){
    					 $("#tishi").css("display","inline").text("*该用户名可以使用");
    				 }
    				 
    			 });
    		   
    	   });
    	   
    	   
    	   
    	   $("input").focus(function(){
    		   $("#tishi").text("").css("display","none");
    	   });
    	   
    	   /*信息验证  */
    	   $("#submit").click(function(){
    	   if($("#newname").val()==""){
    			   alert("请输入新用户名");
    			   return;
    	   }   
    	   if($("#oldpwd").val()==""){
    		   alert("请输入密码");
    		   return;
    	   }
    	   if($("#newpwd").val()==""){
    		   alert("请输入新密码");
    		   return;
    	   }
    	   if($("#newpwd").val()!=$("#confirm").val()){
    		   alert("确认密码错误，请输入重新输入");
    		   $("#confirm").val("");
    		   return;
    	   }
    	   if($("#phone").val()==""){
    		   alert("请输入手机号码");
    		   return;
    	   }
    	   var checkPhone = /^1\d{10}$/;
    	   if(checkPhone.test($("#phone").val())==false){
    		   alert("请输入有效的手机号码");
    		   $("#phone").val("");
    		   return;
    	   }
    	   $.post(
    			   "userSetMessage",
    			   {"newname":$("#newname").val(),"oldpwd":$("#oldpwd").val(),"newpwd":$("#newpwd").val(),"phone":$("#phone").val()},
    			   function(data){
    		             if(data.result=='lose'){
    		            	 alert("修改信息错误");
    		            	 $("#oldpwd").val("");
    		            	 $("#newpwd").val("");
    		            	 $("#phone").val("");
    		            	 $("#confirm").val("");
    		             }else if(data.result=='misspwd'){
    		            	 alert("旧密码错误");
    		            	 $("#oldpwd").val("");
    		             }else if(data.result=='success'){
    		            	 alert("修改信息成功");
    		            	 $("#newname").val("");
    		            	 $("#oldpwd").val("");
    		            	 $("#newpwd").val("");
    		            	 $("#phone").val("");
    		            	 $("#confirm").val("");
    		             }
    	           
    			   });
    	   
    	   });
    	   
    	   
       });
       
       
       </script>
  </body>
</html>
