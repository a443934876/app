package com.great.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.kobjects.base64.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.great.util.AuthCode;
import com.great.util.WebServiceUtil;

/**
 * 用户的操作管理
 * 
 */
@Controller
public class UserController {

	private String imgCode = "";// 存验证码内容

	@RequestMapping("login")
	@ResponseBody
	public Map<String, Object> login(@RequestParam Map<String, String> map,
			HttpSession session) throws Exception {
		/**
		 * 用户登陆验证
		 */
		Map<String, Object> backMap = new HashMap<>();
		String nike = map.get("nike");
		String pwd = map.get("pwd");
		String[] key = { "requestName", "mphone", "email", "pwd", "ret" };
		Object[] value = { nike, "", "", pwd, -1 };
		ArrayList<HashMap<String, Object>> resultArrayList;
		try {
			resultArrayList = WebServiceUtil.getWebServiceMsg(key, value,
					"getSinglePersonalUserFromLogin",
					WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
			String ret = (String) resultArrayList.get(0).get("ret");
			if (ret.equals("-1")) {
				backMap.put("result", "lose");
				return backMap;
			}
			if (ret.equals("0")) {
				backMap.put("result", "success");
				// 返回0表示登陆成功，将用户的id存起来
				if (((String) resultArrayList.get(0).get("ret")).equals("0")) {
					String Uid = (String) resultArrayList.get(0).get("Uid");
					String peoid = (String) resultArrayList.get(0).get("peoid");
					String name = (String) resultArrayList.get(0).get("姓名");
					session.setAttribute("Uid", Uid);
					session.setAttribute("PUserID", peoid);
					session.setAttribute("nike", nike);
					session.setAttribute("name", name);
				}
			} else if (ret.equals("1")) {
				backMap.put("result", "lose");
			} else if (ret.equals("4")) {
				backMap.put("result", "losepwd");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return backMap;
	}

	// 登陆时获取验证码使用
	@RequestMapping("imgCode")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public void studentImg(HttpServletResponse response) throws Exception {

		imgCode = AuthCode.getAuthCode();

		BufferedImage image = AuthCode.getAuthImg(imgCode);

		try {
			// 写入对应img标签上，显示出来
			ImageIO.write(image, "JPEG", response.getOutputStream());
		} catch (IOException e) {

			e.printStackTrace();
		}
	}

	// 获取用户登录后公司信息的选择
	@RequestMapping("getCompany")
	@ResponseBody
	public Map<String, Object> getCompany(String personId, HttpSession session)
			throws Exception {

		String[] key = { "uPersonalID", "sState" };
		Object[] value = { personId, "在职" };
		ArrayList<HashMap<String, Object>> resultArrayList;

		resultArrayList = WebServiceUtil.getWebServiceMsg(key, value,
				"getMoreComs", WebServiceUtil.HUIWEI_URL,
				WebServiceUtil.HUIWEI_NAMESPACE);
		// 返回到前端的集合
		ArrayList<Object> backList = new ArrayList<Object>();
		for (int i = 0; i < resultArrayList.size(); i++) {

			Map<String, String> map = new HashMap<String, String>();
			map.put("Emids", (String) resultArrayList.get(i).get("Emid"));
			map.put("comname", (String) resultArrayList.get(i).get("comname"));
			map.put("comid", (String) resultArrayList.get(i).get("comid"));
			System.out.println(resultArrayList.get(i).get("comid"));
			backList.add(map);
		}
		if (resultArrayList.size() == 1) {
			session.setAttribute("Emid",
					(String) resultArrayList.get(0).get("Emid"));
			session.setAttribute("orgidstr", (String) resultArrayList.get(0)
					.get("orgidstr"));
			session.setAttribute("orgname", (String) resultArrayList.get(0)
					.get("orgname"));
			session.setAttribute("comid",
					(String) resultArrayList.get(0).get("comid"));
		}
		Map<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("result", backList);
		return backMap;

	}

	// 查询版本
	@RequestMapping("getNewPackageVersion")
	@ResponseBody
	public Map<String, Object> getNewPackageVersion(String comid)
			throws Exception {

		String[] key = { "packageid", "comid" };
		Object[] value = { 0, comid };
		ArrayList<HashMap<String, Object>> resultArrayList;

		resultArrayList = WebServiceUtil.getWebServiceMsg(key, value,
				"getNewPackageVersion", WebServiceUtil.HUIWEI_PM_URL,
				WebServiceUtil.HUIWEI_PM_NAMESPACE);
		// 返回到前端的集合
		ArrayList<Object> backList = new ArrayList<Object>();
		for (int i = 0; i < resultArrayList.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			System.out.println(resultArrayList.get(i).toString());
			String date = (String) resultArrayList.get(i).get("pubdate");
			String newdate;
			if (date.indexOf("T") > -1) {
				newdate = date.substring(0, date.indexOf("T"));
			} else {
				newdate = date;
			}

			map.put("proname", (String) resultArrayList.get(i).get("proname"));
			map.put("pubdate", newdate);
			backList.add(map);
		}

		Map<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("result", backList);
		return backMap;

	}

	// getPackage
	@RequestMapping("getPackage")
	@ResponseBody
	public Map<String, Object> getPackage(@RequestParam Map<String, String> map1)
			throws Exception {
		String packageid = map1.get("packageid");
		String comid = map1.get("comid");
		String[] key = { "packageid", "packagename", "comid" };
		Object[] value = { packageid, "", comid };
		ArrayList<HashMap<String, Object>> resultArrayList;

		resultArrayList = WebServiceUtil.getWebServiceMsg(key, value,
				"getPackage", WebServiceUtil.HUIWEI_PM_URL,
				WebServiceUtil.HUIWEI_PM_NAMESPACE);
		// 返回到前端的集合
		ArrayList<Object> backList = new ArrayList<Object>();
		for (int i = 0; i < resultArrayList.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("promaid", (String) resultArrayList.get(i).get("promaid"));
			map.put("promaname",
					(String) resultArrayList.get(i).get("promaname"));
			map.put("profun", (String) resultArrayList.get(i).get("profun"));
			map.put("plat", (String) resultArrayList.get(i).get("plat"));
			backList.add(map);
		}

		Map<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("result", backList);
		return backMap;

	}

	// getPackageVersion
	@RequestMapping("getPackageVersion")
	@ResponseBody
	public Map<String, Object> getPackageVersion(
			@RequestParam Map<String, String> map1) throws Exception {
		String packageid = map1.get("packageid");
		String comid = map1.get("comid");
		String ver = map1.get("ver");
		if (ver == null) {
			ver = "";
		}
		String[] key = { "packageid", "ver", "comid" };
		Object[] value = { packageid, ver, comid };
		ArrayList<HashMap<String, Object>> resultArrayList = WebServiceUtil
				.getWebServiceMsg(key, value, "getPackageVersion",
						WebServiceUtil.HUIWEI_PM_URL,
						WebServiceUtil.HUIWEI_PM_NAMESPACE);
		// 返回到前端的集合
		ArrayList<Object> backList = new ArrayList<Object>();
		for (int i = 0; i < resultArrayList.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("proverid", (String) resultArrayList.get(i).get("proverid"));
			map.put("proname",(String) resultArrayList.get(i).get("proname"));
			map.put("plat", (String) resultArrayList.get(i).get("plat"));
			map.put("mainfun", (String) resultArrayList.get(i).get("mainfun"));
			map.put("ver", (String) resultArrayList.get(i).get("ver"));
			backList.add(map);
		}

		Map<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("result", backList);
		return backMap;

	}

	// addPackage
	@RequestMapping("addPackage")
	@ResponseBody
	public String addPackage(@RequestParam Map<String, String> map)
			throws Exception {
		String packageName = map.get("packageName");
		String funDetail = map.get("funDetail");
		String plat = map.get("plat");
		String comid = map.get("comid");
		String[] key = { "packageName", "funDetail", "plat", "comid" };
		Object[] value = { packageName, funDetail, plat, comid };
		ArrayList<HashMap<String, Object>> resultArrayList;

		resultArrayList = WebServiceUtil.getWebServiceMsg(key, value,
				"addPackage", WebServiceUtil.HUIWEI_PM_URL,
				WebServiceUtil.HUIWEI_PM_NAMESPACE);

		String result = (String) resultArrayList.get(0).get(0);
		return result;

	}

	// 增加app
	@RequestMapping("addPackageVersion")
	@ResponseBody
	public Map<String, Object> addPackageVersion(
			@RequestParam Map<String, String> map) throws Exception {
		String puhdate = map.get("puhdate");
		String ver = map.get("ver");
		String packageid = map.get("packageid");
		String modifyDetail = map.get("modifyDetail");
		String filepath = map.get("filepath");
		String ismust = map.get("ismust");
		String[] key = { "puhdate", "ver", "packageid", "modifyDetail",
				"filepath", "ismust" };
		Object[] value = { puhdate, ver, packageid, modifyDetail, filepath,
				ismust };
		ArrayList<HashMap<String, Object>> resultArrayList = WebServiceUtil
				.getWebServiceMsg(key, value, "addPackageVersion",
						WebServiceUtil.HUIWEI_PM_URL,
						WebServiceUtil.HUIWEI_PM_NAMESPACE);
		System.out.println(resultArrayList);

		return (Map<String, Object>) resultArrayList;

	}

	// 上传文件
	@RequestMapping(value = "upload", produces = "application/json; charset=utf-8")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public String upload(HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String saveFilePath = "";
		MultipartFile file = multipartRequest.getFile("file");
		String backStr = "";
		if (file != null) {
			String fileName = request.getParameter("fileName");
			InputStream input = file.getInputStream();
			byte[] data = new byte[input.available()];
			input.read(data);
			input.close();
			String baseString = Base64.encode(data);
			String[] key = { "fileBytesstr", "fileName" };
			Object[] value = { baseString, fileName };
			backStr = WebServiceUtil.putWebServiceMsg(key, value, "UploadFile",
					WebServiceUtil.URL);
			String filePath = backStr + ";";
			filePath = WebServiceUtil.UPLOADSPACE
					+ filePath.substring(2, filePath.length());
			saveFilePath = saveFilePath + filePath;
			System.out.println(saveFilePath);
		}
		ObjectMapper mapper = new ObjectMapper();
		return mapper.writeValueAsString(saveFilePath);
	}

	// 获取用户登录后公司信息的选择
	@RequestMapping("GoIndexPage")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView GoIndexPage(String Emid, HttpSession session)
			throws Exception {

		ModelAndView modelAndView = new ModelAndView("index");
		System.out.println(Emid);
		modelAndView.addObject("Emid", Emid);
		session.setAttribute("Emid", Emid);

		return modelAndView;

	}

	@RequestMapping("fileupload")
	public void fileupload(HttpServletRequest request,
			HttpServletResponse response, String loginName) throws Exception {
		// 获取服务器中保存文件的路径
		String path = request.getSession().getServletContext().getRealPath("")
				+ "\\upload\\record\\";
		System.out.println(path);
		// 获取解析器
		CommonsMultipartResolver resolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 判断是否是文件
		if (resolver.isMultipart(request)) {
			// 进行转换
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);
			// 获取所有文件名称
			Iterator<String> it = multiRequest.getFileNames();
			while (it.hasNext()) {
				// 根据文件名称取文件
				MultipartFile file = multiRequest.getFile(it.next());
				String fileName = file.getOriginalFilename();
				String localPath = path + fileName;
				// 创建一个新的文件对象，创建时需要一个参数，参数是文件所需要保存的位置
				File newFile = new File(localPath);
				// 上传的文件写入到指定的文件中
				file.transferTo(newFile);
			}
		}
	}

	// 获取用户登录后公司信息的选择(公文标题，整改内容等)
	@RequestMapping("getGovern")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView getGovern(String Emid, HttpSession session)
			throws Exception {
		int emid = new Integer(Emid).intValue();

		ModelAndView modelAndView = new ModelAndView("Govern");

		String[] key1 = { "Emid", "DayCount", "TopCount", "InfoID", "viewed" };// 获取公文key
		Object[] value1 = { emid, 365, 20, 0, false };
		String[] key2 = { "uEmid", "isFinished", "isReviewed", "cStart",
				"cEnd", "hgrade", "areaRangeID", "industryStr", "objOrgName" };// 获取整改信息key
		// 获取以前的时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.YEAR, -1);
		Date y = c.getTime();
		String year = format.format(y);
		// 获取现在的时间
		String now = format.format(new Date());

		Object[] value2 = { emid, 2, 0, year, now, "", 0, "",
				(String) session.getAttribute("orgname") };
		ArrayList<HashMap<String, Object>> resultArrayList1;
		ArrayList<HashMap<String, Object>> resultArrayList2;
		ArrayList<Map<String, String>> TitleList = new ArrayList<Map<String, String>>();
		ArrayList<Map<String, String>> GovernList = new ArrayList<Map<String, String>>();
		// 获取公文信息标题
		resultArrayList1 = WebServiceUtil.getWebServiceMsg(key1, value1,
				"getWebInformFroEmID", WebServiceUtil.HUIWEI_INFO,
				WebServiceUtil.HUIWEI_NAMESPACE);

		for (int i = 0; i < resultArrayList1.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("InfoID", (String) resultArrayList1.get(i).get("InfoID"));// 公文id
			map.put("InfoTitle",
					(String) resultArrayList1.get(i).get("InfoTitle"));// 公文标题
			map.put("CDocID", (String) resultArrayList1.get(i).get("CDocID"));// 关联的智能文档
			map.put("InfoWriter",
					(String) resultArrayList1.get(i).get("InfoWriter"));// 撰写人员姓名
			map.put("InfoNumber",
					(String) resultArrayList1.get(i).get("InfoNumber"));// 公文标号
			map.put("PubDate", (String) resultArrayList1.get(i).get("PubDate"));// 公文发布日期
			map.put("PubComname",
					(String) resultArrayList1.get(i).get("PubComname"));// 发布单位简称
			map.put("puborgname",
					(String) resultArrayList1.get(i).get("puborgname"));// 发布单位全称
			map.put("pubobj", (String) resultArrayList1.get(i).get("pubobj"));// 发布对象
			map.put("Emid", Emid);// 发布对象
			String state = (String) resultArrayList1.get(i).get("viewed");
			if (state.equals("0")) {// 未阅
				map.put("state", "未阅");
			} else {
				map.put("state", "已阅");
			}
			TitleList.add(map);
		}

		// 获取整改信息
		resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2,
				"getAllHiddenIllness", WebServiceUtil.HUIWEI_SAFE_URL,
				WebServiceUtil.HUIWEI_NAMESPACE);
		for (int i = 0; i < resultArrayList2.size(); i++) {
			Map<String, String> map2 = new HashMap<String, String>();

			map2.put("hTroubleID",
					(String) resultArrayList2.get(i).get("hTroubleID"));// 隐患id
			map2.put("safetyTrouble",
					(String) resultArrayList2.get(i).get("safetyTrouble"));// 隐患描述
			map2.put("actionOrgName",
					(String) resultArrayList2.get(i).get("actionOrgName"));// 临检单位名称
			String checkDate = (String) resultArrayList2.get(i)
					.get("checkDate");
			if (checkDate != null && !checkDate.equals("")) {
				int cutNum = checkDate.lastIndexOf("T");
				checkDate = checkDate.substring(0, cutNum);
				map2.put("checkDate", checkDate);// 日期
			}
			GovernList.add(map2);
		}

		modelAndView.addObject("TitleList", TitleList);
		modelAndView.addObject("GovernList", GovernList);

		return modelAndView;

	}

	// 验证新用户名是否可以用
	@RequestMapping("verifyName")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, String> verifyName(String newName) throws Exception {

		Map<String, String> backMap = new HashMap<String, String>();

		String[] key = { "requestName", "mphone", "openidstr", "pwd" };

		Object[] value = { newName, "", "", "" };

		ArrayList<HashMap<String, Object>> resultList = WebServiceUtil
				.getWebServiceMsg(key, value, "getSinglePersonalUserFromLogin",
						WebServiceUtil.HUIWEI_URL,
						WebServiceUtil.HUIWEI_NAMESPACE);
		String ret = ((String) resultList.get(0).get("ret"));
		if (ret.equals("0")) {
			backMap.put("result", "lose");// 已存在
		} else {
			backMap.put("result", "suc");// 可以使用
		}
		return backMap;

	}

	// 修改用户名
	@RequestMapping("userSetMessage")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, String> userSetMessage(
			@RequestParam Map<String, String> map, HttpSession session)
			throws Exception {

		Map<String, String> backMap = new HashMap<String, String>();

		String emid = (String) session.getAttribute("Emid");

		String name = map.get("newname");

		String oldpwd = map.get("oldpwd");

		String newpwd = map.get("newpwd");

		String phone = map.get("phone");

		String[] key = { "requestName", "mphone", "openidstr", "pwd", "ret" };

		Object[] value = { name, "", "", oldpwd, -1 };

		ArrayList<HashMap<String, Object>> resultList = WebServiceUtil
				.getWebServiceMsg(key, value, "getSinglePersonalUserFromLogin",
						WebServiceUtil.HUIWEI_URL,
						WebServiceUtil.HUIWEI_NAMESPACE);
		// System.out.println("结果集"+resultList.size());
		String ret = ((String) resultList.get(0).get("ret"));
		if (ret.equals("0")) {// 错误
			backMap.put("result", "lose");
			return backMap;
		} else {
			String[] key2 = { "requestName", "mphone", "email", "pwd", "ret" };
			Object[] value2 = { (String) session.getAttribute("nike"), "", "",
					oldpwd, -1 };
			ArrayList<HashMap<String, Object>> resultArrayList2;

			resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2,
					"getSinglePersonalUserFromLogin",
					WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
			if (resultArrayList2.size() == 0) {// 密码错误
				backMap.put("result", "misspwd");
				return backMap;
			}

			String[] key3 = { "uPeopleID", "oldPWord", "newPWord",
					"newNickName", "uState", "setSysUser", "mPhone" };
			String valString = (String) session.getAttribute("PUserID");

			Object[] value3 = { new Integer(valString).intValue(), oldpwd,
					newpwd, name, true, true, phone };
			// Object[] value3 = { 47867,"110868",
			// "654321","zhangbaoliang",true,true,""};
			ArrayList<HashMap<String, Object>> resultList5 = WebServiceUtil
					.getWebServiceMsg(key3, value3, "setPersonalUser",
							WebServiceUtil.HUIWEI_URL,
							WebServiceUtil.HUIWEI_NAMESPACE);
			if (resultList5.size() > 0) {

				System.err.println(resultList5.get(0).toString());
			} else {
				System.err.println("没有结果集");
			}
		}

		backMap.put("result", "success");
		return backMap;

	}

}
