package com.pj.domain;

import java.time.LocalDateTime;

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
}
