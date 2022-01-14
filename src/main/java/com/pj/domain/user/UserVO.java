package com.pj.domain.user;

import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;

@Data
public class UserVO {
	private int id;
	private String name;
	private String nickName;
	private String email;
	private String password;
	private String address;
	private String social;
	private LocalDateTime created;
	private LocalDateTime updated;
	private boolean admin;
	
	public String getUserCreated() {
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		LocalDateTime beforeOnedayFromNow = now.minusDays(1);
		
		if(created.isBefore(beforeOnedayFromNow)) {
			return created.toLocalDate().toString();
		}else {
			return created.toLocalTime().toString();
		}
	}
}

