package com.pj.filter;

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

import com.pj.domain.ResellMemberVO;

/**
 * Servlet Filter implementation class CheckLoginFilter
 */
public class CheckLogInFilter implements Filter {

    /**
     * Default constructor. 
     */
    public CheckLogInFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		System.out.println("CheckLoginFilter 실행");
		
		// session attribute loggedMember가 있으면 계속 진행
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		ResellMemberVO vo = (ResellMemberVO) session.getAttribute("loggedInMember");
		
		
		if (vo == null) {
			// 없으면 /member/login 으로 redirect
			HttpServletResponse res = (HttpServletResponse) response;
			String location = req.getContextPath() + "/resellMarket/resellMember/login";
			res.sendRedirect(location);
		} else {
			chain.doFilter(request, response);
		}
		
		// pass the request along the filter chain
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
