package com.pj.mapper.resell;

import java.util.List;

import com.pj.domain.resell.ResellReplyVO;


public interface ResellReplyMapper {
	
	public List<ResellReplyVO> list (Integer boardId);

	public int insert(ResellReplyVO reply);

	public ResellReplyVO selectById(Integer id);

	public int update(ResellReplyVO newReply);

	public int delete(Integer id);

	public int deleteByBoardId(Integer id);

	public int deleteByUserId(Integer userId);
	
	
}