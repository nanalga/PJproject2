package com.pj.controller.resell;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

import com.pj.domain.resell.ResellMemberVO;
import com.pj.domain.resell.ResellReplyVO;
import com.pj.domain.user.UserVO;
import com.pj.service.resell.ResellReplyService;

import lombok.Setter;

@RestController
@RequestMapping("/resellReply")
public class ResellReplyController {
	
	@Setter(onMethod_ = @Autowired)
	private ResellReplyService service;
	
	
	@GetMapping("/resellBoard/{boardId}")
	public List<ResellReplyVO>  list(@PathVariable Integer boardId, HttpSession session) {
		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		List<ResellReplyVO> list = service.list(boardId);
		
		System.out.println("User/login: " + logged );
		
		if (logged != null) {
				for (ResellReplyVO reply : list) {
					Integer replyUserId = reply.getUserId();
					reply.setOwn(logged.getId() == replyUserId);
					
				}
		}
	
		return list;
	}
	
	@PostMapping("/write")
	public ResponseEntity<String> write(ResellReplyVO reply,@SessionAttribute(value= "loggedUser", required = false) UserVO logged )  {
		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");

		//로그인한 멤버 
		if (logged != null && logged.getId() ==(reply.getUserId())) {
			service.insert(reply);
			return ResponseEntity.status(HttpStatus.OK).build();
		} else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}

		
	}
	
	
	// For other incoming data, such as JSON, you'll need @RequestBody as explained in
	// JSON 의 MediaType  : application/json
	// PutMapping 에서는 @RequestBody 로 받는게 보장된다고 하늬....
	
	@PutMapping("/{id}")	
	public ResponseEntity<String> modify(@PathVariable Integer id, @RequestBody ResellReplyVO replyText,@SessionAttribute(value= "loggedUser", required = false) UserVO logged ) {
		System.out.println(id);
		System.out.println(replyText.getReplyText());

		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		// 댓글 조회
		ResellReplyVO old = service.readById(id);
		
		if (logged != null && logged.getId() == old.getUserId()) {
			// 업데이트
			old.setReplyText(replyText.getReplyText());
			service.update(old);

			return ResponseEntity.ok("");
		} else {
			// 권한 없음
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
		
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<String> remove(@PathVariable Integer id, @SessionAttribute(value = "loggedUser", required = false) UserVO logged) {
		// 로그인한 멤버
//		UserVO logged = (UserVO) session.getAttribute("loggedUser");
		
		// 댓글 조회
		ResellReplyVO old = service.readById(id);
		
		if (logged != null && logged.getId() == (old.getUserId())) {
			// 삭제
			service.delete(id);

			return ResponseEntity.ok("");
		} else {
			// 권한 없음
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
		
	}
	
}














