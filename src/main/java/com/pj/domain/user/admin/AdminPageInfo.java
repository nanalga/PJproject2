package com.pj.domain.user.admin;

import lombok.Data;

@Data
public class AdminPageInfo {
	
	private Integer lastPage; 
	private Integer countRows; 
	private Integer currentPage; 
	private Integer leftPageNumber; 
	private Integer rightPageNumber; 
	private Boolean hasPrevButton; 
	private Boolean hasNextButton; 
	
}
