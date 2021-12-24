package com.pj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/")
public class HomeController {
	
	@RequestMapping("")
	public String home() {
		System.out.println("work");
		return "home";
	}
	
}
