package com.pj.domain;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;

import lombok.Data;

@Data
public class ResellMemberVO {

		private String id;
		private String password;
		private String email;
		private String address;
		private String addressDetail;
		@JsonFormat(shape = Shape.STRING)
		private LocalDateTime inserted;
		private String nickName;
		
		public String getCustomInserted() {
			//현재 일시
			LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
			DateTimeFormatter dateTimeFormatter = 
					DateTimeFormatter.ofPattern("yyyy년 M월 d일 a h시 m분");
			String nowString = now.format(dateTimeFormatter);
			
			LocalDateTime beforeOneDayFromNow = now.minusDays(1);
			
			if(inserted.isBefore(beforeOneDayFromNow)) {
				return inserted.toLocalDate().toString();
			} else {
				
				return inserted.format(dateTimeFormatter);
			}
		}	
}
