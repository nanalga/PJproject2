package com.pj.mapper;

import com.pj.domain.UserVO;

public interface UserMapper {

	public String getUserInfo();

	public int insert(UserVO vo);

	public UserVO getUserEmail(String email);

	public UserVO checkEmail(String email);

	public int deleteUserEmail(String emailInfo);

	public boolean update(UserVO vo);
	
}
