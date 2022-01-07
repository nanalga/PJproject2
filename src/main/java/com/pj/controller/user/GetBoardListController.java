package com.pj.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.user.UserVO;
import com.pj.domain.user.community.UserCommunityVO;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;
import com.pj.service.user.UserService;

import lombok.Setter;

@RestController
@RequestMapping("/GetBaordList")
public class GetBoardListController {

	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@GetMapping("/getList/food")
	public List<UserFoodVO> userFoodList(HttpSession session){
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		List<UserFoodVO> list = userService.getFoodListByUserId(vo.getId());
		System.out.println("list :"+list);
		return list;
	}
	
	@GetMapping("/getList/resell")
	public List<UserResellVO> userResellList(HttpSession session){
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		List<UserResellVO> list = userService.getResllListByUserId(vo.getId());
		return list;
	}
	
	@GetMapping("/getList/cm")
	public List<UserCommunityVO> userCMList(HttpSession session){
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		List<UserCommunityVO> list = userService.getCMListByUserId(vo.getId());
		return list;
	}
	
	@DeleteMapping("/delete/food/{id}")
	public ResponseEntity<String> deleteFoodBoard(@PathVariable Integer id) { 
		boolean ok = userService.deleteFoodByFoodId(id);
		return ResponseEntity.ok("");
	}
	
//	@DeleteMapping("/delete/food/{id}")
//	public ResponseEntity<String> deleteFoodBoard(@PathVariable Integer id) { 
//		boolean ok = userService.deleteFoodByFoodId(id);
//		return ResponseEntity.ok("");
//	}
//	
//	@DeleteMapping("/delete/food/{id}")
//	public ResponseEntity<String> deleteFoodBoard(@PathVariable Integer id) { 
//		boolean ok = userService.deleteFoodByFoodId(id);
//		return ResponseEntity.ok("");
//	}
	
	
}
