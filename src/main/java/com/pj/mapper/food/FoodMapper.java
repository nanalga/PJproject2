package com.pj.mapper.food;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.javassist.compiler.ast.Keyword;

import com.pj.domain.food.FoodVO;

public interface FoodMapper {

	public List<FoodVO> getList();

	public int insert(FoodVO food);
	
	public FoodVO selectRead(Integer id);

	public int modify(FoodVO food);
	
	public int delete(Integer id);

	public List<FoodVO> getFoodListPage(@Param("from") Integer page, @Param("items") Integer numberPerPage,
										@Param("searchType") String searchType, @Param("keyword") String keyword);

	public Integer getFoodCountRows(@Param("searchType") String searchType, @Param("keyword") String keyword);

	public int foodPlusCount(Integer id);
	
	public int insert(String string);

	String[] selectNameByBoardId(Integer id);

	public int insert(FoodVO food, String nowDate);

	public int modify(FoodVO food, String nowDate);

	public int getFoodListCnt();
	
}