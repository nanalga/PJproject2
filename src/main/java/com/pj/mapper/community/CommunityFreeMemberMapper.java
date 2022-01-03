package com.pj.mapper.community;

import java.util.List;

import com.pj.domain.community.CommunityFreeMemberVO;


public interface CommunityFreeMemberMapper {

	
	public int insert(CommunityFreeMemberVO comFreeMember);
	
	public CommunityFreeMemberVO select(String id);
	
	public int update(CommunityFreeMemberVO comFreeMember);
	
	public int delete(String id);
	
	public List<CommunityFreeMemberVO> list();

	public CommunityFreeMemberVO selectByNickName(String nickName);
}
