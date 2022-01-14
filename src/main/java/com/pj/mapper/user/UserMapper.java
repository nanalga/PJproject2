package com.pj.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pj.domain.community.CommunityFreeBoardVO;
import com.pj.domain.food.FoodVO;
import com.pj.domain.resell.ResellBoardVO;
import com.pj.domain.user.UserVO;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;

public interface UserMapper {

	public String getUserInfo();
	
	public int insert(UserVO vo);

	public UserVO getUserEmail(String email);

	public UserVO checkEmail(String email);

	public int deleteUserEmail(String emailInfo);

	public boolean update(UserVO vo);

	public List<UserFoodVO> getFoodListByUserId(int id);

	public List<UserResellVO> getResllListByUserId(int id);

	public Integer getUserCountRows();

	public Integer getFoodCountRows();
	
	public Integer getResellCountRows();
	
	public List<UserVO> getUserList(@Param("start") Integer from,@Param("end") int pagePerNumber);

	public List<UserFoodVO> getFoodList(@Param("start") Integer from,@Param("end") int pagePerNumber);

	public List<UserResellVO> getResellList(@Param("start") Integer from,@Param("end") int pagePerNumber);

	public int deleteUserByUserId(Integer id);

	public int deleteFoodByFoodId(Integer id);
	
	public int deleteResellByResellId(Integer id);

	public int deleteReplyByUserId(Integer id);

	public int deleteBoardByUserId(Integer id);

	public int deleteFoodReplyByFoodId(Integer id);

	public int deleteResellReplyByResellId(Integer id);

	public int selectCount(@Param("boardName")String string,@Param("columnName") String string2,@Param("id") Integer id);


	
//	public List<FoodVO> getFoodList();
//
//	public List<ResellBoardVO> getResellList();
//
//	public List<CommunityFreeBoardVO> getCMList();
}
