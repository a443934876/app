<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>PrintPage</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <SCRIPT language=javascript>
function printsetup()
{
// 打印页面设置
wb.execwb(8,1);
}
function printpreview()
    {
   var ht1 = document.getElementByIdx_x("h");
      ht1.style.display="none";//隐藏不必打印的部分,该隐藏只在预览中有效,真正打印时要用css控制
   wb.execwb(7,1); // 打印页面预览
    
      ht1.style.display="";//预览完再将隐藏的部分显示出来　　
}
function printit()
{
if (confirm('确定打印吗？'))
      {     
          wb.execwb(6,6);
      }
}
</script>
<style type="text/css" media=print>
.noprint{display : none }   //不打印
</style>
</HEAD>
<BODY>
<!-- div h 中的内容不打印 -->
<DIV id="h" align=center class="noprint">
    <OBJECT id=wb height=0 width=0 classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2></OBJECT>
    <INPUT onclick=javascript:printit() type=button value=打印 />
    <INPUT onclick=javascript:printsetup(); type=button value=打印页面设置 />
    <INPUT onclick=javascript:printpreview(); type=button value=打印预览 />
    <INPUT onclick=javascript:window.close(); type=button value=关闭 />
</DIV>
      要打印的正文
</BODY>
</HTML>