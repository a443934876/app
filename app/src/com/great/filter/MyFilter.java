package com.great.filter;

import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
  

import org.springframework.web.servlet.ModelAndView;  
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
  
 
  
public class MyFilter extends HandlerInterceptorAdapter {  
  
    private static final String LOGIN_URL = "jsp/Loginpage.jsp";  
    
    private static final String COMPANY_URL = "jsp/MoreComs.jsp";
  
    @Override  
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {  
        HttpSession session = req.getSession(true);  
        
        String Uid = (String)session.getAttribute("Uid"); 
        String comid = (String)session.getAttribute("comid");
        // 判断如果没有取到用户信息，就跳转到登陆页面，提示用户进行登陆  
       
        
        String imgcode = req.getRequestURI().substring(req.getRequestURI().lastIndexOf("/")+1);
        System.err.println(req.getRequestURI());
      //如果是ajax请求响应头会有x-requested-with
        if(req.getHeader("x-requested-with") != null){
        	return true;
        }
        
        if(imgcode.equals("imgCode")){
        	return true;
        }else if (imgcode.equals("login")) {
        	return true;
		}else{
        	
        	if (Uid == null || "".equals(Uid)) {  
        		res.sendRedirect(LOGIN_URL);  
        		return false;
        	}
        	if(imgcode.equals("GoIndexPage")){
        		return true;
        	}
        	if(comid == null || "".equals(comid)){
        		res.sendRedirect(COMPANY_URL); 
        		return false;
        	}
        	return true;  
        }
        
    }  
  
    @Override  
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object arg2, ModelAndView arg3) throws Exception {  
    }  
  
    @Override  
    public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object arg2, Exception arg3) throws Exception {  
    }

	
  
}  
