package com.pj.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pj.domain.user.UserVO;
import com.pj.domain.user.admin.AdminPageInfo;
import com.pj.service.user.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@RequestMapping({"/adminDetail/{path}/{page}","/adminDetail"})
	public String adminDetail(Model model,@PathVariable String path,@PathVariable(required = false) Integer page) {
		
		if(page == null) {
			page = 1;
		}
		model.addAttribute(path);
		if(path.equals("user")) {
			AdminPageInfo pageInfo = userService.getPageInfo(page,10);
			List<UserVO> vo = userService.getUserList(page,10);
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("userList",vo);			
		}
		
//		if(path.equals("food")) {
//			List<FoodVO> vo = userService.getFoodList();
//			model.addAttribute("path","food");
//			model.addAttribute("foodList",vo);
//		}
//		
//		if(path.equals("resell")) {
//			List<ResellVO> vo = userService.getResellList();
//			model.addAttribute("path","resell");
//			model.addAttribute("resellList",vo);
//		}
//		
//		if(path.equals("community")) {
//			List<ResellVO> vo = userService.getCommunityList();
//			model.addAttribute("path","community");
//			model.addAttribute("communityList",vo);
//		}
		return "user/adminDetail";
}

}
