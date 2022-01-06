package com.pj.service.food;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.food.FoodReplyVO;
import com.pj.mapper.food.FoodReplyMapper;

import lombok.Setter;

@Service
public class FoodReplyService {

	@Setter(onMethod_ = @Autowired)
	private FoodReplyMapper mapper;
	
	public List<FoodReplyVO> foodReplyList(Integer foodBoardId) {
		return mapper.foodReplyList(foodBoardId);
	}

	public boolean foodReplyInsert(FoodReplyVO reply) {
		return mapper.foodReplyInsert(reply) == 1;
	}

	public FoodReplyVO foodReadyById(Integer id) {
		return mapper.foodSelectById(id);
	}

	public boolean foodReplyUpdate(FoodReplyVO newReply) {
		return mapper.foodReplyUpdate(newReply) == 1;
		
	}

	public boolean foodReplyDelete(Integer id) {
		return mapper.foodReplyDelete(id) == 1;
	}

}
