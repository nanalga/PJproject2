package com.pj.domain.user.food;

import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;
@Data
public class UserFoodVO {

	private Integer id;
	private String title;
	private String name;
	private LocalDateTime inserted;
	
	public String getUserInserted() {
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		LocalDateTime beforeOnedayFromNow = now.minusDays(1);
		
		if(inserted.isBefore(beforeOnedayFromNow)) {
			return inserted.toLocalDate().toString();
		}else {
			return inserted.toLocalTime().toString();
		}
	}
}
