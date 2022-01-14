package com.pj.mapper.resell;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pj.domain.resell.ResellBoardVO;


public interface ResellBoardMapper {

	
	// 모든 게시믈 조회
	public List<ResellBoardVO> getList();			
	
	// 새 게시물 입력 &get generated key
	public int insert(ResellBoardVO board);		
	
	// id(pk)로 하나의 게시물 조회
	public ResellBoardVO select(Integer id);		

	// id(pk)로 하나의 게시물 삭제
	public int delete(Integer id);	
	
	// 하나의 게시물 수정
	public int update(ResellBoardVO board);

	public List<ResellBoardVO> getListPage(@Param("from") Integer from, @Param("items") Integer numberPerPage,
										@Param("searchType") String searchType, @Param("keyword") String keyword);

	public Integer getCountRows();

	public int deleteByUserId(String userId);

	public int boardPlusCnt(Integer id);

	public Integer getCount();

	public Integer getCount(@Param("searchType") String searchType,@Param("keyword") String keyword);

	public String[] selectImageKeyByBoardId(Integer id);



//	public String[] selectNamesByBoardId(Integer id);


	


}