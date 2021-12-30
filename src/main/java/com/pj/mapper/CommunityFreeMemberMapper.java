package com.pj.mapper;

import java.util.List;

import com.pj.domain.CommunityFreeMemberVO;

public interface CommunityFreeMemberMapper {

	
	public int insert(CommunityFreeMemberVO comFreeMember);
	
	public CommunityFreeMemberVO select(String id);
	
	public int update(CommunityFreeMemberVO comFreeMember);
	
	public int delete(String id);
	
	public List<CommunityFreeMemberVO> list();
}
