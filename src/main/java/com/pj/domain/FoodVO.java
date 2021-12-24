package com.pj.domain;

import java.time.LocalDateTime;

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

}
