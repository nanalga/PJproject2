package com.pj.domain.user;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class UserVO {
	private int id;
	private String name;
	private String email;
	private String password;
	private LocalDateTime created;
	private LocalDateTime updated;
}
