package com.pj.domain.user.food;

import java.time.LocalDateTime;

import lombok.Data;
@Data
public class UserFoodVO {

	private Integer id;
	private String title;
	private String name;
	private LocalDateTime inserted;
	
}
