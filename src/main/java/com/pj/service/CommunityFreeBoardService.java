package com.pj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.CommunityFreeBoardVO;
import com.pj.mapper.CommunityFreeBoardMapper;

import lombok.Setter;

@Service
public class CommunityFreeBoardService {

	
	@Setter(onMethod_ = @Autowired)
	private CommunityFreeBoardMapper mapper;
	
	public boolean register(CommunityFreeBoardVO comFreeBoard) {
		return mapper.insert(comFreeBoard) == 1;
	}
	
	public CommunityFreeBoardVO get(Integer id) {
		return mapper.read(id);

	}
	
	public boolean modify(CommunityFreeBoardVO comFreeBoard) {
		return mapper.update(comFreeBoard) == 1;
	}
	
	public boolean remove(Integer id) {
		return mapper.delete(id) == 1;
	}
	
	public List<CommunityFreeBoardVO> getList(){
		return mapper.getList();
	}
}
