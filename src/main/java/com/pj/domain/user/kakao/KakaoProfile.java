package com.pj.domain.user.kakao;

import lombok.Data;

@Data
public class KakaoProfile {
	private Integer id;
	private String connected_at;
	private Properties properties;
	private Kakao_account kakao_account;
}
