package com.pj.mapper.resell;

import java.util.List;

import com.pj.domain.resell.ResellMemberVO;


public interface ResellMemberMapper {

	
	//회원 가입
	public int insert(ResellMemberVO resellMember);
	
	//회원 조회
	public ResellMemberVO select(String id); 
	
	// 회원정보 업데이트
	public int update(ResellMemberVO resellMember);
	
	// 회원 삭제
	public int delete(String id);
	
	// 회원 목록보기
	public List<ResellMemberVO> list();
	
	
}