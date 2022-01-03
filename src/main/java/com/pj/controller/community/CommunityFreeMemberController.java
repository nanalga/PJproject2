package com.pj.controller.community;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.community.CommunityFreeMemberVO;
import com.pj.service.community.CommunityFreeMemberService;

import lombok.Setter;

@Controller
@RequestMapping("/community/communityMember")
public class CommunityFreeMemberController {
	
	@Setter(onMethod_ = @Autowired)
	private CommunityFreeMemberService service;
	
	@RequestMapping("/nickNameCheck")
	@ResponseBody
	public String nickNameCheck(String nickName) {
		boolean has = service.hasNickName(nickName);
		
		if (has) {
			return "unable";
		} else {
			return "able";
		}
	}
	
	
	@GetMapping("/community_signup")
	public void signup() {
		
	}
	
	@PostMapping("/community_signup")
	public String signup(@ModelAttribute("comFreeMember") CommunityFreeMemberVO comFreeMember, RedirectAttributes rttr, Model model) {
		CommunityFreeMemberVO m = service.read(comFreeMember.getId());

		if (m == null) {
			boolean ok = service.register(comFreeMember);
		
		if(ok) {
			rttr.addFlashAttribute("success", "회원가입 완료");
			return "redirect:/community/communtiyBoard/community_FreeBoard";
		} else {
			return "redirect:/community/communityMember/community_signup";
			}
		} else {
			model.addAttribute("alertMessage", "중복된 아이디 입니다.");
			return null;
		}
	}
	@GetMapping("/community_login")
	public void login()	{
		
	}
	
	@PostMapping("/community_login")
	public String login(String id, String password, HttpSession session) {
		CommunityFreeMemberVO vo = service.read(id);
		
		if(vo==null) {
			return null;
		}
		boolean correctPassword = password.equals(vo.getPassword());
		
		if(!correctPassword) {
			return null;
		}
		session.setAttribute("loggedInMember", vo);

		System.out.println(session.getAttribute("loggedInMember"));

		return "redirect:/community/communityBoard/community_FreeBoard";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/community/communityBoard/community_FreeBoard";
	}
	
	@GetMapping("/community_Info")
	public String info(HttpSession session) {
		/* 필터 사용
		 * CommunityFreeMemberVO vo = (CommunityFreeMemberVO)
		 * session.getAttribute("loggedInMember");
		 * 
		 * if(vo == null) { return "redirect:/community/community_login"; }
		 */
		return null;
	}
	
	public String info(CommunityFreeMemberVO member, HttpSession session, RedirectAttributes rttr) {
		/*필터 사용
		 * CommunityFreeMemberVO vo = (CommunityFreeMemberVO)
		 * session.getAttribute("loggedInMember");
		 * 
		 * if(vo == null) { return "redirect:/community/community_login"; }
		 */
		boolean ok = service.modify(member);
		
		if(ok) {
			rttr.addFlashAttribute("result", "회원 정보가 변경되었습니다.");
			session.setAttribute("loggedInMember", service.read(member.getId()));
			
		} else {
			rttr.addFlashAttribute("result", "회원 정보가 변경되지 않았습니다.");
		}
		
		return "redirect:/community/communityBoard/community_FreeBoard";
	}

	@PostMapping("/remove")
	public String remove(String id, HttpSession session, RedirectAttributes rttr) {
		/* 필터 사용
		 * CommunityFreeMemberVO vo = (CommunityFreeMemberVO)
		 * session.getAttribute("loggedInMember"); if(vo == null) { return
		 * "redirect:/community/community_login"; }
		 */
		service.remove(id);
		
		session.invalidate();
		
		rttr.addFlashAttribute("result", "회원 탈퇴하셨습니다." );
		
		return "redirect:/community/communityBoard/community_FreeBoard";
	}
	
	@GetMapping("/community_List")
	public String list(Model model, HttpSession session) {
		/* 필터 사용
		 * CommunityFreeMemberVO vo = (CommunityFreeMemberVO)
		 * session.getAttribute("loggedInMember"); if(vo == null) { return
		 * "redirect:/community/community_login"; }
		 */
		List<CommunityFreeMemberVO> list = service.getList();
	
		model.addAttribute("memberList", list);
		return null;
	}
}
