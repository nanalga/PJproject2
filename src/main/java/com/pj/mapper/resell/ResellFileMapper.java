package com.pj.mapper.resell;

import org.apache.ibatis.annotations.Param;

public interface ResellFileMapper {

	void insert(@Param("resellBoardId") Integer resellId, @Param("fileName") String filename);
}