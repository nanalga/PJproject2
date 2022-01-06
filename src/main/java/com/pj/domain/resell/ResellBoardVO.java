package com.pj.domain.resell;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class ResellBoardVO {
	private Integer id;
	private String title;
	private String content;
	private String writer;
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime inserted;
	@JsonFormat(shape = Shape.STRING)
	private LocalDateTime updated;
	private String nickName;
	private Integer price;
	private Integer memberId; 
	
	private Integer replyCount;
	
	public String getCustomInserted() {
		//현재 일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter = 
				DateTimeFormatter.ofPattern("M월 d일 a HH시 mm분");
		String nowString = now.format(dateTimeFormatter);
		
		LocalDateTime beforeOneDayFromNow = now.minusDays(1);
		
		if(inserted.isBefore(beforeOneDayFromNow)) {
			return inserted.toLocalDate().toString();
		} else {
			
			return inserted.format(dateTimeFormatter);
		}
		
	}
	
	private String type; //검색타입
	private String keyword; //  검색내용


}
