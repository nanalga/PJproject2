package com.pj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.ResellReplyVO;
import com.pj.mapper.ResellReplyMapper;

import lombok.Setter;




@Service
public class ResellReplyService {

	@Setter(onMethod_ = @Autowired)
	private ResellReplyMapper mapper;

	public List<ResellReplyVO> list(Integer boardId) {
		
		return mapper.list(boardId);
	}
	
	
}




