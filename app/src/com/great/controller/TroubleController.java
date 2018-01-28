package com.great.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.great.util.WebServiceUtil;

/**
 * �������Ʋ�
 * 
 * */
@Controller
public class TroubleController {
	
	//ͼƬǰ��ӵ�·��
		public static final String IMGPATH = "http://huiweioa.chinasafety.org/";
	
	//������¼��ѯ
	@RequestMapping("troubleHistory")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> troubleHistory(@RequestParam Map<String, String>map)throws Exception{
		String pubDateStart = map.get("uEmid");
		int uEmid = new Integer(pubDateStart).intValue();
		String	pubDateEnd = map.get("isFinished");
		int isFinished = new Integer(pubDateEnd).intValue();
		String	end = map.get("isReviewed");
		int isReviewed = new Integer(end).intValue();
		String cStart = map.get("cStart");
		String	cEnd = map.get("cEnd");
		String	hgrade = map.get("hgrade");
		if(hgrade.equals("����")){
			hgrade = "";
		}
		String [] key = {"uEmid","isFinished","isReviewed","cStart","cEnd","hgrade","areaRangeID","industryStr","objOrgName"};
		
		Object [] value = {uEmid,isFinished,isReviewed,cStart,cEnd,hgrade,0,"",""};
		
		ArrayList<HashMap<String, Object>> resultList;
		
		resultList =  WebServiceUtil.getWebServiceMsg(key, value, "getAllHiddenIllness", WebServiceUtil.HUIWEI_SAFE_URL, WebServiceUtil.HUIWEI_NAMESPACE);
		
		ArrayList<Map<String, String>>BacktList = new ArrayList<Map<String, String>>();
		for (int i = 0; i < resultList.size(); i++) {
			Map<String, String>map2 = new HashMap<String, String>();
			String hTroubleID = (String)resultList.get(i).get("hTroubleID");//����id
			map2.put("hTroubleID", hTroubleID);
			String actionOrgName = (String)resultList.get(i).get("actionOrgName");//ִ�м��ĵ�λ����
			map2.put("actionOrgName", actionOrgName);
			String checkObject = (String)resultList.get(i).get("checkObject");//�����ĵ�λ����
			map2.put("checkObject", checkObject);
			String troubleGrade = (String)resultList.get(i).get("troubleGrade");//�����ȼ�
			map2.put("troubleGrade", troubleGrade);
			String checkDate = (String)resultList.get(i).get("checkDate");//���ʱ��
			int cutNum = checkDate.lastIndexOf("T");
			checkDate = checkDate.substring(0, cutNum);
			map2.put("checkDate", checkDate);
			String limitDate = (String)resultList.get(i).get("limitDate");//��������
			if(limitDate!=null){
				int cutNum2 = limitDate.lastIndexOf("T");
				limitDate = limitDate.substring(0, cutNum2);
			}else{
				limitDate = "��";
			}
			map2.put("limitDate", limitDate);
			String finishDate = (String)resultList.get(i).get("finishDate");//�������ʱ��
			if(finishDate==null){
				map2.put("finishDate", "δ����");
			}else{
				map2.put("finishDate", "������");
			}
			String safetyTrouble = (String)resultList.get(i).get("safetyTrouble");//��������
			map2.put("safetyTrouble", safetyTrouble);
			
			 
			BacktList.add(map2);
		}
		
		Map<String, Object> backMap = new HashMap<String, Object>();
		
		backMap.put("data", BacktList);
		
		return backMap;
		
	}
	
	
	/**
	 * �鿴������������
	 * */
	@RequestMapping("getSingleTrouble")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView getSingleTrouble(String hiid)throws Exception{
		
		Map<String, Object>backMap = new HashMap<String,Object>();
		
		int hiidNum = new Integer(hiid).intValue();
		
		String [] key = {"hiid"};
		
		Object [] value = {hiidNum};
		
		ArrayList<HashMap<String, Object>> resultList = WebServiceUtil.getWebServiceMsg(key, value, "getHiddenTroubleDetail", WebServiceUtil.HUIWEI_SAFE_URL, WebServiceUtil.HUIWEI_NAMESPACE);
				
		String actionComname = (String)resultList.get(0).get("actionComname");//ִ�м��ĵ�λ����
		backMap.put("actionComname", actionComname);
		
		String checkObject = (String)resultList.get(0).get("checkObject");//�����ĵ�λ
		backMap.put("checkObject", checkObject);
		
		String checkDate = (String)resultList.get(0).get("checkDate");//�������
		int cutNum = checkDate.lastIndexOf("T");
		checkDate = checkDate.substring(0, cutNum);
		backMap.put("checkDate", checkDate);
		
		String checkPeople = (String)resultList.get(0).get("������Ա����");//�����Ա����
		//System.out.println(checkPeople+"������Ա����");
		backMap.put("checkPeople", checkPeople);
		
		String safetyTrouble = (String)resultList.get(0).get("safetyTrouble");//����
		backMap.put("safetyTrouble", safetyTrouble);
		
		String troubleGrade = (String)resultList.get(0).get("troubleGrade");//�����ȼ�
		backMap.put("troubleGrade", troubleGrade);
		
		String dightScheme = (String)resultList.get(0).get("dightScheme");//���Ľ���
		backMap.put("dightScheme", dightScheme);
		
		backMap.put("hiid", hiid);//����id
		
		String imgPatch = (String)resultList.get(0).get("imgPatch");
		//System.out.println("����ͼƬ"+imgPatch);
		if(imgPatch != null){
			String[]imgList  = imgPatch.split(";");
			for (int i = 0; i < imgList.length; i++) {
				
				imgList[i] = IMGPATH + imgList[i].substring(3, imgList[i].length());
				
				/*int j = imgList[i].lastIndexOf(";");
				imgList[i] ="http//www.chinasafety.org/"+ imgList[i].substring(0, j);*/
			}
			JSONArray array = JSONArray.fromObject(imgList);
			backMap.put("imgPath", array);
		}
		 
		
		ModelAndView modelAndView = new ModelAndView("HiddenTrouble");
		modelAndView.addObject("result", backMap);
		
		return modelAndView;
		
	}
	
	
	@RequestMapping(value="/uploadFile",method = RequestMethod.POST)
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, String> uploadFile(HttpServletRequest request)throws Exception{
		//ת��ΪMultipartHttpRequest;
		Map<String, String>backMap = new HashMap<String,String>();
		
		String filecount = request.getParameter("filecount");//�ļ�����
		
		String textarea = request.getParameter("textarea");//��ע
		
		String time = request.getParameter("time");//����ʱ��
		
		String price = request.getParameter("price");//���ķ���
		
		String hiidstr = request.getParameter("hiid");//���ĵ�����id
		
		int hiid = new Integer(hiidstr).intValue();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		String imgPath = "";
		
		for (int i = 1; i <= new Integer(filecount).intValue(); i++) {
			
			MultipartFile file = multipartRequest.getFile("file"+i);
			//System.out.println(file+"----------------");
			//System.out.println(file.+"�ļ�����");
			//System.out.println(file.getName()+"�ļ�����");
			//System.out.println(file.getAbsolutePath()+"�ļ�·��");
			
			if(file!=null){
				String fileName = file.getName();
				
				InputStream input = file.getInputStream();
				
				byte [] data = new byte[input.available()];
				
				input.read(data);
				
				input.close();
				
				String baseString = Base64.encode(data);
				
				String [] key = {"fileBytesstr","fileName"};
				
				Object [] value = {baseString,fileName+".jpg"};
				
				String filePath = WebServiceUtil.putWebServiceMsg(key, value, "UploadFile", WebServiceUtil.URL)+";";
				filePath = WebServiceUtil.UPLOADSPACE+ filePath.substring(2, filePath.length());
				
				System.out.println(filePath+"�ϴ��ɹ���");
				imgPath = imgPath + filePath;
				
				if(filePath==null){
					backMap.put("result", "lose");
					return backMap;
				}
			}
			
			
		}
	/*	SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd" );
		    String nowTime = sdf.format(new Date());*/
		// ����ļ��� 
		String [] key2 = {"troubleid","finishedDate","results","evalstr","factCost","imgpath"};
		
		Object [] value2 = {hiid,time,textarea,"",price,imgPath};
		
		WebServiceUtil.getWebServiceMsg(key2, value2, "setHiddenTroubleDighted", WebServiceUtil.HUIWEI_SAFE_URL,WebServiceUtil.HUIWEI_NAMESPACE);
		
		backMap.put("result", "success");
		
		return backMap;
	}
	

}
