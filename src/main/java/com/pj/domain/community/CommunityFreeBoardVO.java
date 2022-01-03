package com.pj.domain.community;

import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;

@Data
public class CommunityFreeBoardVO {
	
	//request parameter와 property 명이 같으면 세팅해준다
	//request paramater는 jsp의 input 엘레멘트의 네임값과 같다. 
	private Integer id;
	private String title;
	private String content;
	private String writer;
	private LocalDateTime inserted;
	private LocalDateTime updated;
	private String nickName;
	
	public String getCustomInserted(){
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		
		LocalDateTime beforeOneDayFromNow =  now.minusDays(1);
		if(inserted.isBefore(beforeOneDayFromNow)) {
			return inserted.toLocalDate().toString();
		}else {
			return inserted.toLocalTime().toString();
		}
		
		
	}
}
