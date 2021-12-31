package com.pj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.ResellMemberVO;
import com.pj.service.ResellMemberService;

import lombok.Setter;


@Controller
@RequestMapping("/resellMarket/resellMember")
public class ResellMemberController {
		
		@Setter(onMethod_ = @Autowired)
		private ResellMemberService service;
		
		@RequestMapping("/resellMember")
		public void methodtest() {
			System.out.println("이거 잘 실행되니?");
		}
		
		
		@GetMapping("/signup")
		public void signup() {
			
		}
		
		@PostMapping("/signup")
		public String signup(@ModelAttribute("resellMember") ResellMemberVO resellMember, RedirectAttributes rttr, Model model) {
		 ResellMemberVO m = service.select(resellMember.getId());
			
			if ( m == null) {
				
				boolean ok = service.register(resellMember);
				
				if(ok) {
					rttr.addFlashAttribute("result",resellMember.getId() + "님 회원가입 축하드립니다");
					return "redirect:/resellMarket/resellBoard/resellBoardList";
				} else {
					return "redirect:/resellMarket/resellMember/signup";
				}
		
			} else {
				model.addAttribute("alertMessage", "아이디가 이미 존재합니다");
				return null;
			}
		}
		
		@GetMapping("/login")
		public void login() {
			
		}
		
		@PostMapping("/login") 
		public String login(String id, String password, HttpSession session) {
			// service로 아이디로 멤버 vo얻고
			ResellMemberVO vo = service.select(id);
			
			System.out.println(vo);
			if( vo == null) {
				return null;
			}
			
			// 얻어온 멤버vo의 pw와 입력한 pw 같은지 확인
			boolean correctPassword = password.equals(vo.getPassword());
			
			// ResellMemberVO가 null or dif pw  login error
			if (!correctPassword) {
				return null;
			}
			
			// 멤버vo not null, pw.equals.vo.getpw login success
			
			session.setAttribute("loggedInMember", vo);
			
			System.out.println(session.getAttribute("loggedInMember"));
			
			return "redirect:/resellMarket/resellBoard/resellBoardList";
		}
		
		@RequestMapping("/logout")
		public String logout (HttpSession session) {
			// invalidate
			session.invalidate();
			
			// resellBoard/resellBoardList
			return "redirect:/resellMarket/resellBoard/resellBoardList";
		}
		
		@GetMapping("/info")
		public String info(HttpSession session, RedirectAttributes rttr) {
			/* 일단 필터로
			ResellMemberVO vo = (ResellMemberVO) session.getAttribute("loggedInMember");
			
			// 로그아웃
			if (vo == null) {
				return "redirect:/resellMarket/resellMember/login";
			}
			*/
			// 로그인상태일떄
			
			return null;
		}
		
		
		@PostMapping("/info")
		public String info(ResellMemberVO resellMember, HttpSession session, RedirectAttributes rttr) {
			
			/* 일단 필터로
			ResellMemberVO vo = (ResellMemberVO) session.getAttribute("loggedMember");
			// 로그아웃
			if (vo == null) {
				return "redirect:/resellMarket/resellMember/login";
			}
			*/
			
			// 로그인된 상태
			boolean ok = service.modify(resellMember);
			
			if (ok) {
				rttr.addFlashAttribute("result", resellMember.getId() + "님의 회원정보가 변경되었습니다.");
				session.setAttribute("loggedInMember", service.select(resellMember.getId()));
			} else {
				rttr.addFlashAttribute("result", resellMember.getId() + "님의 회원정보가 변경되지 않았습니다.");
			}
			rttr.addAttribute("id", resellMember.getId());
			
			return "redirect:/resellMarket/resellBoard/resellBoardList";
		}
		
		@PostMapping("/remove")
		public String remove(String id, HttpSession session, RedirectAttributes rttr) {
			/* 일단 필터로
			ResellMemberVO vo = (ResellMemberVO) session.getAttribute("loggedInMember");
			// 로그아웃
			if (vo == null) {
				return "redirect:/resellMarket/resellMember/login";
			}
			*/
			
			//로그인된 상태
			service.remove(id);
			
			rttr.addFlashAttribute("result","회원 탈퇴하셨습니다");
			
			
			return "redirect:/resellMarket/resellBoard/resellBoardList";
		}
		
		@GetMapping("/memberList")
		public String list(Model model, HttpSession session)  {
			/*
			// 로그인 안되있으면 로그인 화면으로 redirect
			ResellMemberVO vo = (ResellMemberVO) session.getAttribute("loggedMember");
			// 로그아웃
			if (vo == null) {
				return "redirect:/resellMarket/resellMember/login";
			}
			 */
			
			
			List<ResellMemberVO> memberList = service.getList();
			
			model.addAttribute("memberList", memberList);
			
			return null;
			
		}
		
		
}















