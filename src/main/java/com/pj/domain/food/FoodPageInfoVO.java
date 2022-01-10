package com.pj.domain.food;

import lombok.Data;

@Data
public class FoodPageInfoVO {
	
	private Integer lastPage;			// 마지막 페이지 번호
	private Integer countRows; 			// 총 레코드 수
	private Integer currentPage;		// 현재 페이지
	private Integer leftPageNumber; 	// 페이지네이션 가장 왼쪽 번호
	private Integer rightPageNumber;	// 페이지네이션 가장 오른쪽 번호
	private Boolean hasPrevButton;		// 이전 페이지 버튼 유무
	private Boolean hasNextButton;		// 다음 페이지 버튼 유뮤
	
	//속성 searchType, keyword 추가
	private String searchType;
	private String keyword;
	
	private String searchTypeKeyword;
	
//	public void setsearchTypeKeyword(String searchType, String keyword) {
//
//		if (searchType.equals("") || keyword.equals("")) {
//			searchTypeKeyword = "";
//		} else {
//			searchTypeKeyword = "&searchType=" + searchType + "&keyword=" + keyword;
//		}
//		
//	}
	
	public String getsetsearchTypeKeyword() {

		if (searchType.equals("") || keyword.equals("")) {
			searchTypeKeyword = "";
		} else {
			searchTypeKeyword = "&searchType=" + searchType + "&keyword=" + keyword;
		}
		return "&searchType=" + searchType + "&keyword=" + keyword;
	}

}