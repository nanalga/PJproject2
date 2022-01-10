package com.pj.domain.food;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

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
	private Integer boardCnt; 
	private Integer memberId;
	private Integer foodReplyCount;	
	private String imageKey;
	
	public String getCustomInserted() {
		// 현재일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
				
		LocalDateTime beforeDayFromNow = now.minusDays(1);
		
		if (inserted.isBefore(beforeDayFromNow)) {
			return inserted.toLocalDate().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}

}