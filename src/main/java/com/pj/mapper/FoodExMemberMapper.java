package com.pj.mapper;

import com.pj.domain.FoodExMemberVO;

public interface FoodExMemberMapper {

	FoodExMemberVO foodExMemberSelect(String id);

	int foodExMemberinsert(FoodExMemberVO member);

	FoodExMemberVO foodExSelectNickName(String nickName);

}
