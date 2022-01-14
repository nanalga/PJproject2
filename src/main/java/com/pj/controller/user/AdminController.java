package com.pj.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.user.UserVO;
import com.pj.domain.user.admin.AdminPageInfo;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;
import com.pj.service.user.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
//	@RequestMapping("adminDetail")
//	public String test() {
//		return "user/adminDetail";
//	}
	
	@RequestMapping({"/adminDetail/{path}/{page}","/adminDetail/{path}"})
	public String adminDetail(Model model,@PathVariable String path,@PathVariable(required = false) Integer page) {
		if(page == null) {
			page = 1;
		}
		int pagePerNumber = 10;
		AdminPageInfo pageInfo = userService.getPageInfo(path,page,pagePerNumber);
		model.addAttribute("pageInfo", pageInfo);
		if(path.equals("user")) {
			List<UserVO> vo = userService.getUserList(page,pagePerNumber);
			model.addAttribute("path",path);
			model.addAttribute("page",page);
			model.addAttribute("userList",vo);			
		}
		
		if(path.equals("food")) {
			List<UserFoodVO> vo = userService.getFoodList(page,pagePerNumber);
			model.addAttribute("path",path);
			model.addAttribute("page",page);
			System.out.println(vo);
			model.addAttribute("foodList",vo);
		}
		
		if(path.equals("resell")) {
			List<UserResellVO> vo = userService.getResellList(page,pagePerNumber);
			System.out.println(vo);
			model.addAttribute("path",path);
			model.addAttribute("page",page);
			model.addAttribute("resellList",vo);
		}
//		
//		if(path.equals("community")) {
//			List<ResellVO> vo = userService.getCommunityList();
//			model.addAttribute("path","community");
//			model.addAttribute("communityList",vo);
//		}
		return "user/adminDetail";
}
	@RequestMapping("adminDetail/delete/{path}/{page}/{id}")
	public String delete(@PathVariable String path,@PathVariable Integer page,@PathVariable Integer id,RedirectAttributes rttr) {
		boolean ok = false;
		
		if(path.equals("user")) {
			try {
				ok = userService.deleteUserByUserId(id);
			} catch (Exception e) {
				ok = false;
			}
		}else if(path.equals("food")) {
			try {
				ok = userService.deleteFoodByFoodId(id);
			} catch (Exception e) {
				ok = false;
			}
		}else if(path.equals("resell")) {
			try {
				ok = userService.deleteResellByResellId(id);
			} catch (Exception e) {
				ok = false;
			}
		}else {
			System.out.println("admin/adminDetail/${path}/delete error");
		}
		
		if(ok) {
			rttr.addFlashAttribute("success","삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("fail","삭제에 실패하였습니다.");
		}
		
		return "redirect:/admin/adminDetail/"+path+"/"+page;
	}

}
