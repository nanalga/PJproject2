package com.pj.mapper;

import java.util.List;

import com.pj.domain.food.FoodVO;
import com.pj.domain.ResellVO;
import com.pj.domain.UserVO;

public interface UserMapper {

	public String getUserInfo();

	public List<UserVO> getUserList();
	
	public int insert(UserVO vo);

	public UserVO getUserEmail(String email);

	public UserVO checkEmail(String email);

	public int deleteUserEmail(String emailInfo);

	public boolean update(UserVO vo);

	public List<FoodVO> getFoodList();

	public List<ResellVO> getResellList();

	public List<ResellVO> getCommunityList();

	
}
