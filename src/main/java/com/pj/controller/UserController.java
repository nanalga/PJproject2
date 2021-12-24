package com.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pj.service.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userSerivce;
	
	@RequestMapping("")
	public String info(Model model) {
		
		String userInfo = userSerivce.getUserInfo();
		model.addAttribute("info", userInfo);
		return "user/info";
	}
}
