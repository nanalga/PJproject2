package com.pj.service.user;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pj.domain.user.UserVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class UserServiceTest {

	@Autowired
	public UserService service;
	
	@Autowired
	public ApplicationEventPublisher publisher;
	
	@Test
	public void test() {
		assertNotNull(service);
		assertNotNull(publisher);
//		service.deleteUserByUserId(9999999);
		String email = "emailemail@naver.com";
		
		UserVO vo = service.getUserEmail(email);
		
//		service.update(vo);
		service.deleteResellByResellId(556);
	}

}
