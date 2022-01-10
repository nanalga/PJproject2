package com.pj.domain.user.resell;

import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;

@Data
public class UserResellVO {
	private int id;
	private String title;
	private String name;
	private Integer price;
	private LocalDateTime updated;
	
	public String getUserUpdated() {
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		LocalDateTime beforeOnedayFromNow = now.minusDays(1);
		
		if(updated.isBefore(beforeOnedayFromNow)) {
			return updated.toLocalDate().toString();
		}else {
			return updated.toLocalTime().toString();
		}
	}
}
