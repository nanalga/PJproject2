package com.pj.filter.userFilter;

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

import com.pj.domain.user.UserVO;

/**
 * Servlet Filter implementation class CheckLogInFilter
 */
public class CheckUserLogOutFilter implements Filter {

    /**
     * Default constructor. 
     */
    public CheckUserLogOutFilter() {
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
		
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
				
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		
		if(vo == null) {
			HttpServletResponse res = (HttpServletResponse) response;
			String location = req.getContextPath() + "/user/login";
			res.sendRedirect(location);
		}else {
			chain.doFilter(request, response);
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
