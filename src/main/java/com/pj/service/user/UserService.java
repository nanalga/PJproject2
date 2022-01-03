package com.pj.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.user.UserVO;
import com.pj.mapper.user.UserMapper;

import lombok.Setter;

@Service
public class UserService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;
	
	public String getUserInfo() {
		
		return userMapper.getUserInfo();
	}
	
	public List<UserVO> getUserList() {
		return userMapper.getUserList();
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

//	public List<FoodVO> getFoodList() {
//		return userMapper.getFoodList();
//	}
//
//	public List<ResellVO> getResellList() {
//		return userMapper.getResellList();
//	}
//
//	public List<ResellVO> getCommunityList() {
//		return userMapper.getCommunityList();
//	}

}
