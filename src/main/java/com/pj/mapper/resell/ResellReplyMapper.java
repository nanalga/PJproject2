package com.pj.mapper.resell;

import java.util.List;

import com.pj.domain.resell.ResellReplyVO;


public interface ResellReplyMapper {
	
	public List<ResellReplyVO> list (Integer boardID);
	
}