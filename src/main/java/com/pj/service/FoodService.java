package com.pj.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;

import com.pj.domain.FoodVO;
import com.pj.mapper.FoodMapper;

import lombok.Setter;

public class FoodService {

	@Setter(onMethod_ = @Autowired)
	private FoodMapper mapper;
	
	public List<FoodVO> getList() {

		return mapper.getList();
	}

}
