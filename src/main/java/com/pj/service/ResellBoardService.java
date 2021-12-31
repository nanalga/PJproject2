package com.pj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pj.domain.ResellBoardVO;
import com.pj.mapper.ResellBoardMapper;

import lombok.Setter;

@Service
public class ResellBoardService {
	
	@Setter(onMethod_= @Autowired)
	private ResellBoardMapper mapper;
	
	public boolean register(ResellBoardVO ResellBoard) {
		
		return mapper.insert(ResellBoard) == 1;
	}
	
	public ResellBoardVO get(Integer id ) {
		return mapper.select(id);
	}
	
	public boolean modify(ResellBoardVO ResellBoard) {
		return mapper.update(ResellBoard) == 1;
	}
	
	public boolean remove(Integer id) {
		return mapper.delete(id) == 1;
	}
	
	
	public List<ResellBoardVO> getList() {
		return mapper.getList();
	}
	
	
	
}









