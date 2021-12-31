package com.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.CommunityFreeMemberVO;
import com.pj.service.CommunityFreeMemberService;

import lombok.Setter;

@Controller
@RequestMapping("/community")
public class CommunityFreeMemberController {
	
	@Setter(onMethod_ = @Autowired)
	private CommunityFreeMemberService service;
	
	@GetMapping("/community_signup")
	public void signup() {
		
	}
	
	public String signup(CommunityFreeMemberVO comFreeMember, RedirectAttributes rttr) {
		boolean ok = service.register(comFreeMember);
		
		if(ok) {
			rttr.addFlashAttribute("success", "회원가입 완료");
			return "redirect:/community/community_FreeBoard";
		} else {
			return "redirect:/community/community_signup";
		}
	}
}
