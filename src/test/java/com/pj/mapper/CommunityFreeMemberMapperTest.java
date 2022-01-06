package com.pj.mapper;

import static org.junit.Assert.*;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pj.domain.community.CommunityFreeMemberVO;
import com.pj.mapper.community.CommunityFreeMemberMapper;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CommunityFreeMemberMapperTest {

	@Setter(onMethod_ = @Autowired)
	public CommunityFreeMemberMapper mapper;
	
	@Test
	public void insertTest() {
		
		CommunityFreeMemberVO vo = new CommunityFreeMemberVO();
		vo.setId("newMember1");
		vo.setPassword("newPass1");
		vo.setAddress("aaa");
		vo.setEmail("newPass1@google.com");
		vo.setNickName("aaa");
		
		int cnt  = mapper.insert(vo);
		
		assertEquals(1,cnt);
	}

}
