package com.pj.mapper.food;

import java.util.List;

import com.pj.domain.food.FoodReplyVO;

public interface FoodReplyMapper {

	public List<FoodReplyVO> foodReplyList(Integer foodBoardId);

	public int foodReplyInsert(FoodReplyVO reply);

	public FoodReplyVO foodSelectById(Integer id);

	public int foodReplyUpdate(FoodReplyVO newReply);

	public int foodReplyDelete(Integer id);

	public void foodDeleteByBoardId(Integer foodBoardId);

}
