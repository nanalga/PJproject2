package com.pj.mapper.food;

import com.pj.domain.food.FoodExMemberVO;

public interface FoodExMemberMapper {

	FoodExMemberVO foodExMemberSelect(String id);

	int foodExMemberinsert(FoodExMemberVO member);

	FoodExMemberVO foodExSelectNickName(String nickName);

}
