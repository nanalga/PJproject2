package com.pj.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pj.domain.CommunityFreeMemberVO;
import com.pj.mapper.CommunityFreeMemberMapper;

@Service
public class CommunityFreeMemberService {

	
	private CommunityFreeMemberMapper mapper;
	
	public CommunityFreeMemberVO read(String id) {
		return mapper.select(id);
	}
	
	public boolean register(CommunityFreeMemberVO comFreeMember) {
		return mapper.insert(comFreeMember) == 1;
	}
	
	public boolean modify(CommunityFreeMemberVO comFreeMember) {
		return mapper.update(comFreeMember) == 1;
	}
	
	public boolean remove(String id) {
		return mapper.delete(id) == 1;
	}
	
	public List<CommunityFreeMemberVO> getList(){
		return mapper.list();
	}
}

