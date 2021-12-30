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

	public UserVO getUserEmail(String email) {
		return userMapper.getUserEmail(email);
	}

	public String checkEmail(String email) {
		UserVO vo = userMapper.checkEmail(email);
		if(vo != null) {
			return "unable";
		}else {
			return "able";
		}
	}

	public boolean deleteUserEmail(String emailInfo) {
		return userMapper.deleteUserEmail(emailInfo) == 1;
	}

	public boolean update(UserVO vo) {
		return userMapper.update(vo);
	}

}
