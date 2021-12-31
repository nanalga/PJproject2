package com.pj.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@GetMapping("/login")
	public String login() {
		System.out.println();
		return "admin/login";
	}
	
	@PostMapping("/login")
	public String login(String email,String password) {
		System.out.println(email+password);
		return "redirect:/admin/login";
	}
	
	@RequestMapping("/detail")
	public String adminDetail() {
		
		return "admin/detail";
	}
	
}
