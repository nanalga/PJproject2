package com.pj.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CommunityVO {

	private Integer id;
	private String title;
	private String content;
	private String writer;
	private LocalDateTime inserted;
	private LocalDateTime updated;
	
	
}
