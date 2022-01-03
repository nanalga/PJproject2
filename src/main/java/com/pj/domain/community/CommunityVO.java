package com.pj.domain.community;

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
