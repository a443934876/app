package com.great.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.codehaus.jackson.map.ObjectMapper;
import org.kobjects.base64.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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

	// 删除版本
	@RequestMapping("dropPackageVersion")
	@ResponseBody
	public String dropPackageVersion(@RequestParam("pveridlist") String list)
			throws Exception {
		String result = "";
		JSONArray nameArray = (JSONArray) JSONArray.fromObject(list);
		System.out.println(nameArray.size());
		for (Object js : nameArray) {
			JSONObject json = (JSONObject) js;
			String[] key = { "pverid" };
			Object[] value = { json.get("proverid") };
			ArrayList<HashMap<String, Object>> resultArrayList = WebServiceUtil
					.getWebServiceMsg(key, value, "dropPackageVersion",
							WebServiceUtil.HUIWEI_PM_URL,
							WebServiceUtil.HUIWEI_PM_NAMESPACE);
			result = result + (String) resultArrayList.get(0).get(0) + ";";

		}

		return result;

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
			map.put("fpath", (String) resultArrayList.get(i).get("fpath"));
			map.put("proverid", (String) resultArrayList.get(i).get("proverid"));
			map.put("proname", (String) resultArrayList.get(i).get("proname"));
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
	public String addPackageVersion(@RequestParam Map<String, String> map)
			throws Exception {
		String puhdate = map.get("puhdate");
		String ver = map.get("ver");
		String packageid = map.get("packageid");
		String modifyDetail = map.get("modifyDetail");
		String filepath = map.get("filepath");
		String ismust = map.get("ismust");
		System.out.println(filepath);
		String[] key = { "puhdate", "ver", "packageid", "modifyDetail",
				"filepath", "ismust" };
		Object[] value = { puhdate, ver, packageid, modifyDetail, filepath,
				ismust };
		ArrayList<HashMap<String, Object>> resultArrayList = WebServiceUtil
				.getWebServiceMsg(key, value, "addPackageVersion",
						WebServiceUtil.HUIWEI_PM_URL,
						WebServiceUtil.HUIWEI_PM_NAMESPACE);
		System.out.println(resultArrayList);
		String result = (String) resultArrayList.get(0).get(0);
		return result;

	}

	@RequestMapping("exit")
	@ResponseBody
	public HttpSession exit(HttpSession session) throws Exception {
		session.invalidate();
		return session;

	}

	// 上传文件
	@RequestMapping(value = "upload", produces = "application/json; charset=utf-8")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public String upload(HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String saveFilePath = "";
		MultipartFile file = multipartRequest.getFile("file");
		System.out.println("file" + file);
		String backStr = "";
		if (file != null) {
			String fileName = request.getParameter("fileName");
			System.out.println("fileName" + fileName);
			InputStream input = file.getInputStream();
			byte[] data = new byte[input.available()];
			System.out.println("data" + data);
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
	public ModelAndView GoIndexPage(String comid, HttpSession session)
			throws Exception {

		ModelAndView modelAndView = new ModelAndView("index");
		System.out.println(comid);
		modelAndView.addObject("comid", comid);
		session.setAttribute("comid", comid);

		return modelAndView;

	}

}
