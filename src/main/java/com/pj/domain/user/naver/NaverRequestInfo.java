package com.pj.domain.user.naver;

import lombok.Data;

@Data
public class NaverRequestInfo {
	private int resultcode;
	private String message;
	private Profile response;
}
