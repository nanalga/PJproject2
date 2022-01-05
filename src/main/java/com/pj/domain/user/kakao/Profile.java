package com.pj.domain.user.kakao;

import lombok.Data;

@Data
public class Profile {
	private String nickname;
	private String thumbnail_image_url;
	private String profile_image_url;
	private boolean is_default_image;
}
