package com.great.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import org.kobjects.base64.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.great.util.CustomSystemUtil;
import com.great.util.WebServiceUtil;

/**
 * 公文的控制
 * 
 * */
@Controller
public class GovernController {
	//图片前面加的路径
	public static final String IMGPATH = "http://huiweioa.chinasafety.org/";
	
	public static final String SAVEPATH = "http://huiweioa.chinasafety.org/Common/UploadFilse/";
	
	
	//获取公文信息的相关要素
	@RequestMapping("getSingleDocument")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView getSingleDocument(String Emid,String InfoID)throws Exception{
		int grade = 0;//文件层级数从0开始
		boolean onlyOne = true;//判断是不是就一个
		
		//返回的结果集
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//返回的消息体集合
		ArrayList<Map<String, String>>messageList = new ArrayList<Map<String,String>>();
		
		ModelAndView modelAndView = new ModelAndView("DocumentPage");
		
		int emid = new Integer(Emid).intValue();//将字符串转为int类型
		
		int infoId = new Integer(InfoID).intValue();
		
		 ArrayList<HashMap<String, Object>> resultArrayList1;//获取公文信息的相关要素，并在页面设置各文本
		 ArrayList<HashMap<String, Object>> resultArrayList2; //输出智能文档要素内容
		 ArrayList<HashMap<String, Object>> resultArrayList3;//输出智能文档细则，并根据父项及层级序号进行递归调用，输出各段落。
		//System.out.println(Emid+"------"+InfoID);
		/*1调用getWebInformFroEmID(int Emid=Emid,int DayCount=5000,int TopCount=500,int InfoID=request("infoid"),bool viewed=1)，
		获取公文信息的相关要素，并在页面设置各文本。
		2.调用getCapacityDocument(string orgIDstr=“”, int cDocID=CDOCID, string keyWord="", DateTime cStart=null, DateTime cEnd=null,
		bool onlyInTitle=0, bool cState=true, int userId=0, string cType="",int docTempId=0, out string retstr)，输出智能文档要素内容。
		3.调用getCapacityDocumentDetail(
		string orgIDstr=“”, int cDocID=CDOCID, string titleKeyWord=“”, string detailKeyWord=“”, int carryPartID=0, 
		int carryDutyID=0, string docType=“”,int parentCDocID=0,int cDocDetailID=0, out string retstr)、
				输出智能文档细则，并根据父项及层级序号进行递归调用，输出各段落。*/
		
		String[]key1 = {"Emid","DayCount","TopCount","InfoID","viewed"};//获取公文key
		Object[]value1 = {0,500,500,infoId,true};
		//System.out.println(infoId+"-------------------------------");
		String[]key2 = {"orgIDstr","cDocID","keyWord","cStart","cEnd","onlyInTitle","cState","userId","cType","docTempId","retstr"};//输出智能文档要素内容
		
		//输出智能文档细则，并根据父项及层级序号进行递归调用，输出各段落。
		String[]key3 = {"orgIDstr","cDocID","titleKeyWord","detailKeyWord","carryPartID",
				"carryDutyID","docType","parentCDocID","cDocDetailID","retstr"};
		
		resultArrayList1 = WebServiceUtil.getWebServiceMsg(key1, value1, "getWebInformFroEmID", WebServiceUtil.HUIWEI_INFO, WebServiceUtil.HUIWEI_NAMESPACE);
		String InfoTitle = (String)resultArrayList1.get(0).get("InfoTitle");//标题
		String AddFilePathsStr = (String)resultArrayList1.get(0).get("AddFilePathsStr");//附件下载
		String InfoNumber = (String)resultArrayList1.get(0).get("InfoNumber");//文号
		/*Date PubDate = (Date)resultArrayList1.get(0).get("PubDate");//发布日期
*/		String PubComname =(String)resultArrayList1.get(0).get("PubComname");//发布单位简称
		String puborgname =(String)resultArrayList1.get(0).get("puborgname");//发布单位全称
		String CDocID = (String)resultArrayList1.get(0).get("CDocID");//关联的智能文档id
		String viewed = (String)resultArrayList1.get(0).get("viewed");//关联的智能文档id
		String info_AdditiondocTitles = (String)resultArrayList1.get(0).get("info_AdditiondocTitles");//附件标题
		
		//String AddFileTitlesStr = (String)resultArrayList1.get(0).get("info_AdditiondocTitles");//附件地址AddFileTitlesStr
		//System.out.println(AddFileTitlesStr+"---------------------------------");
		String info_AdditiondocIDs = (String)resultArrayList1.get(0).get("info_AdditiondocIDs");//附件id字符串
		
		/**
		 * 
		 * 公文附件的处理
		 * */
		ArrayList<Map<String, String>>fileTitleList = new ArrayList<Map<String, String>>();
		if(info_AdditiondocTitles!=null&&info_AdditiondocIDs!=null){
			String[]titleList = info_AdditiondocTitles.split(",");
			//String[]pathList = AddFileTitlesStr.split(";");
			//System.out.println(pathList.length+"************************");
			String[]idList = info_AdditiondocIDs.split(",");
			for (int i = 0; i < titleList.length; i++) {
				Map<String, String>map = new HashMap<String, String>();
				map.put("EnclosureTitle", titleList[i]);
				//map.put("EnclosurePath", pathList[i]);
				map.put("EnclosureId", idList[i]);
				fileTitleList.add(map);
			}
			JSONArray array = JSONArray.fromObject(fileTitleList);
			resultMap.put("Enclosure", array);
					}
		resultMap.put("Emid", Emid);
	    resultMap.put("InfoID", InfoID);
	    resultMap.put("InfoTitle", InfoTitle);
	    resultMap.put("InfoNumber", InfoNumber);
	    resultMap.put("viewed", viewed);
	    //时间搓转化字符串PubComname
	    
	   
	  //System.out.println(AddFilePathsStr+"附件下载地址");
	    if(AddFilePathsStr!=null&&!AddFilePathsStr.equals("anyType#$")){
	    	resultMap.put("AddFilePathsStr", AddFilePathsStr);
	    }
	    resultMap.put("puborgname", puborgname);
	    resultMap.put("PubComname", PubComname);
	    resultMap.put("IMGPATH", IMGPATH);
	    
		Object[]value2 = {"",new Integer(CDocID).intValue(),"","1900-01-01T00:00:00.850","2049-12-31T00:00:00.850",false,true,0,"",0,""};
		resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2, "getCapacityDocument", WebServiceUtil.HUIWEI_URL,WebServiceUtil.HUIWEI_NAMESPACE);
		String overview =  (String)resultArrayList2.get(0).get("overview");//简述
		String cdate =  (String)resultArrayList2.get(0).get("cdate");//简述
		resultMap.put("overview", overview);
		 int num = cdate.lastIndexOf("T");
		 cdate = cdate.substring(0, num);
		resultMap.put("cdate", cdate);
		Object[]value3 = {"",new Integer(CDocID).intValue(),"","",0,0,"",0,0,""};
		resultArrayList3 = WebServiceUtil.getWebServiceMsg(key3, value3, "getCapacityDocumentDetail",WebServiceUtil.HUIWEI_URL,WebServiceUtil.HUIWEI_NAMESPACE);
		
