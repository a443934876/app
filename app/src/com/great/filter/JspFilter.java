package com.great.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JspFilter implements Filter{

	@Override
	public void destroy() {
	
		
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		HttpServletRequest request = (HttpServletRequest) arg0;
		
		HttpServletResponse response = (HttpServletResponse) arg1;
		
		HttpSession session = request.getSession();
		
		
		String Uid = (String)session.getAttribute("Uid"); 
		
        String comid = (String)session.getAttribute("comid");
		String requestUrl = request.getRequestURI();
		
		 if(requestUrl.endsWith("Loginpage.jsp")){
			arg2.doFilter(request, response);
			return;
		}else{
			 if (Uid == null || "".equals(Uid)) {  
		        	
		        	response.sendRedirect("../jsp/Loginpage.jsp");
		        	
		        }
		        else if(comid == null || "".equals(comid)){
		        	 
		        	 request.getRequestDispatcher("MoreComs.jsp").forward(arg0, arg1);
		        	 arg2.doFilter(request, response);
		        }else{
		        	arg2.doFilter(request, response);
					return;
		        }
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
