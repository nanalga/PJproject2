package com.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.FoodExMemberVO;
import com.pj.service.FoodExMemberService;

import lombok.Setter;

@Controller
@RequestMapping("/food")
public class FoodMemberController_EX {
	
	@Setter(onMethod_ = @Autowired)
	private FoodExMemberService service;
	
	@RequestMapping("/nickNameCheck")
	@ResponseBody
	public String foodExNickNameCheck(String nickName) {
		System.out.println(nickName);
		boolean has = service.foodExHasNickName(nickName);
		
		if(has) {
			System.out.println(has);
			return "unable";
		} else {
			System.out.println(has);
			return "able";
		}
	}
	
	@RequestMapping("/idcheck")
	@ResponseBody
	public String foodExIdcheck(String id) {
		
		boolean has = service.foodExHasId(id);
		
		if(has) {
			return "unable";
		} else {
			return "able";
		}
		
	}
	
	@GetMapping("/foodExSignup")
	public void signup() {
		
	}
	
	@PostMapping("/foodExSignup")
	public String signup(@ModelAttribute("member") FoodExMemberVO member, RedirectAttributes rttr, Model model) {
		FoodExMemberVO m = service.foodExMemberRead(member.getId());

		if (m == null) {

			boolean ok = service.foodExMemberregister(member);

			if (ok) {
				rttr.addFlashAttribute("result", "회원가입이 완료되었습니다.");
				return "redirect:/board/list";
			} else {
				return "redirect:/member/signup";
			}
		} else {
			model.addAttribute("alertMessage", "중복된 아이디 입니다.");
			return null;
		}
	}
	
}