		//System.out.println("-------------------------------------长度"+resultArrayList3.size());
		for (int i = 0; i < resultArrayList3.size(); i++) {
			
			Map<String, String>map = new HashMap<String, String>();
			String parentobdeid = (String)resultArrayList3.get(i).get("parentobdeid");//父id
			String cDocDetailID = (String)resultArrayList3.get(i).get("cDocDetailID");//自己id
			String cRemark = (String)resultArrayList3.get(i).get("cRemark");//说明
			String dSequence = (String)resultArrayList3.get(i).get("dSequence");//段落序号
			String cDocDetail = (String)resultArrayList3.get(i).get("cDocDetail");//段落内容
			String inImage = (String)resultArrayList3.get(i).get("inImage");//图片路径
			
			if(inImage!=null){
				
				String[]imgdata = inImage.split(";");
				inImage = "";
				for (int j = 0; j < imgdata.length; j++) {					
					imgdata[j] = IMGPATH + imgdata[j].substring(3, imgdata[j].length());
					inImage = inImage + imgdata[j]+"&&";
				}
				
				
				map.put("inImage", inImage);
				
			}
			String dLevel = (String)resultArrayList3.get(i).get("dLevel");//等级
			if(new Integer(dLevel).intValue() >0){onlyOne = false;};
			if(dLevel.equals("0")){
				grade=1;
				resultMap.put("grade", grade);
			}
			map.put("parentobdeid", parentobdeid);
			map.put("cDocDetailID", cDocDetailID);
			map.put("cRemark", cRemark);
			map.put("dSequence", dSequence);
			map.put("cDocDetail", cDocDetail);
			map.put("dLevel", dLevel);
			if(new Integer(dLevel).intValue()>grade){
				grade = new Integer(dLevel).intValue();
				resultMap.put("grade", grade);
				
				resultMap.put("onlyOne", onlyOne);
			}
			resultMap.put("grade", grade);
			//System.out.println(resultArrayList3.get(i).toString());
			if(map.size()<0){
				break;
			}else{
				messageList.add(map);
			}
		}
		JSONArray jsonArray = JSONArray.fromObject(messageList);
		System.out.println(jsonArray);
		resultMap.put("messageList", jsonArray);
		modelAndView.addObject("resultMap", resultMap);
		return modelAndView;
		/**标识                                       标识             段落内容                         段落序号                                                                   段落内容
		 * {cDocDetailID=2531907, dLevel=0, cDocDetail=dff, dSequence=1, createcom=慧为测试}
		 * */
	}
	
	/**
	 * 查询公文
	 * */
	@RequestMapping("findGovern")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String,Object> findGovern(@RequestParam Map<String,String>map,HttpSession session)throws Exception{
		
		String pubDateStart = map.get("pubDateStart");
		String	pubDateEnd = map.get("pubDateEnd");
		String	infoTitle = map.get("infoTitle");
		
		String orgidstr = (String)session.getAttribute("orgidstr");
		
		ArrayList<HashMap<String, Object>> resultList;
		
		
		String[]key = {"orgidstr","pubDateStart","pubDateEnd","topCount","docType","infoTitle","retstr"};
		
		Object[] value = {orgidstr,pubDateStart,pubDateEnd,500,"",infoTitle,""};
		
		resultList =  WebServiceUtil.getWebServiceMsg(key, value, "getWebInformFromOrgID", WebServiceUtil.HUIWEI_INFO, WebServiceUtil.HUIWEI_NAMESPACE);
		
		ArrayList<Map<String, String>>BacktList = new ArrayList<Map<String, String>>();
		for (int i = 0; i < resultList.size(); i++) {
			Map<String, String>map2 = new HashMap<String, String>();
			String publish_start = (String)resultList.get(i).get("publish_start");
			 int num = publish_start.lastIndexOf("T");
			 publish_start = publish_start.substring(0,num);
			String	oblititle = (String)resultList.get(i).get("oblititle");
			String	info_num = (String)resultList.get(i).get("info_num");
			String	info_id = (String)resultList.get(i).get("info_id");
			map2.put("publish_start", publish_start);
			map2.put("oblititle", oblititle);
			if(info_num==null){
				map2.put("infonum", "无");
			}else{
				
				map2.put("infonum", info_num);
			}
			map2.put("info_id", info_id);
			BacktList.add(map2);
		}
		
		Map<String, Object> backMap = new HashMap<String, Object>();
		
		backMap.put("data", BacktList);
		
		return backMap;
	}

	
	//确认阅读公文
	@RequestMapping("ConfirmRead")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, String> ConfirmRead(@RequestParam Map<String, String>map,HttpSession session)throws Exception{
		
		String InfoID = map.get("InfoID");
		
		String CRemark = map.get("CRemark");
		
		String Emid = (String)session.getAttribute("Emid");
		
		String ipstr =  CustomSystemUtil.getInternetIp();
		
		String [] key = {"Infoid","Turnemid","CRemark","IPStr"};
		 
		Object [] value = {new Integer(InfoID).intValue(),new Integer(Emid).intValue(),CRemark,ipstr}; 
		
		ArrayList<HashMap<String, Object>>resultMap = WebServiceUtil.getWebServiceMsg(key, value, "setInfoTurning", WebServiceUtil.HUIWEI_INFO, WebServiceUtil.HUIWEI_NAMESPACE);
		
		Map<String, String>backMap = new HashMap<String,String>();
		
		backMap.put("result","success");
		
		return backMap;
		
		
	}
	
	
	//上传文件
	@RequestMapping(value="/uploadDocument",method = RequestMethod.POST)
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, String> uploadDocument(HttpServletRequest request)throws Exception{
		
		String emidStr  = (String) request.getSession().getAttribute("Emid");
		int emid = new Integer(emidStr).intValue();
		
        Map<String, String>backMap = new HashMap<String,String>();
		
		String filecount = request.getParameter("filecount");//文件个数
		
		String fileTitle = request.getParameter("fileTitle");//标题
		
		String fileHelp = request.getParameter("fileHelp");//文件说明
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		String saveFilePath = "";
		
		for (int i = 1; i <= new Integer(filecount).intValue(); i++) {
			
			MultipartFile file = multipartRequest.getFile("file"+i);
			String backStr="";
			if(file!=null){
				String fileName = file.getName();
				String fileType= file.getContentType();
				String[]type=fileType.split("/");				
				
                InputStream input = file.getInputStream();
				
				byte [] data = new byte[input.available()];
				
				input.read(data);
				
				input.close();
				
				String baseString = Base64.encode(data);
				
				String [] key = {"fileBytesstr","fileName"};
				Object [] value = {baseString,fileName};
				if(type[0].equals("text")){
					value[1] = fileName+".txt";
				}else if (type[0].equals("image")) {
					value[1] = fileName+".jpg";
				}				
				
				backStr	= WebServiceUtil.putWebServiceMsg(key, value, "UploadFile", WebServiceUtil.URL);
				System.out.println(backStr+"aaaaa");
				String filePath = backStr +";";
				filePath = WebServiceUtil.UPLOADSPACE+ filePath.substring(2, filePath.length());
				
				System.out.println(filePath+"上传成功了");
				saveFilePath = saveFilePath + filePath;
				
				if(filePath==null){
					backMap.put("result", "lose");
					return backMap;
				}
			}
			// 获得文件： 
			String [] key2 = {"fileTitle","saveToUrl","cEmid","remarkstr","float "};
			
			Object [] value2 = {fileTitle,backStr,emid,fileHelp,(float)file.getSize()};
			
			System.out.println(saveFilePath+"上传文件的路径");
			System.out.println(fileTitle+"上传文件的标题");
			System.out.println(SAVEPATH+"上传文件的路径");
			System.out.println(emid+"上传文件的emid");
			System.out.println(fileHelp+"上传文件的路径");
			System.out.println((float)file.getSize()+"上传文件的大小");
			ArrayList<HashMap<String, Object>>res = WebServiceUtil.getWebServiceMsg(key2, value2, "addNetFileManager", WebServiceUtil.HUIWEI_URL,WebServiceUtil.HUIWEI_NAMESPACE);
			System.out.println(res.get(0)+"文件上传返回的");
			
		}
	
		
		
		backMap.put("result", "success");
		
		return backMap;
	}
	
	
	@RequestMapping("getIntelligentdocument")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView getIntelligentdocument(String Emid,String InfoID)throws Exception{
		//返回的结果集
		int grade = 0;//文件层级数从0开始
		boolean onlyOne = true;//判断是不是就一个
		
				Map<String, Object> resultMap = new HashMap<String, Object>();
				//返回的消息体集合
				ArrayList<Map<String, String>>messageList = new ArrayList<Map<String,String>>();
				
				ModelAndView modelAndView = new ModelAndView("IntelligentdocumentPage");
				
				int emid = new Integer(Emid).intValue();//将字符串转为int类型
				
				int infoId = new Integer(InfoID).intValue();
				
				 ArrayList<HashMap<String, Object>> resultArrayList2; //输出智能文档要素内容
				 ArrayList<HashMap<String, Object>> resultArrayList3;//输出智能文档细则，并根据父项及层级序号进行递归调用，输出各段落。
		
				
				//System.out.println(infoId+"-------------------------------");
				String[]key2 = {"orgIDstr","cDocID","keyWord","cStart","cEnd","onlyInTitle","cState","userId","cType","docTempId","retstr"};//输出智能文档要素内容
				
				//输出智能文档细则，并根据父项及层级序号进行递归调用，输出各段落。
				String[]key3 = {"orgIDstr","cDocID","titleKeyWord","detailKeyWord","carryPartID",
						"carryDutyID","docType","parentCDocID","cDocDetailID","retstr"};
				
				
		Object[]value2 = {"",infoId,"","1900-01-01T00:00:00.850","2049-12-31T00:00:00.850",false,true,0,"",0,""};
		resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2, "getCapacityDocument", WebServiceUtil.HUIWEI_URL,WebServiceUtil.HUIWEI_NAMESPACE);
		String overview =  (String)resultArrayList2.get(0).get("overview");//简述 
		String cDocTitle =  (String)resultArrayList2.get(0).get("cDocTitle");//标题
		String cRemark =  (String)resultArrayList2.get(0).get("cRemark");//说明
				resultMap.put("overview", overview);
		resultMap.put("cDocTitle", cDocTitle);
		resultMap.put("cRemark", cRemark);
		
		Object[]value3 = {"",infoId,"","",0,0,"",0,0,""};
		resultArrayList3 = WebServiceUtil.getWebServiceMsg(key3, value3, "getCapacityDocumentDetail",WebServiceUtil.HUIWEI_URL,WebServiceUtil.HUIWEI_NAMESPACE);
		
		//System.out.println("-------------------------------------长度"+resultArrayList3.size());
		for (int i = 0; i < resultArrayList3.size(); i++) {
			
			Map<String, String>map = new HashMap<String, String>();
			String parentobdeid = (String)resultArrayList3.get(i).get("parentobdeid");//父id
			String cDocDetailID = (String)resultArrayList3.get(i).get("cDocDetailID");//自己id
			
			String dSequence = (String)resultArrayList3.get(i).get("dSequence");//段落序号
			String cDocDetail = (String)resultArrayList3.get(i).get("cDocDetail");//段落内容
			String inImage = (String)resultArrayList3.get(i).get("inImage");//图片路径
			
			if(inImage!=null){				
				String[]imgdata = inImage.split(";");
				inImage = "";
				for (int j = 0; j < imgdata.length; j++) {					
					imgdata[j] = IMGPATH + imgdata[j].substring(3, imgdata[j].length());
					inImage = inImage + imgdata[j]+"&&";
				}
			}
			String dLevel = (String)resultArrayList3.get(i).get("dLevel");//等级
			if(new Integer(dLevel).intValue() > 0){onlyOne = false;};
			if(dLevel.equals("0")){
				grade=1;
				resultMap.put("grade", grade);
			}
			map.put("parentobdeid", parentobdeid);
			map.put("cDocDetailID", cDocDetailID);
			map.put("cRemark", cRemark);
			map.put("dSequence", dSequence);
			map.put("cDocDetail", cDocDetail);
			map.put("inImage", inImage);
			map.put("dLevel", dLevel);
			if(new Integer(dLevel).intValue()>grade){
				
				grade = new Integer(dLevel).intValue();
				resultMap.put("onlyOne", onlyOne);
			}
			resultMap.put("grade", grade);
			//System.out.println(resultArrayList3.get(i).toString());
			if(map.size()<0){
				break;
			}else{
				messageList.add(map);
			}
		}
		JSONArray jsonArray = JSONArray.fromObject(messageList);
		System.out.println(jsonArray);
		resultMap.put("messageList", jsonArray);
		modelAndView.addObject("resultMap", resultMap);
		return modelAndView;
	}
	
}





