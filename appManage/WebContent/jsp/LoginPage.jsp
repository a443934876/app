<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--企业登录页面  -->
    <title>Login</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
<style type="text/css">
span{
margin-left:10%;

font-weight: bold;
}
.fontColor{
color:white;}
#span1{

margin-top:5%;}
 #div1{
 
 margin-top: 10%;
    margin-left: 28%;
 
 
 }
 #div2{
    height:240px;
    width:388px;
   
   background-image:url(image/login_bg.png); 
    margin-top: 60px;
    margin-left: 38%;
 	padding-top:2%;
 	
 }
 .text{
 margin-left:5%;
 display:inline;
 }
 #btn{
 margin-left:30%;
 width:40%;
 font-weight: bold;
 height:10%;
 padding-top:0px;
 }
 center{
 width:100%;
 position:fixed;
 top:96%;}

</style>
  </head>
  
  <body style="background-color:#35A2E8">

	<div id="div1" style="width:200dp;height:200dp">
		
	</div>
	<div id="div2">
		<span id="span1" ><span class="fontColor">用  户 名：</span><input type="text" id="text1" class="text"></span></br></br>
		<span> <span class="fontColor">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    码：</span><input type="password" id="text2" class="text"></span></br></br>
		<span> <span class="fontColor">验  证  码：</span><input type="text" id="text3" class="text" style="width:100px">
		<img  id="codeImg" style="width:100px;height:27px;" src="imgCode?date=33"
							 title="点击更换" alt="验证码占位图" onclick="authCode(this)"/></span></br></br>
		 <input type="button" value="登 录" onclick="clicks()" id="btn" class="btn btn-default">
	</div>
     <center><span>福建省仲能网络科技有限公司Copy All Rigt 2017年12月</span></center>
     
     
     <script type="text/javascript">
     var reg1=/^[a-zA-Z]\w*$/i;//由字符和数字组成并且由字符开头
	   
    	
    	function clicks(){
    		if($("#text1").val() == ""){
    			alert("用户名不能为空");
    			return;
    		}else if(reg1.test($("#text1").val())==false){
    			 alert("用户名不合法请重新输入");
    			 $("#text1").val("");
    			   return;
    		}else if($("#text2").val() == ""){
    			alert("密码不能为空");
    			return;
    		}else if($("#text3").val() == ""){
    			alert("验证吗不能为空");
    			return;
    		}else{
    			/*当都不为空时发送请求 Ret:-1说明为何没有查到相关用户信息。0-查询到一条匹配的信息，
    			1-用户名不存在2-手机号码不存在3-微信openid不存在4-密码不正确5-用户昵称电子邮件手机号码格式不正
                 (如用户昵称全为数字,用户昵称小于六位,电子邮件格式不正确,手机号码格式不正确等)，6-微信公众号未绑定OA */
    			$.post(
    		      		"login",
    		      		{"nike":$("#text1").val(),"pwd":$("#text2").val(),"code":$("#text3").val()},
    		      	    function(data){
    		      			
    		      			if(data.result == "验证码错误"){
    		      				alert(data.result);
    		      				$("#text3").val('');
    		      				$("#codeImg").attr("src","imgCode?date=" + new Date().getTime());
    		      			}else if(data.result == "success"){
    		      				/* alert("登录成功"); */
    		      				location = "jsp/MoreComs.jsp";
    		      			}else if(data.result == 'lose'){
    		      				alert("登陆失败,请检查账号和密码是否有误");
    		      			}else if(data.result == "losepwd"){
    		      				/* alert("登录成功"); */
    		      				alert("密码输入错误");
    		      				$("#text2").val("");
    		      			}
    		      		}
    		      	  ); 
    		}
      	  
        }
  
    	function authCode(image){
    		
    		 image.src = "imgCode?date=" + new Date().getTime();
    		 
    		 }   
     
     
     </script>
</body>
</html>
