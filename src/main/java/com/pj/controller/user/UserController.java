package com.pj.controller.user;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.community.CommunityFreeBoardVO;
import com.pj.domain.food.FoodVO;
import com.pj.domain.resell.ResellBoardVO;
import com.pj.domain.user.UserVO;
import com.pj.service.user.UserService;

import lombok.Setter;

@Controller
@RequestMapping("/user")
public class UserController {

	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Value("${naver.client_id}")
	private String naver_client_id;
	
	@Value("${naver.client_secret}")
	private String naver_client_secret;

	@GetMapping("/login")
	public String getLogin() {
		
		return "user/login";
	}
	
	
	@PostMapping("/login")
	public String postLogin(String email,String password,HttpSession session) {
		UserVO vo = userService.getUserEmail(email);
		if(vo != null&&vo.getPassword().equals(password)) {
			session.setAttribute("loggedUser", vo);
			return "redirect:/";
		}
		return "redirect:/user/login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session,RedirectAttributes rttr) {
		String access_token = (String) session.getAttribute("access_token");
		UserVO vo = (UserVO) session.getAttribute("loggedUser");
		String social = vo.getSocial();
		
		if(social.equals("naver")) {
			boolean ok = logOutNaverUser(access_token);
			if(ok) {
				System.out.println("로그아웃 성공(네이버)");
				rttr.addFlashAttribute("success","로그아웃되었습니다.");
			}else {
				System.out.println("로그아웃 실패(네이버)");
				rttr.addFlashAttribute("fail","로그아웃에 실패했습니다.");
			}
		}
		else if(social.equals("kakao")) {
			boolean ok = logOutKakaoUser(access_token);
			if(ok) {
				System.out.println("로그아웃 성공(카카오)");
				rttr.addFlashAttribute("success","로그아웃되었습니다.");
			}else {
				System.out.println("로그아웃 실패(카카오)");
				rttr.addFlashAttribute("fail","로그아웃에 실패했습니다.");
			}
		}
		session.invalidate();
		return "redirect:/";
	}
	
	public boolean logOutNaverUser(String access_token) {
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("grant_type", "delete");
		params.add("client_id", naver_client_id);
		params.add("client_secret", naver_client_secret);
		params.add("access_token", access_token);
		params.add("service_provider", "NAVER");
		System.out.println(params);
		
		HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params,headers);
		
		try {
			ResponseEntity<String> response  = rt.exchange(
					"https://nid.naver.com/oauth2.0/token",
					HttpMethod.POST,
					request,
					String.class
					);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("error");
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean logOutKakaoUser(String access_token) {
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer "+ access_token);
		
//		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		
		HttpEntity<MultiValueMap<String, String>> reqeust = new HttpEntity<>(headers);
		
		try {
			ResponseEntity<String> response = rt.exchange(
					"https://kapi.kakao.com/v1/user/logout",
					HttpMethod.POST,
					reqeust,
					String.class
					);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("error");
			e.printStackTrace();
			return false;
		}
		
	}
	
	@GetMapping("/join")
	public String getJoin() {
		return "user/join";
	}
	
	@PostMapping("/join")
	public String postJoin(UserVO vo,RedirectAttributes rttr) {
		vo.setSocial("local");
		if(userService.insert(vo)) {
			rttr.addFlashAttribute("success","회원가입되었습니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("fail","회원가입에 실패하였습니다.");
			return "redirect:/user/join";
		}
	}
	
	@RequestMapping("/checkEmail")
	@ResponseBody
	public String emailCheck(@RequestBody Map<String, Object> req) {
		String email = (String) req.get("email");
		String message = userService.checkEmail(email);
		return message;
	}
	
	@RequestMapping("/userDetail")
	public String userDetail() {
		return "user/userDetail";
	}
	
//	@RequestMapping("/boardList/${path}")
//	public <T> List<T> boardList(@RequestBody ){
//		List<FoodVO> list = userService.getFoodListByUserId(vo.getId());
//		if(path == null) {
//			path="null";
//		}
//		if(path.equals("food")) {
//			List<FoodVO> list = userService.getFoodList();
//			model.addAttribute("path",path);
//			model.addAttribute("foodList",list);
//		}else if(path.equals("resell")) {
//			List<ResellBoardVO> list = userService.getResllList();
//			model.addAttribute("path",path);
//			model.addAttribute("resellList",list);
//		}else if(path.equals("cm")) {
//			List<CommunityFreeBoardVO> list = userService.getCMList();
//			model.addAttribute("path",path);
//			model.addAttribute("cmList",list);
//		}
//	}
	
//	@RequestMapping({"/userDetail","/userDetail/{path}"})
//	public String userDetail(Model model,HttpSession session,@PathVariable(required = false) String path) {
//		UserVO vo = (UserVO) session.getAttribute("loggedUser");
//		List<FoodVO> list = userService.getFoodListByUserId(vo.getId());
//		if(path == null) {
//			path="null";
//		}
//		if(path.equals("food")) {
//			List<FoodVO> list = userService.getFoodList();
//			model.addAttribute("path",path);
//			model.addAttribute("foodList",list);
//		}else if(path.equals("resell")) {
//			List<ResellBoardVO> list = userService.getResllList();
//			model.addAttribute("path",path);
//			model.addAttribute("resellList",list);
//		}else if(path.equals("cm")) {
//			List<CommunityFreeBoardVO> list = userService.getCMList();
//			model.addAttribute("path",path);
//			model.addAttribute("cmList",list);
//		}
//		return "user/userDetail";
//	}
	
	@RequestMapping({"/adminDetail/{path}","/adminDetail"})
	public String adminDetail(Model model,@PathVariable(required = false) String path) {
		
		if(path == null) {
			path ="null";
		}
		if(path.equals("user")) {
			List<UserVO> vo = userService.getUserList();
			model.addAttribute("path","user");
			model.addAttribute("userList",vo);			
		}
		
//		if(path.equals("food")) {
//			List<FoodVO> vo = userService.getFoodList();
//			model.addAttribute("path","food");
//			model.addAttribute("foodList",vo);
//		}
//		
//		if(path.equals("resell")) {
//			List<ResellVO> vo = userService.getResellList();
//			model.addAttribute("path","resell");
//			model.addAttribute("resellList",vo);
//		}
//		
//		if(path.equals("community")) {
//			List<ResellVO> vo = userService.getCommunityList();
//			model.addAttribute("path","community");
//			model.addAttribute("communityList",vo);
//		}
		return "user/adminDetail";
}

	
	@RequestMapping("/edit")
	public String edit() {
		
		return "user/edit";
	}
	
	@PostMapping("/update")
	public String update(UserVO vo,HttpSession session,RedirectAttributes rttr) {
		boolean ok = userService.update(vo);
		if(ok) {
			session.setAttribute("loggedUser", userService.getUserEmail(vo.getEmail()));
			rttr.addFlashAttribute("success","업데이트되었습니다");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("fail","업데이트에 실패했습니다.");
			return "redirect:/user/userDetail";
		}
	}
	
	@PostMapping("/userDelete")
	public String userDetele(String email,HttpSession session,RedirectAttributes rttr) {
		boolean ok = userService.deleteUserEmail(email);
		System.out.println(ok);
		if(ok) {
			session.invalidate();
			rttr.addFlashAttribute("success","계정이 삭제되었습니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("fail","계정삭제에 실패했습니다.");
			return "redirect:/";
		}
	}
	
	@PostMapping("/adminDelete")
	public String adminDelete() {
		
		return "redirect:/user/adminDetail";
	}
	
}
