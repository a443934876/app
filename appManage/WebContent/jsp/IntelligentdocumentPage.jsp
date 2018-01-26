<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--智能文档  -->
    <title>Intelligentdocument.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="js/jquery.min.js"></script>
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
   width:20%;
   margin-left:80%;
   text-align: right;
}
#PubComname{
 width:30%;
   margin-left:70%;
   text-align: right;
}
#printthis{margin-left:50px;
}

</style>
</head>

<body style="background-color:#87CEFA">

	<span style="width:100;height:30px;display:block"></span>
	     
        
	
	<div id="context" >
	
	
	<!-- 简要介绍 -->
		<center><h1 id="title"></h1></center>
		
	  <p id="overview"> </p>
	   <!--公文内容  --> 
	   <div style="margin-top:2%"><div id="message"></div></div>
	   <div style="margin-top:2%"><p id="cRemark" ></p></div>
	   <h2 id="PubComname"></h2>
	   <h2 id="PubTime"></h2>
	   
	   
	   
	</div>

	<script type="text/javascript">
	   
	  var grade = parseInt('${resultMap.grade}');
	var array = '${resultMap.messageList}'; 
	  var list=JSON.parse(array);
	
	  $(function(){
		
		
		 if('${resultMap.Enclosure}'!=""){
			 var fileArray = '${resultMap.Enclosure}';
			 var fileList = JSON.parse(fileArray);
			 $(".noprint").append("<h2>附件：</h2>");
			 for(var i=0;i<fileList.length;i++){
			   $(".noprint").append("<a id='"+fileList[i].EnclosureId+"' onclick='watchInfo(this)'>"+fileList[i].EnclosureTitle+"</a></br>");
			 }
		 }
		 
		
		 $("#title").text('${resultMap.cDocTitle}');
		 
		
		  $("#overview").text('${resultMap.overview}');
		  $("#cRemark").text('${resultMap.cRemark}');
		  $("#PubComname").text('${resultMap.puborgname}');
		  $("#PubTime").text('${resultMap.cdate}'); 
		   
		  digui(0);
		   
		
		
	  });
	    
	    function digui(level){//
	    	for(var j=0;j<=grade;j++){
	    		
	    	
	    	for(var i=0;i<list.length;i++){
	    		
	    		if(parseInt(list[i].dLevel)==0&&parseInt(list[i].dLevel)==level&&isNaN(parseInt(list[i].parentobdeid))&&list[i].cDocDetail!="anyType#$"){
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
	    		
	    		if(parseInt(list[i].dLevel)>0&&parseInt(list[i].dLevel)==level&&list[i].cDocDetail!="anyType#$"){
	    			if(parseInt(level)==1){
	    				$("#"+list[i].parentobdeid).append("<p id='"+list[i].cDocDetailID+"'>"+list[i].dSequence+"."+list[i].cDocDetail+"</p>");
	    			}
	    			if(parseInt(level)==2){
	    				$("#"+list[i].parentobdeid).append("<p id='"+list[i].cDocDetailID+"'><"+list[i].dSequence+">."+list[i].cDocDetail+"</p>");
	    			}
	    		}
	    		
	    		if(list[i].inImage!=null&&parseInt(list[i].dLevel)==level){
	    			var imgdata = list[i].inImage.split("&&");
	    		
	    			
	    			for(var k=0;k<imgdata.length;k++){
	    				if(imgdata[k]!=""){
	    					
    				$("#message").append("<img src='"+imgdata[i]+"' />");
	    				}
	    			}
    			}
	    		
	    	}
	    	
	    	level++;
	    	}
	    }
	    	
	   
	    function watchInfo(a){
	    	window.open("getIntelligentdocument?InfoID="+a.id+"&Emid="+'${Emid}');
	    }
	</script>
</body>
</html>
