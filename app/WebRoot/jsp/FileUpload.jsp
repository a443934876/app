<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!--公文上传  -->
    <title>FileUpload</title>
    
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
	<link rel="stylesheet" href="css/common/common.css" />
<link rel="stylesheet" href="css/common/sapar.css" />
<link rel="stylesheet" href="css/pintuer.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/pintuer.js"></script>
<style type="text/css">

  h3{
   display:inline;

   margin-left:10%;
  }
#upload{ margin-left:30%;}
#space{margin-top:50px;;
  width:100%;
  

}
input{border-radius:3px;border:1px solid #000;}
#inputshow{margin-left:23%;}
#input1{width:30%}
#input2{width:30%}
#imglist{display:inline;}

</style>
  </head>
  
  <body >
  <div class="subfiled clearfix"><img src="image/icon06.png"/><h2 style="margin-top:10px;">&nbsp;文&nbsp;件&nbsp;上&nbsp;传&nbsp;</h2></div>
  <div id="space"></div>
     <h3>文件标题：</h3><input type="text" class="input-text" id="input1"/></br></br>
      <h3>备注说明：</h3><input type="text" class="input-text" id="input2"/></br></br>
      <h3>上传文件：</h3><div id="imglist"></div>
       <div id="inputshow" style="width:50%;">
			  <div id="gradediv1" >
			<input id="lefile1" type="file" style="display:none" multiple="true"/>
			<div class="input-append" style="display:inline;width:40%;" id="photodiv1">
				<input id="photoCover1" class="input-large" type="text"
					style="width:35%" />
			</div>
			<input type="button" class="btn btn-info" value="浏览" id="watch1"
				onclick="$('input[id=lefile1]').click();"> 
			<input
				type="button" class="btn btn-primary" value="上传" id="uploadimg1" onclick="uploadFile(1)"
				></br></br>
				  </div>
				</div>
        <div></div>
        <input type="button" value="确认上传" class="btn btn-success radius" id="upload" />






	<script type="text/javascript">
	var count = 1;
		$(function() {
			//在界面控制iframe路径达到刷新的效果
			/* var num=parent.document.getElementById("iframeId");
			num.src="jsp/UserSet.jsp"; */
			$('input[id=lefile1]').change(function() {
				$('#photoCover1').val($(this).val());
				
			});
			
			
			$("#upload").click(function() {
			       var thetime = document.getElementById("input1").value;
					 if (thetime == "") {
							 alert("请添加标题");
							 return;     }
					
                
				     var arr = $("input[type=file]");
				    
				    
				     var forData = new FormData();
				     var filecount = 0;
					  for(var i=0;i<arr.length;i++){
						  if(arr[i].value!=""){
							  filecount++;
							  forData.append("file"+filecount,arr[i].files[0]);
							 }
						  }
					  forData.append("fileTitle",$("#input1").val()+'${orgname}'+'${name}');
					  forData.append("fileHelp",$("#input2").val());
					  forData.append("filecount",filecount);
                   
                   $.ajax({
                 	  url:"uploadDocument",
                 	  type:"post",
                 	  data:forData,
                 	  cache:false,
                 	  processData:false,
                 	  contentType:false,
                 	  async:false,
                 	  success:function(data){
                 		  if(data.result=="lose"){
                 			  alert("上传失败请重新上传");
                 		  }else if(data.result=="success"){
                 			  alert("上传成功");
                 			 var num=parent.document.getElementById("iframeId");
                 			num.src="jsp/FileUpload.jsp";
                 			 
                 		  }
                 	  }
                 	  
                   });
				});
			
		});
		
		
		function uploadFile(num){
			if($("#photoCover"+num).val()==""){
				 alert("请选择要上传的图片");
				 return;
				 }
				 var substr = $("#photoCover"+num).val().split(".");
				/* if(substr[substr.length-1]=="jpeg"||substr[substr.length-1]=="jpg"||substr[substr.length-1]=="JPEG"||substr[substr.length-1]=="txt"){ */
					 $("#imglist").append("<span style='margin-left:10px;' id='"+count+"'>"+substr[0]+"<a onclick='del(this)' style='margin-left:10px;' name='"+count+"'><img src='image/delete.png' /></a></span>");
					 count++;
					    $("#photodiv"+num).css("display","none");
						$("#watch"+num).css("display","none");
						$("#uploadimg"+num).css("display","none"); 
						$("#gradediv"+num).css("display","none");
						$("#inputshow").append("<div  id='gradediv"+count+"'><input id='lefile"+count+"' type='file' style='display:none' multiple='true'/><div class='input-append' style='display:inline;width:40%;' id='photodiv"+count+"'><input id='photoCover"+count+"' class='input-large' type='text' style='width:35%' /></div><input type='button' class='btn btn-info' value='浏览' id='watch"+count+"' onclick=$('input[id=lefile"+count+"]').click();> <input type='button' class='btn btn-primary' value='上传' id='uploadimg"+count+"' onclick='uploadFile("+count+")'></br></br> </div>");
						$('input[id=lefile'+count+']').change(function() {
							$('#photoCover'+count+'').val($(this).val());
							
						});
				
				/*  }else{
					 alert("选择的文件格式不对");
					 $("#photoCover"+num).val("");
				 }
 */			
		}
		
		
		
		function del(a) {
			$("#" + a.name).remove();
			$("#gradediv"+a.name).remove();
			 
		} 
		
	</script>
</body>
</html>
