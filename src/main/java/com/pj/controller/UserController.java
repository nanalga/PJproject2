package com.pj.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj.domain.UserVO;
import com.pj.service.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userSerivce;
	
	@RequestMapping("")
	public String dbCheck(Model model) {
		System.out.println("user controller work");
		String userInfo = userSerivce.getUserInfo();
		model.addAttribute("info", userInfo);
		return "user/dbCheck";
	}
	
	@GetMapping("/login")
	public String getLogin() {
		
		return "user/login";
	}
	
	@PostMapping("/login")
	public String postLogin(String email,String password,HttpSession session) {
//		System.out.println(email+":"+password);
		UserVO vo = userSerivce.getUser(email);
//		System.out.println(vo);
		if(vo != null&&vo.getPassword().equals(password)) {
			session.setAttribute("loggedUser", vo);
			return "redirect:/";
		}
		return "redirect:/user/login";
	}
	
	@GetMapping("/join")
	public String getJoin() {
		
		return "user/join";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("/join")
	public String postJoin(UserVO vo) {
		if(userSerivce.insert(vo)) {
			return "redirect:/";
		}else {
			return "redirect:/user/join";
		}
	}
	
	@RequestMapping("/join/checkEmail")
	@ResponseBody
	public String emailCheck(@RequestBody Map<String, Object> req) {
		System.out.println("access");
		String email = (String) req.get("email");
		String message = userSerivce.checkEmail(email);
		return message;
	}
	
	@RequestMapping("/userDetail")
	public String userDetail() {
		
		return "user/userDetail";
	}
	
	@RequestMapping("/adminDetail")
	public String adminDetail() {
		
		return "user/adminDetail";
	}
	
}
