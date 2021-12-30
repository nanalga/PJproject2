package com.pj.mapper;

import java.util.List;

import com.pj.domain.CommunityFreeBoardVO;

public interface CommunityFreeBoardMapper {

	public List<CommunityFreeBoardVO> getList();
	
	public int insert(CommunityFreeBoardVO comFreeBoard);
	
	public CommunityFreeBoardVO read(Integer id);
	
	public int delete(Integer id);
	
	public int update(CommunityFreeBoardVO comFreeBoard);
}
