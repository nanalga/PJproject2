package com.pj.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import com.pj.domain.user.UserVO;
import com.pj.domain.user.admin.AdminPageInfo;
import com.pj.domain.user.food.UserFoodVO;
import com.pj.domain.user.resell.UserResellVO;
import com.pj.mapper.user.UserMapper;

import lombok.Setter;

@Service
public class UserService {

	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;
	
//	@Autowired
//	private ApplicationEventPublisher publisher;
	
	public String getUserInfo() {
		
		return userMapper.getUserInfo();
	}
	
	public boolean insert(UserVO vo) {
		System.out.println(vo);
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

	public boolean update(UserVO vo) {
//		publisher.publishEvent(new Object());
		return userMapper.update(vo);
	}
	
	//userController/userDetail

	public List<UserFoodVO> getFoodListByUserId(int id) {
		return userMapper.getFoodListByUserId(id);
	}

	public List<UserResellVO> getResllListByUserId(int id) {
		return userMapper.getResllListByUserId(id);
	}

//	public List<UserCommunityVO> getCMListByUserId(int id) {
//		return userMapper.getCMListByUserId(id);
//	}

	@Transactional
	public boolean deleteUserByUserId(Integer id) throws RuntimeException{
		/*
		 * int count1 = userMapper.selectCount("FoodReply","userId",id); int count2 =
		 * userMapper.selectCount("rReply", "userId", id); int count3 =
		 * userMapper.deleteReplyByUserId(id); System.out.println("count1 :"+count1);
		 * System.out.println("count2 :"+count2); System.out.println("count3 :"+count3);
		 * if((count1+count2) != count3) { throw new
		 * RuntimeException("deleteReplyByUserId query error1"); }
		 */
		
		List<UserFoodVO> foodVOs = userMapper.getFoodListByUserId(id);
		for(UserFoodVO foodVO : foodVOs) {
			userMapper.deleteFoodReplyByFoodId(foodVO.getId());
		}
		List<UserResellVO> resellVOs = userMapper.getResllListByUserId(id);
		for(UserResellVO resellVO : resellVOs) {
			userMapper.deleteResellReplyByResellId(resellVO.getId());
		}
		
		int count4 = userMapper.selectCount("Food", "memberId", id);
		int count5 = userMapper.selectCount("Resell", "memberId", id);
		int count6 = userMapper.deleteFoodByUserId(id);
		int count7 = userMapper.deleteResellByUserId(id);
		
		System.out.println("count4 :"+count4);
		System.out.println("count5 :"+count5);
		System.out.println("count6 :"+count6);
		System.out.println("count7 :"+count7);
		
		if((count4+count5) != (count6+count7)) {
			throw new RuntimeException("deleteBoardByUserId query error2");
		}
		
		return userMapper.deleteUserByUserId(id) == 1;
	}
	
	@Transactional
	public boolean deleteFoodByFoodId(Integer id) throws RuntimeException{
		int count1 = userMapper.selectCount("FoodReply","boardId",id);
		int count2 = userMapper.deleteFoodReplyByFoodId(id);
		if(count1 != count2) {
			throw new RuntimeException("deleteFoodReply query error");
		}
		
		return userMapper.deleteFoodByFoodId(id) == 1;
	}
	
	@Transactional
	public boolean deleteResellByResellId(Integer id) throws RuntimeException{
		int count1 = userMapper.selectCount("ResellReply","boardId",id);
		int count2 = userMapper.deleteResellReplyByResellId(id);
		
		if(count1 != count2) {
//			publisher.publishEvent(new Object());
			throw new RuntimeException("deleteResellReply query error");
		}
//		publisher.publishEvent(new Object());
		
//		int c = 4/0;
		
		return userMapper.deleteResellByResellId(id) == 1;
	}
	
//	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
//	public void afterCommit(Object e) {
//		System.out.println("@#@#@#@#@#@#@#@#@#@#@##@#@#@#@#@##@#@#@#@#");
//		System.out.println("afterCommit");
//	}
//	
//	@TransactionalEventListener(phase = TransactionPhase.AFTER_ROLLBACK)
//	public void afterRollback(Object e) {
//		System.out.println("@#@#@#@#@#@#@#@#@#@#@##@#@#@#@#@##@#@#@#@#");
//		System.out.println("after rollback");
//	}
//	
//	@TransactionalEventListener(phase = TransactionPhase.AFTER_COMPLETION)
//	public void afterCom(Object e) {
//		System.out.println("@#@#@#@#@#@#@#@#@#@#@##@#@#@#@#@##@#@#@#@#");
//		System.out.println("after complete");
//	}
//	
//	@TransactionalEventListener(phase = TransactionPhase.BEFORE_COMMIT)
//	public void beforeCommit(Object e) {
//		System.out.println("@#@#@#@#@#@#@#@#@#@#@##@#@#@#@#@##@#@#@#@#");
//		System.out.println("before commit");
//	}

//	public boolean deleteCMByCMId(Integer id) {
//		return userMapper.deleteCMByCMId(id) == 1;
//	}
	
	//adminController/adminDetail

	public AdminPageInfo getPageInfo(String path,Integer page, int numberPerPage) {
		Integer countRows = 0;
		if(path.equals("user")) {
			countRows = userMapper.getUserCountRows();
		}else if(path.equals("food")) {
			countRows = userMapper.getFoodCountRows();
		}else if(path.equals("resell")){
			countRows = userMapper.getResellCountRows();
		}else {
			System.out.println("adming select page error");
		}
		
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

	public List<UserVO> getUserList(Integer page, int pagePerNumber) {
		
		Integer from = (page -1)*10;
		return userMapper.getUserList(from,pagePerNumber);
	}
	
	public List<UserFoodVO> getFoodList(Integer page, int pagePerNumber) {
		Integer from = (page -1)*10;
		return userMapper.getFoodList(from,pagePerNumber);
	}

	public List<UserResellVO> getResellList(Integer page, int pagePerNumber) {
		Integer from = (page -1)*10;
		return userMapper.getResellList(from,pagePerNumber);
	}
	
}
