package com.pj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pj.domain.ResellReplyVO;
import com.pj.service.ResellReplyService;

import lombok.Setter;

@RestController
@RequestMapping("/resellReply")
public class ResellReplyController {
	
	@Setter(onMethod_ = @Autowired)
	private ResellReplyService service;
	
	
	@GetMapping("/resellBoard/{boardId}")
	public List<ResellReplyVO>  list(@PathVariable Integer boardId) {
		
		return service.list(boardId);
	}
	
}






