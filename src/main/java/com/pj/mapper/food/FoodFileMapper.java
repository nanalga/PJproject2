package com.pj.mapper.food;

import org.apache.ibatis.annotations.Param;

public interface FoodFileMapper {

	void insert(@Param("foodId") Integer foodId, @Param("fileName") String filename);

}
