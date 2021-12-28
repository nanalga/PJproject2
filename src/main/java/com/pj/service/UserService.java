package com.pj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.UserVO;
import com.pj.mapper.UserMapper;

import lombok.Setter;

@Service
public class UserService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;
	
	public String getUserInfo() {
		
		return userMapper.getUserInfo();
	}

	public boolean insert(UserVO vo) {
		return userMapper.insert(vo) == 1;
	}

	public UserVO getUser(String email) {
		return userMapper.getUser(email);
	}

}
