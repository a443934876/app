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
<!--公文详情页面  -->
<title>DocumentPage</title>

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
	margin-top: 2%;
	margin-left: 28%;
}

#context {
	width: 70%;
	margin-left: 15%;
	margin-top: 2%;
	font-family:FangSong;
	font-size:21.3px;
}

.fontstyle {
	display: inline;
	font-weight: 800;
	font-family:FZXBSJW-GB1-0;
	color:red;
	font-size:29.3px;
}
#title{
font-family:SimSun;
}
p {
	text-indent: 2em; /*em是相对单位，2em即现在一个字大小的两倍*/
	margin-left: 2%;
}

h2 {
	right:0; position:relative;
}

#PubTime{
   width:100%;
  
   text-align: right;
}
#PubComname{
 width:100%;
  
   text-align: right;
}
#printthis{margin-left:50px;
}
hr{
width:80%;height:3px;background-color:red;margin-bottom: 0.5cm
}
input{border-radius:3px;border:1px solid #000;}
</style>
</head>

<body style="background-color:#87CEFA">

	<!-- <div id="div1" style="width:200dp;height:200dp">
		<img src="image/banner.png">
	</div> -->

	<center>
	     <span style="width:100;height:30px;display:block"></span>
	     
	     <h1 id="allcall"  class="fontstyle" style="color:red"></h1><h1  class="fontstyle" style="color:red">文件</h1></br></br>
         <h3 id="infoNumber"></h3>
         <div style="width:80%;height:3px;background-color:red;margin-bottom: 0.5cm">
           <img src="image/red.jpg" style="width:100%;height:4px;display:none" id="redline"/>
         </div>
	</center>
	<div id="context" >
	
	
	<!-- 简要介绍 -->
		<center><h1 id="title"></h1></center>
		<h2 >各相关企业：</h2>
	  <p id="overview"> </p>
	   <!--公文内容  --> 
	   <div style="margin-top:2%"><div id="message"></div></div>
	   <div style="margin-top:2%"><p id="cRemark" ></p></div>
	   <h2 id="PubComname"></h2>
	   <h2 id="PubTime"></h2>
	   
	   <div id="fujian" style="margin-bottom:1cm;" ></div>
	  <div class="noprint" style="margin-bottom:1cm;" >
	   <textarea name="textarea"  wrap="physical" style="width:80%;height:200px;margin-left:0px;" id="textarea" ></textarea><br><br>
   	<input type="button" value="阅读确认" class="btn btn-success radius" id="send" />
   	<input type="button" value="打印" class="btn btn-info" id="printthis" onclick="doPrint()"/>
	 </div>
	 
	</div>

	<script type="text/javascript">
	   
	var array = '${resultMap.messageList}'; 
	  var list=JSON.parse(array);
	  var grade = parseInt('${resultMap.grade}');

	  $(function(){
		 if(parseInt('${resultMap.viewed}')==1){
			 $("#textarea").css("display","none");
			 $("#send").css("display","none");
		 }
		 
		 if('${resultMap.Enclosure}'!=""){
			 var fileArray = '${resultMap.Enclosure}';
			 var fileList = JSON.parse(fileArray);
			 $("#fujian").append("<h2>附件：</h2>");
			 for(var i=0;i<fileList.length;i++){
			   $("#fujian").append("<a id='"+fileList[i].EnclosureId+"' onclick='watchInfo(this)'>"+fileList[i].EnclosureTitle+"</a></br>");
			 }
		 }
		 
		 $("#allcall").text('${resultMap.puborgname}');
		 $("#title").text('${resultMap.InfoTitle}');
		  $("#infoNumber").text('${resultMap.InfoNumber}');
		
		  $("#overview").text('${resultMap.overview}');
		  if('${resultMap.messageList[0].cRemark}'!="null"){
			  
		  $("#cRemark").text('${resultMap.messageList[0].cRemark}');
		  }
		  $("#PubComname").text('${resultMap.puborgname}');
		  $("#PubTime").text('${resultMap.cdate}'); 
		   
		  digui(0);
		   
		 $("#send").click(function(){
			 $.post(
					 "ConfirmRead",
					 {"InfoID":'${resultMap.InfoID}',"CRemark":$("#textarea").val()},
					 function(data){
						 if(data.result=="success"){
							 alert("确认成功");
							 window.opener.freshen();
							 $("#textarea").val("");
							 window.close();
						 }
					 }
			 );
		 });
		
	  });
	    
	    function digui(level){//
	    	for(var j=0;j<=grade;j++){
	    		
	    	
	    	for(var i=0;i<list.length;i++){
	    
	    		if(parseInt(list[i].dLevel)==0&&parseInt(list[i].dLevel)==level&&isNaN(parseInt(list[i].parentobdeid))&&list[i].cDocDetail!="anyType#$"&&list[i].cDocDetail!=null){
	    			switch(parseInt(list[i].dSequence)){
	    			case 1:
	    				$("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"一."+list[i].cDocDetail+"</p>");
	    				break;
	    			
	    		    case 2:
    				    $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"二."+list[i].cDocDetail+"</p>");
    				    break;
    			    case 3:
				        $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"三."+list[i].cDocDetail+"</p>");
				        break;
			        case 4:
				        $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"四."+list[i].cDocDetail+"</p>");
				        break;
		            case 5:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"五."+list[i].cDocDetail+"</p>");
			            break;
		            case 6:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"六."+list[i].cDocDetail+"</p>");
			            break;
		            case 7:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"七."+list[i].cDocDetail+"</p>");
			            break;
		            case 8:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"八."+list[i].cDocDetail+"</p>");
			            break;
		            case 9:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"九."+list[i].cDocDetail+"</p>");
			            break;
		            case 10:
			            $("#message").append("<p id='"+list[i].cDocDetailID+"'>"+"十."+list[i].cDocDetail+"</p>");
			            break;
	    			
		}
	    			
	    		}
	    		
	    		if(parseInt(list[i].dLevel)>0&&parseInt(list[i].dLevel)==level&&list[i].cDocDetail!="anyType#$"&&list[i].cDocDetail!="null"){
	    			if(parseInt(level)==1){
	    				$("#"+list[i].parentobdeid).append("<p id='"+list[i].cDocDetailID+"'>"+list[i].dSequence+"."+list[i].cDocDetail+"</p>");
	    			}
	    			if(parseInt(level)==2){
	    				$("#"+list[i].parentobdeid).append("<p id='"+list[i].cDocDetailID+"'><"+list[i].dSequence+">."+list[i].cDocDetail+"</p>");
	    			}
	    		}
	    		
	    		 if(list[i].inImage!=null&&parseInt(list[i].dLevel)==level){
	    			 var imgdata = list[i].inImage.split("&&");
	    			for(var mg = 0;mg<imgdata.length;mg++){
	    				if(imgdata[mg]!=""){
	    			$("#message").append("<img src='"+imgdata[mg]+"' style='width:100%;' />");
	    			} 
    			} 
	    	}
	    	}
	        level++;
	    }
	  } 	
	    function doPrint(){
	    	 $(".noprint").css("display","none"); 
	    	 $("#redline").css("display","block");
	    	 $("h1").css("color","red");
	         window.print();
	    	 window.close();  
	    	
	    }
	    function watchInfo(a){
	    	window.open("getIntelligentdocument?InfoID="+a.id+"&Emid="+'${Emid}');
	    }
	    
	    
	</script>
</body>
</html>
