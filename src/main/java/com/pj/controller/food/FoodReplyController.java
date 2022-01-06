package com.pj.controller.food;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pj.domain.food.FoodReplyVO;
import com.pj.domain.user.UserVO;
import com.pj.service.food.FoodReplyService;

import lombok.Setter;

@RestController
@RequestMapping("/foodReply")
public class FoodReplyController {
	
	@Setter(onMethod_ = @Autowired)
	private FoodReplyService service;
	
	@GetMapping("/food/{foodBoardId}")
	public List<FoodReplyVO> list(@PathVariable Integer foodBoardId, HttpSession session){
		UserVO loggedIn = (UserVO) session.getAttribute("loggedUser");
		
		List<FoodReplyVO> list = service.foodReplyList(foodBoardId);
		
		if(loggedIn != null) {
			for(FoodReplyVO reply : list) {
				int writerId = reply.getUserId();	// 작성자 아이디
				int loginId = loggedIn.getId();		// 로그인 아이디
				System.out.println("writerId : " + writerId + ", loginId : " + loginId);
				if(writerId == loginId) {
					reply.setOwn(true);
				} else {
					reply.setOwn(false);
				}
				
			}
		}
		
		return list;
	}
	
	@PostMapping("/foodReplyWrite")
	public ResponseEntity<String> write(FoodReplyVO reply,@SessionAttribute(value = "loggedUser", required = false)UserVO logged) {
		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		if(logged != null && logged.getId() == reply.getUserId()) {
			service.foodReplyInsert(reply);
			return ResponseEntity.status(HttpStatus.OK).build();
		} else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<String> modify(@PathVariable Integer id, @RequestBody FoodReplyVO reply,@SessionAttribute(value = "loggedUser", required = false)UserVO logged) {
		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		// 댓글 조회
		FoodReplyVO old = service.foodReadyById(id);	// 작성된 댓글 조회
		// 로그인된 멤버의 아이디와 댓글 작성한 사람 아이디가 같을 때만
		if(logged != null && logged.getId() == old.getUserId()) {
			// 업데이트
			old.setReplyText(reply.getReplyText());	// 새로 작성된 댓글을 전달
			service.foodReplyUpdate(old);	// 댓글 업데이트
			
			return ResponseEntity.ok("");
		} else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<String> delete (@PathVariable Integer id, @SessionAttribute(value = "loggedUser", required = false)UserVO logged) {
		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		// 댓글 조회
		FoodReplyVO old = service.foodReadyById(id);	// 작성된 댓글 조회
		// 로그인된 멤버의 아이디와 댓글 작성한 사람 아이디가 같을 때만
		if(logged != null && logged.getId() == old.getUserId()) {
			// 댓글 삭제
			service.foodReplyDelete(id);	// 댓글 업데이트
			
			return ResponseEntity.ok("");
		} else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}
	
}
