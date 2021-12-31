package com.pj.controller.user;

import java.lang.ProcessBuilder.Redirect;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pj.domain.FoodVO;
import com.pj.domain.ResellVO;
import com.pj.domain.UserVO;
import com.pj.service.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@GetMapping("/login")
	public String getLogin() {
		
		return "user/login";
	}
	
	@PostMapping("/login")
	public String postLogin(String email,String password,HttpSession session) {
		UserVO vo = userService.getUserEmail(email);
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
		if(userService.insert(vo)) {
			return "redirect:/";
		}else {
			return "redirect:/user/join";
		}
	}
	
	@RequestMapping("/checkEmail")
	@ResponseBody
	public String emailCheck(@RequestBody Map<String, Object> req) {
		String email = (String) req.get("email");
		String message = userService.checkEmail(email);
		return message;
	}
	
	@RequestMapping("/userDetail")
	public String userDetail() {
		return "user/userDetail";
	}
	
	@RequestMapping({"/adminDetail/{path}","/adminDetail"})
	public String adminDetail(Model model,@PathVariable(required = false) String path) {
		
		if(path == null) {
			path ="null";
		}
		if(path.equals("user")) {
			List<UserVO> vo = userService.getUserList();
			model.addAttribute("path","user");
			model.addAttribute("userList",vo);			
		}
		
		if(path.equals("food")) {
			List<FoodVO> vo = userService.getFoodList();
			model.addAttribute("path","food");
			model.addAttribute("foodList",vo);
		}
		
		if(path.equals("resell")) {
			List<ResellVO> vo = userService.getResellList();
			model.addAttribute("path","resell");
			model.addAttribute("resellList",vo);
		}
		
		if(path.equals("community")) {
			List<ResellVO> vo = userService.getCommunityList();
			model.addAttribute("path","community");
			model.addAttribute("communityList",vo);
		}
		
		return "user/adminDetail";
	}
	
	@RequestMapping("/edit")
	public String edit() {
		
		return "user/edit";
	}
	
	@PostMapping("/update")
	public String update(UserVO vo,HttpSession session) {
		boolean ok = userService.update(vo);
		if(ok) {
			session.setAttribute("loggedUser", userService.getUserEmail(vo.getEmail()));
			return "redirect:/";
		}else {
			return "redirect:/user/userDetail";
		}
	}
	
	@PostMapping("/userDelete")
	public String userDetele(String emailInfo,HttpSession session) {
		System.out.println("work");
//		boolean ok = userService.deleteUserEmail(emailInfo);
//		System.out.println(ok);
//		if(ok) {
//			session.invalidate();
//			return "redirect:/";
//		}else {
//			return "redirect:/user/edit";
//		}
		return "redirect:/user/edit";
	}
	
	@PostMapping("/adminDelete")
	public String adminDelete() {
		
		return "redirect:/user/adminDetail";
	}
	
}
