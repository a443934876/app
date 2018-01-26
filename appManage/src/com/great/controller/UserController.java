package com.great.controller;

import java.awt.List;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.stereotype.Controller;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public Map<String, Object> login(@RequestParam Map<String, String> map, HttpSession session) throws Exception {
		/**
		 * 用户登陆验证
		 */
		Map<String, Object> backMap = new HashMap<String, Object>();
		String nike = map.get("nike");
		String pwd = map.get("pwd");
		String[] key = { "requestName", "mphone", "email", "pwd", "ret" };
		Object[] value = { nike, "", "", pwd, -1 };
		ArrayList<HashMap<String, Object>> resultArrayList;
		try {
			resultArrayList = WebServiceUtil.getWebServiceMsg(key, value, "getSinglePersonalUserFromLogin",
					WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
			String ret = (String) resultArrayList.get(0).get("ret");
			if (ret.equals("-1")) {
				backMap.put("result", "lose");
				return backMap;
			}
			if (ret.equals("0")) {

				backMap.put("result", "success");
				System.out.println(resultArrayList.get(0).toString() + "******");
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
	public Map<String, Object> getCompany(String personId, HttpSession session) throws Exception {

		String[] key = { "uPersonalID", "sState" };
		Object[] value = { personId, "在职" };
		ArrayList<HashMap<String, Object>> resultArrayList;

		resultArrayList = WebServiceUtil.getWebServiceMsg(key, value, "getMoreComs", WebServiceUtil.HUIWEI_URL,
				WebServiceUtil.HUIWEI_NAMESPACE);
		// 返回到前端的集合
		ArrayList<Object> backList = new ArrayList<Object>();
		for (int i = 0; i < resultArrayList.size(); i++) {

			Map<String, String> map = new HashMap<String, String>();
			map.put("Emids", (String) resultArrayList.get(i).get("Emid"));
			map.put("comname", (String) resultArrayList.get(i).get("comname"));
			backList.add(map);
		}
		if (resultArrayList.size() == 1) {
			session.setAttribute("Emid", (String) resultArrayList.get(0).get("Emid"));
			session.setAttribute("orgidstr", (String) resultArrayList.get(0).get("orgidstr"));
			session.setAttribute("orgname", (String) resultArrayList.get(0).get("orgname"));
		}
		Map<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("result", backList);
		return backMap;

	}

	// 获取用户登录后公司信息的选择(公文标题，整改内容等)
	@RequestMapping("GoIndexPage")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView GoIndexPage(String Emid, HttpSession session) throws Exception {

		ModelAndView modelAndView = new ModelAndView("indexMenu");

		modelAndView.addObject("Emid", Emid);
		session.setAttribute("Emid", Emid);

		return modelAndView;

	}

	// 获取用户登录后公司信息的选择(公文标题，整改内容等)
	@RequestMapping("getGovern")
	@Transactional(rollbackFor = Exception.class)
	public ModelAndView getGovern(String Emid, HttpSession session) throws Exception {
		int emid = new Integer(Emid).intValue();

		ModelAndView modelAndView = new ModelAndView("Govern");

		String[] key1 = { "Emid", "DayCount", "TopCount", "InfoID", "viewed" };// 获取公文key
		Object[] value1 = { emid, 365, 20, 0, false };
		String[] key2 = { "uEmid", "isFinished", "isReviewed", "cStart", "cEnd", "hgrade", "areaRangeID", "industryStr",
				"objOrgName" };// 获取整改信息key
		// 获取以前的时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.YEAR, -1);
		Date y = c.getTime();
		String year = format.format(y);
		// 获取现在的时间
		String now = format.format(new Date());

		Object[] value2 = { emid, 2, 0, year, now, "", 0, "", (String) session.getAttribute("orgname") };
		ArrayList<HashMap<String, Object>> resultArrayList1;
		ArrayList<HashMap<String, Object>> resultArrayList2;
		ArrayList<Map<String, String>> TitleList = new ArrayList<Map<String, String>>();
		ArrayList<Map<String, String>> GovernList = new ArrayList<Map<String, String>>();
		// 获取公文信息标题
		resultArrayList1 = WebServiceUtil.getWebServiceMsg(key1, value1, "getWebInformFroEmID",
				WebServiceUtil.HUIWEI_INFO, WebServiceUtil.HUIWEI_NAMESPACE);

		for (int i = 0; i < resultArrayList1.size(); i++) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("InfoID", (String) resultArrayList1.get(i).get("InfoID"));// 公文id
			map.put("InfoTitle", (String) resultArrayList1.get(i).get("InfoTitle"));// 公文标题
			map.put("CDocID", (String) resultArrayList1.get(i).get("CDocID"));// 关联的智能文档
			map.put("InfoWriter", (String) resultArrayList1.get(i).get("InfoWriter"));// 撰写人员姓名
			map.put("InfoNumber", (String) resultArrayList1.get(i).get("InfoNumber"));// 公文标号
			map.put("PubDate", (String) resultArrayList1.get(i).get("PubDate"));// 公文发布日期
			map.put("PubComname", (String) resultArrayList1.get(i).get("PubComname"));// 发布单位简称
			map.put("puborgname", (String) resultArrayList1.get(i).get("puborgname"));// 发布单位全称
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
		resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2, "getAllHiddenIllness",
				WebServiceUtil.HUIWEI_SAFE_URL, WebServiceUtil.HUIWEI_NAMESPACE);
		for (int i = 0; i < resultArrayList2.size(); i++) {
			Map<String, String> map2 = new HashMap<String, String>();

			map2.put("hTroubleID", (String) resultArrayList2.get(i).get("hTroubleID"));// 隐患id
			map2.put("safetyTrouble", (String) resultArrayList2.get(i).get("safetyTrouble"));// 隐患描述
			map2.put("actionOrgName", (String) resultArrayList2.get(i).get("actionOrgName"));// 临检单位名称
			String checkDate = (String) resultArrayList2.get(i).get("checkDate");
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

		ArrayList<HashMap<String, Object>> resultList = WebServiceUtil.getWebServiceMsg(key, value,
				"getSinglePersonalUserFromLogin", WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
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
	public Map<String, String> userSetMessage(@RequestParam Map<String, String> map, HttpSession session)
			throws Exception {

		Map<String, String> backMap = new HashMap<String, String>();

		String emid = (String) session.getAttribute("Emid");

		String name = map.get("newname");

		String oldpwd = map.get("oldpwd");

		String newpwd = map.get("newpwd");

		String phone = map.get("phone");

		String[] key = { "requestName", "mphone", "openidstr", "pwd", "ret" };

		Object[] value = { name, "", "", oldpwd, -1 };

		ArrayList<HashMap<String, Object>> resultList = WebServiceUtil.getWebServiceMsg(key, value,
				"getSinglePersonalUserFromLogin", WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
		// System.out.println("结果集"+resultList.size());
		String ret = ((String) resultList.get(0).get("ret"));
		if (ret.equals("0")) {// 错误
			backMap.put("result", "lose");
			return backMap;
		} else {
			String[] key2 = { "requestName", "mphone", "email", "pwd", "ret" };
			Object[] value2 = { (String) session.getAttribute("nike"), "", "", oldpwd, -1 };
			ArrayList<HashMap<String, Object>> resultArrayList2;

			resultArrayList2 = WebServiceUtil.getWebServiceMsg(key2, value2, "getSinglePersonalUserFromLogin",
					WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
			if (resultArrayList2.size() == 0) {// 密码错误
				backMap.put("result", "misspwd");
				return backMap;
			}

			String[] key3 = { "uPeopleID", "oldPWord", "newPWord", "newNickName", "uState", "setSysUser", "mPhone" };
			String valString = (String) session.getAttribute("PUserID");

			Object[] value3 = { new Integer(valString).intValue(), oldpwd, newpwd, name, true, true, phone };
			// Object[] value3 = { 47867,"110868", "654321","zhangbaoliang",true,true,""};
			ArrayList<HashMap<String, Object>> resultList5 = WebServiceUtil.getWebServiceMsg(key3, value3,
					"setPersonalUser", WebServiceUtil.HUIWEI_URL, WebServiceUtil.HUIWEI_NAMESPACE);
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
