package com.pj.controller.user;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pj.domain.user.UserVO;
import com.pj.domain.user.naver.NaverOauthToken;
import com.pj.domain.user.naver.NaverRequestInfo;
import com.pj.domain.user.naver.Profile;
import com.pj.service.user.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/naver")
public class NaverController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Value("${naver.client_id}")
	private String naver_client_id;
	
	@Value("${naver.client_secret}")
	private String naver_client_secret;
	
	private static ObjectMapper objMapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	
	@RequestMapping("/naverLogin")
	public String naverLogin(@RequestParam("code") String code,@RequestParam("state") String state, HttpSession session,RedirectAttributes rttr) {
		NaverOauthToken naverOauthToken = null;
		NaverRequestInfo naverRequestInfo = null;
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", naver_client_id);
		params.add("client_secret", naver_client_secret);
		params.add("code", code);
		params.add("state", state);
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params,headers);
		
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://nid.naver.com/oauth2.0/token",
					HttpMethod.POST,
					request,
					String.class
					);
			System.out.println(response);
			try {
				naverOauthToken = objMapper.readValue(response.getBody(), NaverOauthToken.class);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
		
		String token = naverOauthToken.getAccess_token(); // 네이버 로그인 접근 토큰;
        String header = "Bearer " + token; // Bearer 다음에 공백 추가


        String apiURL = "https://openapi.naver.com/v1/nid/me";


        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Authorization", header);
        String responseBody = get(apiURL,requestHeaders);


        System.out.println("responsebody :"+responseBody);
			
			try {
				naverRequestInfo = objMapper.readValue(responseBody, NaverRequestInfo.class);
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		Profile profile = naverRequestInfo.getResponse();
		UserVO vo = userService.getUserEmail(profile.getEmail());
		if(vo == null) {
			System.out.println("회원가입 안된 유저");
			rttr.addFlashAttribute("fail", "회원가입안된 유저 입니다.");
			return "redirect:/user/join";
		}
		if(vo.getSocial().equals("kakao")) {
			System.out.println("카카오로 회원가입된 유저");
			rttr.addFlashAttribute("fail","카카오로 회원가입된 유저입니다 카카오로 로그인해주세요");
			return "redirect:/user/login";
		}
		session.setAttribute("loggedUser", vo);
		session.setAttribute("channel", "naver");
		session.setAttribute("access_token", naverOauthToken.getAccess_token());
		rttr.addFlashAttribute("success","로그인에 성공하였습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/naverJoin")
	public String naverJoin(@RequestParam("code") String code,@RequestParam("state") String state,HttpSession session,RedirectAttributes rttr) {
		
		NaverOauthToken naverOauthToken = null;
		NaverRequestInfo naverRequestInfo = null;
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", naver_client_id);
		params.add("client_secret", naver_client_secret);
		params.add("code", code);
		params.add("state", state);
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params,headers);
		
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://nid.naver.com/oauth2.0/token",
					HttpMethod.POST,
					request,
					String.class
					);
			System.out.println(response);
			try {
				naverOauthToken = objMapper.readValue(response.getBody(), NaverOauthToken.class);
			} catch (Exception e) {
				// TODO: handle exception
			}
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
		
		String token = naverOauthToken.getAccess_token(); // 네이버 로그인 접근 토큰;
        String header = "Bearer " + token; // Bearer 다음에 공백 추가


        String apiURL = "https://openapi.naver.com/v1/nid/me";


        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Authorization", header);
        String responseBody = get(apiURL,requestHeaders);


        System.out.println("responsebody :"+responseBody);
			
			try {
				naverRequestInfo = objMapper.readValue(responseBody, NaverRequestInfo.class);
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		Profile profile = naverRequestInfo.getResponse();
		UserVO vo = userService.getUserEmail(profile.getEmail());
		if(vo != null) {
			rttr.addFlashAttribute("fail", "회원가입된 유저입니다.");
			return "redirect:/user/login";
		}
		
		UserVO vo2 = new UserVO();
		vo2.setEmail(profile.getEmail());
		vo2.setName(profile.getName());
		vo2.setNickName(profile.getName());
		vo2.setPassword("0000");
		vo2.setSocial("naver");

		boolean ok = userService.insert(vo2);
		if(ok) {
			System.out.println("회원가입 완료");
			rttr.addFlashAttribute("success","회원가입에 성공하였습니다.");
			return "redirect:/user/login";
		}else {
			System.out.println("회원가입 실패");
			rttr.addFlashAttribute("fail","회원가입에 실패하였습니다.");
			return "redirect:/user/join";
		}
	}
	
	
	private String get(String apiUrl, Map<String, String> requestHeaders){
	        HttpURLConnection con = connect(apiUrl);
	        try {
	            con.setRequestMethod("GET");
	            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
	                con.setRequestProperty(header.getKey(), header.getValue());
	            }


	            int responseCode = con.getResponseCode();
	            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
	                return readBody(con.getInputStream());
	            } else { // 에러 발생
	                return readBody(con.getErrorStream());
	            }
	        } catch (IOException e) {
	            throw new RuntimeException("API 요청과 응답 실패", e);
	        } finally {
	            con.disconnect();
	        }
	    }


    private HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


	private String readBody(InputStream body){
	        InputStreamReader streamReader = new InputStreamReader(body);


	        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
	            StringBuilder responseBody = new StringBuilder();


	            String line;
	            while ((line = lineReader.readLine()) != null) {
	                responseBody.append(line);
	            }


	            return responseBody.toString();
	        } catch (IOException e) {
	            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
	        }
	    }
}
