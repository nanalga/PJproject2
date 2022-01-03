package com.pj.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.community.CommunityFreeMemberVO;
import com.pj.mapper.community.CommunityFreeBoardMapper;
import com.pj.mapper.community.CommunityFreeMemberMapper;

import lombok.Setter;

@Service
public class CommunityFreeMemberService {

	@Setter(onMethod_ = @Autowired)
	private CommunityFreeMemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private CommunityFreeBoardMapper boardMapper;
	
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

	public boolean hasNickName(String nickName) {
		CommunityFreeMemberVO member = mapper.selectByNickName(nickName);

		return member != null;
	}
}

