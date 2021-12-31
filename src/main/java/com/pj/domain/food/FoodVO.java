package com.pj.domain.food;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class FoodVO {
	
	private Integer id;
	private String title;
	private String contents;
	private String writer;
	private String nickName;
	private LocalDateTime inserted;
	private LocalDateTime updated;

	
	
	public String getCustomInserted() {
		// 현재일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter =
				DateTimeFormatter.ofPattern("yyyy년 M월 d일 a h시 m분");
		String nowString= now.format(dateTimeFormatter);
				
		LocalDateTime beforeDayFromNow = now.minusDays(1);
		
		if (inserted.isBefore(beforeDayFromNow)) {
			return inserted.toLocalDate().toString();
		} else {
			return inserted.format(dateTimeFormatter);
		}
	}

}
