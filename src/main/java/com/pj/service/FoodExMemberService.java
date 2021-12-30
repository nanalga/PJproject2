package com.pj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.FoodExMemberVO;
import com.pj.mapper.FoodExMemberMapper;

import lombok.Setter;

@Service
public class FoodExMemberService {

	@Setter(onMethod_ = @Autowired)
	private FoodExMemberMapper mapper;
	
	public FoodExMemberVO foodExMemberRead(String id) {
		return mapper.foodExMemberSelect(id);
	}

	public boolean foodExMemberregister(FoodExMemberVO member) {
		try {
			return mapper.foodExMemberinsert(member) == 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean foodExHasNickName(String nickName) {
		FoodExMemberVO member = mapper.foodExSelectNickName(nickName);
		return member != null;
	}

	public boolean foodExHasId(String id) {
		FoodExMemberVO member = mapper.foodExMemberSelect(id);
		
		return member != null;
	}

}
