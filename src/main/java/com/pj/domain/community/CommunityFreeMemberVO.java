package com.pj.domain.community;

import java.time.LocalDateTime;

import lombok.Data;


@Data
public class CommunityFreeMemberVO {

	private String id;
	private String password;
	private String email;
	private String address;
	private LocalDateTime inserted;
	private String nickName;
	private Integer numberOfBoard;
}
