package com.pj.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Value;

/**
 * Application Lifecycle Listener implementation class AppListener
 *
 */
public class AppListener implements ServletContextListener {

	@Value("${naver.client_id}")
	private String naver_client_id;
	
	@Value("${naver_client_secret")
	private String naver_client_secret;
	
    /**
     * Default constructor. 
     */
    public AppListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    	ServletContext app = sce.getServletContext();
    	
    	app.setAttribute("naver_client_id", naver_client_id);
    	app.setAttribute("naver_client secret", naver_client_secret);
    }
	
}
