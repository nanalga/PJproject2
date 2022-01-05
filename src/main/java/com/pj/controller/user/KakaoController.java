package com.pj.controller.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pj.domain.user.UserVO;
import com.pj.domain.user.kakao.KakaoOauthToken;
import com.pj.domain.user.kakao.KakaoProfile;
import com.pj.service.user.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/kakao")
public class KakaoController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	private static ObjectMapper objMapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	
	@RequestMapping("/kakaoJoin")
	public String kakaoJoin (@RequestParam("code") String code,HttpSession session,RedirectAttributes rttr) {
		RestTemplate rt = new RestTemplate();
		
		KakaoOauthToken kkoauthToken = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "d1f2c7c111ea44b0957fc9dbf10a601f");
		params.add("redirect_uri", "http://localhost:8080/controller/user/kakaoJoin");
		params.add("code", code);
//		params.add("client_secret", "client_secret=JvLJOAG3lB8Iw722duwlZefwclmFMY6Q");
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://kauth.kakao.com/oauth/token",
					HttpMethod.POST,
					kakaoTokenRequest,
					String.class
					);
			System.out.println("response :"+response);
			try {
				kkoauthToken = objMapper.readValue(response.getBody(), KakaoOauthToken.class);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
		
		KakaoProfile kakaoProfile = kakaoUserInfo(kkoauthToken.getAccess_token());
		
		UserVO vo = userService.getUserEmail(kakaoProfile.getKakao_account().getEmail());
		if(vo != null) {
			return "redirect:/user/login";
		}
		
		UserVO vo2 = new UserVO();
		vo2.setName(kakaoProfile.getProperties().getNickname());
		vo2.setNickName(kakaoProfile.getProperties().getNickname());
		vo2.setEmail(kakaoProfile.getKakao_account().getEmail());
		vo2.setPassword("0000");
		vo2.setSocial("kakao");
		boolean ok = userService.insert(vo2);
		if(ok) {
			session.setAttribute("loggedUser", vo);
			rttr.addFlashAttribute("success","회원가입되었습니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("fail","회원가입에 실패했습니다.");
			return "redirect:/user/join";
		}
		
		
	}
	
	@RequestMapping("/kakaoLogin")
	public String kakaoLogin (@RequestParam("code") String code,HttpSession session,RedirectAttributes rttr) {
		RestTemplate rt = new RestTemplate();
		
		KakaoOauthToken kkoauthToken = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "d1f2c7c111ea44b0957fc9dbf10a601f");
		params.add("redirect_uri", "http://localhost:8080/controller/user/kakaoLogin");
		params.add("code", code);
//		params.add("client_secret", "client_secret=JvLJOAG3lB8Iw722duwlZefwclmFMY6Q");
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params,headers);
		
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://kauth.kakao.com/oauth/token",
					HttpMethod.POST,
					kakaoTokenRequest,
					String.class
					);
			System.out.println("response :"+response);
			try {
				kkoauthToken = objMapper.readValue(response.getBody(), KakaoOauthToken.class);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
		
		KakaoProfile kakaoProfile = kakaoUserInfo(kkoauthToken.getAccess_token());
		
		UserVO vo = userService.getUserEmail(kakaoProfile.getKakao_account().getEmail());
		System.out.println("kakaoUserVO"+vo);
		if(vo == null) {
			rttr.addFlashAttribute("fail","회원가입 되지 않은 유저입니다.");
			return "redirect:/user/join";
		}
		
		rttr.addFlashAttribute("success","회원가입되었습니다.");
		session.setAttribute("loggedUser", vo);
		session.setAttribute("channel", "kakao");
		return "redirect:/";
		
	}
	
//	@RequestMapping("/kakoLogin/checkKakaoToken")
//	@ResponseBody
//	public String checkKakao(HttpSession session) {
//		KakaoOauthToken oauthToken = (KakaoOauthToken) session.getAttribute("kakaoUser");
//		if(oauthToken != null) {
//			RestTemplate rt = new RestTemplate();
//			System.out.println("accessToken :"+ oauthToken.getAccess_token());
//			HttpHeaders headers = new HttpHeaders();
//			headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
//			headers.add("Authorization", "Bearer "+ oauthToken.getAccess_token());
//			
//			MultiValueMap<String , String> params = new LinkedMultiValueMap<String, String>();
//			
//			HttpEntity<MultiValueMap<String, String>> accessTokenInfo = new HttpEntity<>(params,headers);
//			
//			try {
//				ResponseEntity<String> response = rt.exchange(
//						"https://kapi.kakao.com/v1/user/access_token_info",
//						HttpMethod.GET,
//						accessTokenInfo,
//						String.class
//						);
//				System.out.println("response :"+response);
//				System.out.println("work");
//				return response.getBody();
//			} catch (Exception e) {
//				// TODO: handle exception
//				System.out.println("error");
//				e.printStackTrace();
//			}
//		}
//		
//		return "";
//	}
	
	public KakaoProfile kakaoUserInfo(String access_token) {
		System.out.println("getKaKaoUserInfo Controller work");
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer "+access_token);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(headers);
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://kapi.kakao.com/v2/user/me",
					HttpMethod.POST,
					request,
					String.class
					);
			KakaoProfile kakaoProfile = objMapper.readValue(response.getBody(), KakaoProfile.class);
			return kakaoProfile;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
}
