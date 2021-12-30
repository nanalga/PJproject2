package com.pj.domain;

import java.time.LocalDateTime;

import lombok.Data;
@Data
public class UserVO {
	private int id;
	private String name;
	private String password;
	private String email;
	private LocalDateTime created;
	private LocalDateTime updated;
}
