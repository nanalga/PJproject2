package com.pj.domain.user.resell;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class UserResellVO {
	private int id;
	private String title;
	private String name;
	private Integer price;
	private LocalDateTime updated;
}
