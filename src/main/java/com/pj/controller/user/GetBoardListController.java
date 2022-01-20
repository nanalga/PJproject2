package com.pj.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.user.UserVO;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;
import com.pj.service.user.UserService;

import lombok.Setter;

@RestController
@RequestMapping("/getBaordList")
public class GetBoardListController {

	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@GetMapping("user/getList/food")
	public List<UserFoodVO> userFoodList(HttpSession session){
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		List<UserFoodVO> list = userService.getFoodListByUserId(vo.getId());
		return list;
	}
	
	@GetMapping("user/getList/resell")
	public List<UserResellVO> userResellList(HttpSession session){
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		List<UserResellVO> list = userService.getResllListByUserId(vo.getId());
		return list;
	}
	
//	@GetMapping("user/getList/cm")
//	public List<UserCommunityVO> userCMList(HttpSession session){
//		UserVO vo = (UserVO) session.getAttribute("loggedUser");
//		List<UserCommunityVO> list = userService.getCMListByUserId(vo.getId());
//		return list;
//	}
	
	@DeleteMapping("user/delete/food/{id}")
	public ResponseEntity<String> deleteFoodBoard(@PathVariable Integer id) { 
		boolean ok = false;
		try {
			ok = userService.deleteFoodByFoodId(id);
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
			ok = false;
		}
		if(ok) {
			return ResponseEntity.ok("");
		}else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}
	
	@DeleteMapping("user/delete/resell/{id}")
	public ResponseEntity<String> deleteResellBoard(@PathVariable Integer id) { 
		boolean ok = false;
		try {
			ok = userService.deleteResellByResellId(id);
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
			ok = false;
		}
		if(ok) {
			return ResponseEntity.ok("");
		}else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}
	
//	@DeleteMapping("user/delete/cm/{id}")
//	public ResponseEntity<String> deleteFoodBoard(@PathVariable Integer id) { 
//		boolean ok = userService.deleteFoodByFoodId(id);
//		return ResponseEntity.ok("");
//	}
	
}
