<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <!-- 隐患详情查看 -->
    <title>HiddenTrouble</title>
    
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
#context{width:50%;margin-left:30%;margin-top:2%;}
h3{display:inline;}
p{display:inline;font-size:16px;}
textarea,input{border-radius:3px;border:1px solid #000;}
</style>

</head>
 <body style="background-color:#87CEFA">

	<div id="div1" style="width:200dp;height:200dp">
		<img src="image/banner.png">
	</div>
    <div id="context">
         <h3>监检单位：</h3><h3 id="actionComname"></h3></br></br>
         <h3>检查单位：</h3><h3 id="checkObject"></h3></br></br>
         <h3>检查日期：</h3><h3 id="checkDate"></h3></br></br>
         <h3>检查人员：</h3><h3 id="checkPeople"></h3></br></br>
         <h3>发现问题：</h3><h3 id="safetyTrouble"></h3></br></br>
          <h3>隐患等级：</h3><h3 id="troubleGrade"></h3></br></br>
           <!-- <h3>相关依据：</h3><h3>根据人名共和国相关法律七七八八额</h3></br></br> -->
           <h3>整改建议：</h3><p id="dightScheme"></p></br></br>
           
           <div id="imgDiv"></div><!--判断图片地址是否为空  -->
           
           <h3>整改情况：</h3></br></br>
           <textarea name="textarea"  wrap="physical" style="width:80%;height:200px;margin-left:0px;" id="textarea"></textarea><br><br>

		
			<h3>整改完成日期：</h3>
			<input type="date"  id="time"/></br></br>
			<h3>整改费用(人名币元)：</h3>
			<input type="text"  id="price"/></br></br>
			<h3>相关图片：</h3></br></br>
			
			<!--图片一  -->
			<div id="inputshow">
			  <div id="gradediv1" >
			<input id="lefile1" type="file" style="display:none" multiple="true"/>
			<div class="input-append" style="display:inline;width:40%;" id="photodiv1">
				<input id="photoCover1" class="input-large" type="text"
					style="width:30%" />
			</div>
			<input type="button" class="btn btn-info" value="浏览" id="watch1"
				onclick="$('input[id=lefile1]').click();"> 
			<input
				type="button" class="btn btn-primary" value="上传" id="uploadimg1" onclick="uploadimg(1)"
				></br></br>
				  </div>
				</div>	
			
			<div id="imglist"></div>
			<input type="button" value="确认上传" class="btn btn-success radius"
				id="upload" />
		
	</div>
	<!-- <img src="http://huiweioa.chinasafety.org/Common/UploadFilse/2013826537938/1.png"/>
	http://www.chinasafety.org/Common/UploadFilse/2017620162228724/8.png -->
    <script type="text/javascript">
                   var count = 1;
					$(function() {
						var array = '${result.imgPath}'; 
						if(array!=""){
							var list=JSON.parse(array);
						  
						  for(var i=0;i<list.length;i++){
							 
							  if(list[i]!=null){
				    				$("#imgDiv").append("<img src='"+list[i]+"' style='width:50%'/>");
				    			}
						  }
						}

						$('input[id=lefile1]').change(function() {
							$('#photoCover1').val($(this).val());
							
						});
						

						$("#checkObject").text('${result.checkObject}');

						$("#checkDate").text('${result.checkDate}');
                        if('${result.checkPeople}'=="anyType#$"){
                        	$("#checkPeople").text("暂无");
                        }else{                       	
						$("#checkPeople").text('${result.checkPeople}');
                        }
                           
                        $("#actionComname").text('${result.actionComname}');
                        
						$("#safetyTrouble").text('${result.safetyTrouble}');

						$("#troubleGrade").text('${result.troubleGrade}');

						$("#dightScheme").text('${result.dightScheme}');
						

						
					$("#upload").click(function() {
					       var thetime = document.getElementById("time").value;
							 if (thetime == "") {
									 alert("请选择增改时间");
									 return;     }
							var d = new Date(Date.parse(thetime.replace(/-/g, "/")));
								var curDate = new Date();
									if (d >= curDate) {
										alert("请选择小于今天时间！");
											return;
											}
                            var zhengze = /^[0-9]*[1-9][0-9]*$/;
						             if (zhengze.test($("#price").val()) == false) {
								           alert("请输入正确的金额");
								               return;
								             }
						     var arr = $("input[type=file]");
						    
						    
						     var forData = new FormData();
						     var filecount = 0;
							  for(var i=0;i<arr.length;i++){
								  if(arr[i].value!=""){
									  filecount++;
									  forData.append("file"+filecount,arr[i].files[0]);
									 }
								  }
							  forData.append("hiid",'${result.hiid}');
							  forData.append("filecount",filecount);
                              forData.append("textarea",$("#textarea").val());
                              forData.append("time",$("#time").val());
                              forData.append("price",$("#price").val());
                              $.ajax({
                            	  url:"uploadFile",
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
                            			  window.opener.freshen();
                            			  window.close();
                            		  }
                            	  }
                            	  
                              });
						});

					});
                    
					function uploadimg(num){
						if($("#photoCover"+num).val()==""){
							 alert("请选择要上传的图片");
							 return;
							 }
							 var substr = $("#photoCover"+num).val().split(".");
							 if(substr[substr.length-1]=="jpeg"||substr[substr.length-1]=="jpg"||substr[substr.length-1]=="JPEG"||substr[substr.length-1]=="png"){
								 $("#imglist").append("<span style='margin-left:10px;' id='"+count+"'>"+substr[0]+"<a onclick='del(this)' style='margin-left:10px;' name='"+count+"'>删除</a></span>");
								 count++;
								    $("#photodiv"+num).css("display","none");
									$("#watch"+num).css("display","none");
									$("#uploadimg"+num).css("display","none"); 
									$("#gradediv"+num).css("display","none");
									$("#inputshow").append("<div  id='gradediv"+count+"'><input id='lefile"+count+"' type='file' style='display:none' multiple='true'/><div class='input-append' style='display:inline;width:40%;' id='photodiv"+count+"'><input id='photoCover"+count+"' class='input-large' type='text' style='width:30%' /></div><input type='button' class='btn btn-info' value='浏览' id='watch"+count+"' onclick=$('input[id=lefile"+count+"]').click();> <input type='button' class='btn btn-primary' value='上传' id='uploadimg"+count+"' onclick='uploadimg("+count+")'></br></br> </div>");
									$('input[id=lefile'+count+']').change(function() {
										$('#photoCover'+count+'').val($(this).val());
										
									});
							
							 }else{
								 alert("选择的图片格式不对");
								 $("#photoCover"+num).val("");
							 }
						
					}
					
					
					 function del(a) {
						$("#" + a.name).remove();
						$("#gradediv"+a.name).remove();
						 /* var arr = $("input[type=file]");
						  for(var i=0;i<arr.length;i++){
							  if(arr[i].value!=""){								  
									alert(arr[i].value);
							  }
									} */
					} 

					
					
				</script>
  </body>
</html>
