<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--用户帮助  -->
    <title>UsingHelp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <style type="text/css">
      div{margin-left:10%}
   
    span{display:block;width:100%;height:8px;}
   
   </style>
  </head>
  
  <body>
    <h2 style="margin-left:10%;margin-top:5%">欢迎使用该系统帮助说明</h2>
    <div>
    <ul>
      <li>
         <h4>系统</h4>
         <ul>
           <li><h5>返回首页：</h5>1.用户点击后可返回公司选择界面，如果用户只属于一家公司，则自动进入首页。</br>
           <span></span>
                2. 首页上部分显示近期的公文，点击阅读，可进入公文详情页面查看公文内容，图片等并确认阅读。</br>
                <span></span>
                 3.下部分显示未整改的隐患，点击单项进入隐患详情页面，阅读并提交相应整改结果，图片等。
           
           </li>
           <li><h5>用户设置：</h5>用户可以重新设置自己的用户账号，密码，手机号码等，但需要输入旧密码验证</li>
           <li><h5>退出系统：</h5>点击关闭当前页面。</li>
         
         </ul>
      
      
      </li>
      <li>
         <h4>隐患治理：</h4>
         <ul>
           <li><h5>隐患查询：</h5>用户点击后跳转隐患查询界面，可以选择检查时间，隐患类型，整改情况，复查情况等进行查询</li>
          </ul>
      
      
      </li>
      
      <li>
         <h4>公文传送：</h4>
         <ul>
           <li><h5>公文查阅：</h5>用户点击后跳转公文查询界面，可以选择公文标题，文号，发布时间等进行查询进行查看</li>
           <li><h5>公文上传：</h5>1.用户点击后进入公文上传界面，用户可以选择文本或者图片，点击浏览本地选择文件，点击上传</br>  <span></span>2.添加至上传路径，也可删除误选的文件，当确认上传，将文件上传至远程服务器。</li>
          </ul>
      
      
      </li>
    <li>
         <h4>帮助：</h4>
         <ul>
           <li><h5>版权说明：</h5>提供该系统的版权归属和联系方式。</li>
           <li><h5>谢谢！</h5></li>
          </ul>
      
      
      </li>
    
    </ul>
    </div>
  </body>
</html>
