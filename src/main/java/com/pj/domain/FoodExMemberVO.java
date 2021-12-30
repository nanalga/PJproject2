package com.pj.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class FoodExMemberVO {

	private String id;
	private String password;
	private String email;
	private String address;
	private String addressDetail;
	private String nickName;
	private LocalDateTime inserted;
	private Integer numberOfBoard;
	
}
