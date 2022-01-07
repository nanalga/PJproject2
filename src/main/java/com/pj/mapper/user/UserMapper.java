package com.pj.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pj.domain.community.CommunityFreeBoardVO;
import com.pj.domain.food.FoodVO;
import com.pj.domain.resell.ResellBoardVO;
import com.pj.domain.user.UserVO;
import com.pj.domain.user.community.UserCommunityVO;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;

public interface UserMapper {

	public String getUserInfo();

	public List<UserVO> getUserList(@Param("start") Integer page,@Param("end") Integer i);
	
	public int insert(UserVO vo);

	public UserVO getUserEmail(String email);

	public UserVO checkEmail(String email);

	public int deleteUserEmail(String emailInfo);

	public boolean update(UserVO vo);

	public List<UserFoodVO> getFoodListByUserId(int id);

	public List<UserResellVO> getResllListByUserId(int id);

	public List<UserCommunityVO> getCMListByUserId(int id);

	public int deleteFoodByFoodId(Integer id);

	public Integer getCountRows();
	
//	public List<FoodVO> getFoodList();
//
//	public List<ResellBoardVO> getResellList();
//
//	public List<CommunityFreeBoardVO> getCMList();
}
