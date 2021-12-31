package com.pj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.CommunityFreeBoardVO;
import com.pj.service.CommunityFreeBoardService;

import lombok.Setter;

@Controller
@RequestMapping("/community")
public class CommunityFreeBoardController {

	@Setter(onMethod_ = @Autowired)
	private CommunityFreeBoardService service;
	
	//하나의 게시물을 보는 것 get으로 함.(GetMapping)
	@GetMapping("/community_FreeBoard")
	public void list(Model model) {
		List<CommunityFreeBoardVO> list = service.getList();
	 
		model.addAttribute("list", list);
		
		
		
	}
	@GetMapping({"community_free_get", "community_Modify"})
	public void get(@RequestParam("id") Integer id, Model model) {
		//서비스를 통해 파라미터로 받은 아이디를 통해 게시물을 얻어옴
		CommunityFreeBoardVO comFreeBoard = service.get(id);
		
		//게시물을 model에 comFreeBoard라는 이름으로 넣어줌
		model.addAttribute("comFreeBoard", comFreeBoard);
		
	}
	
	@PostMapping("/community_Modify")
	public String modify(CommunityFreeBoardVO comFreeBoard, RedirectAttributes rttr) {
		
		if(service.modify(comFreeBoard)) {			
			rttr.addFlashAttribute("result",comFreeBoard.getId()+"번 게시글이 수정되었습니다." );
		}
		
		return "redirect:/community/community_FreeBoard";
	}
	
	@GetMapping("/community_Register")
	public void register() {
		
	}
	
	@PostMapping("/community_Register")
	//필요한 bean을 명시해주면 된다. 
	//bean에 프로퍼티를 채워 넣어줘야 하는데 어떻게 채워줘야하는가?
	
	public String register(CommunityFreeBoardVO comFreeBoard, RedirectAttributes rttr  ) {
		
		service.register(comFreeBoard);
		
		rttr.addFlashAttribute("result", comFreeBoard.getId()+"번 게시글이 등록되었습니다.");
		
		//마지막에 입력한 게시물 번호를 쓰려고 freeboard에 씀
		//목록으로 redirect하면 됨
		return "redirect:/community/community_FreeBoard";
	}
//	@GetMapping
//	public void modify(@RequestParam("id") Integer id, Model model) {
//		CommunityFreeBoardVO comFreeBoard = service.get(id);
//		
//		model.addAttribute("comFreeBoard", comFreeBoard);
//	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("id") Integer id, RedirectAttributes rttr) {
		if(service.remove(id)) {
			rttr.addFlashAttribute("result", id+"번 게시글이 삭제되었습니다.");
		}
		
		return "redirect:/community/community_FreeBoard";
	}
	
}

