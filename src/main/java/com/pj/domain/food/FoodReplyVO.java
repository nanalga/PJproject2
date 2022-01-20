package com.pj.domain.food;

import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;

@Data
public class FoodReplyVO {

	private Integer id;
	private Integer boardId;
	private String replyText;
	private Integer userId;	// user의 ID와 JOIN
	private LocalDateTime inserted;
	private LocalDateTime updated;
	
	private String name;	// user의 name(nickName 역할)
	private String nickName;
	
	private Boolean own;
	
	public String getCustomInserted() {
		// 현재일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00")); // 서울시간 기준
		
		LocalDateTime beforeOneDayFRomNow = now.minusDays(1);	// 하루 뺀
		
		if (inserted.isBefore(beforeOneDayFRomNow)) {
			return inserted.toLocalDate().toString();	// 24시간 이후 날짜만
		} else {
			return inserted.toLocalTime().toString();	// 24시간 이전 시간만
		}
		
	}
	
}
