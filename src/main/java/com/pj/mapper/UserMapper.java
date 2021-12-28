package com.pj.mapper;

import com.pj.domain.UserVO;

public interface UserMapper {

	public String getUserInfo();

	public int insert(UserVO vo);

	public UserVO getUser(String email);
	
}
