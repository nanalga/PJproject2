package com.pj.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.community.CommunityFreeBoardVO;
import com.pj.domain.food.FoodVO;
import com.pj.domain.resell.ResellBoardVO;
import com.pj.domain.user.UserVO;
import com.pj.domain.user.admin.AdminPageInfo;
import com.pj.domain.user.community.UserCommunityVO;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;
import com.pj.mapper.user.UserMapper;

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

//	public List<FoodVO> getFoodList() {
//		return userMapper.getFoodList();
//	}
//
//	public List<ResellBoardVO> getResllList() {
//		return userMapper.getResellList();
//	}
//
//	public List<CommunityFreeBoardVO> getCMList() {
//		return userMapper.getCMList();
//	}
	
	//userController/userDetail

	public List<UserFoodVO> getFoodListByUserId(int id) {
		return userMapper.getFoodListByUserId(id);
	}

	public List<UserResellVO> getResllListByUserId(int id) {
		return userMapper.getResllListByUserId(id);
	}

	public List<UserCommunityVO> getCMListByUserId(int id) {
		return userMapper.getCMListByUserId(id);
	}

	public boolean deleteFoodByFoodId(Integer id) {
		return userMapper.deleteFoodByFoodId(id) == 1;
	}
	
	//adminController/adminDetail

	public List<UserVO> getUserList(Integer page, int i) {
		return userMapper.getUserList(page,i);
	}

	public AdminPageInfo getPageInfo(Integer page, int numberPerPage) {
		Integer countRows = userMapper.getCountRows();

		// 마지막 페이지 번호
		Integer lastPage = (countRows - 1) / numberPerPage + 1;

		// 페이지네이션 가장 왼쪽 번호
		Integer leftPageNumber = (page - 1) / 10 * 10 + 1;

		// 페이지네이션 가장 오른쪽 번호
		Integer rightPageNumber = (page - 1) / 10 * 10 + 10;
		// 가장 마지막 페이지를 넘어가지 않도록
		rightPageNumber = rightPageNumber > lastPage ? lastPage : rightPageNumber;

		// 이전 페이지 버튼 존재 유무
		Boolean hasPrevButton = leftPageNumber != 1;

		// 다음 페이지 버튼 존재 유무
		Boolean hasNextButton = rightPageNumber != lastPage;

		AdminPageInfo pageInfo = new AdminPageInfo();

		pageInfo.setLastPage(lastPage);
		pageInfo.setCountRows(countRows);
		pageInfo.setCurrentPage(page);
		pageInfo.setLeftPageNumber(leftPageNumber);
		pageInfo.setRightPageNumber(rightPageNumber);
		pageInfo.setHasPrevButton(hasPrevButton);
		pageInfo.setHasNextButton(hasNextButton);

		return pageInfo;
	}
	
}
