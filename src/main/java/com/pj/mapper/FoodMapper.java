package com.pj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pj.domain.FoodVO;

public interface FoodMapper {

	public List<FoodVO> getList();

	public int insert(FoodVO food);

	public FoodVO selectRead(Integer id);

	public int modify(FoodVO food);
	
	public int delete(Integer id);

	public List<FoodVO> getFoodListPage(@Param("from") Integer page, @Param("items") Integer numberPerPage);

	public Integer getFoodCountRows();

}
