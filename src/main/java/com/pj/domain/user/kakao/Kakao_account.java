package com.pj.domain.user.kakao;

import lombok.Data;

@Data
public class Kakao_account {
	private boolean profile_nickname_needs_agreement;
	private boolean profile_image_needs_agreement;
	private Profile profile;
	private boolean has_email;
	private boolean email_needs_agreement;
	private String email;
	private String birthday;
}
