package com.pj.controller.food;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.pj.domain.food.FoodPageInfoVO;
import com.pj.domain.food.FoodVO;
import com.pj.domain.user.UserVO;
import com.pj.service.food.FoodService;

import lombok.Setter;

@Controller
@RequestMapping("/food")
public class FoodController implements WebMvcConfigurer {

	@Setter(onMethod_ = @Autowired)
	private FoodService service;

	@RequestMapping("/foodList")
	public void foodList(@RequestParam(value = "page", defaultValue = "1") Integer page,
			@RequestParam(value = "searchType", defaultValue = "title") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
		System.out.println("foodList Controller 접근");
		FoodVO food = new FoodVO();
		System.out.println("foodBoardTotal : " + food.getFoodBoardTotalCount());
		
		Integer numberPerPage = 10;
		
		List<FoodVO> list = new ArrayList<FoodVO>();
		
		int foodListCnt = service.getFoodListCnt(); // 게시글만 조회
		
		list = service.getFoodListPage(page, numberPerPage, searchType, keyword);
		model.addAttribute("list", list);
		model.addAttribute("foodBoardTotalCount", foodListCnt);
		
//		listSearch = service.searchPageInfo();
		
		FoodPageInfoVO pageInfo = new FoodPageInfoVO();
		
//		pageInfo.setsearchTypeKeyword(searchType, keyword);
		
		pageInfo = service.getFoodPageInfo(page, numberPerPage, searchType, keyword);
		model.addAttribute("pageInfo", pageInfo);
	}
	
	@GetMapping({ "/foodGet", "/foodModify", "/foodRemove" })
	public void foodGet(@RequestParam("id") Integer id, Model model,
			@RequestParam(value= "nowDate", required = false) String nowDate) {
		System.out.println("controller foodget접근");
		FoodVO food = service.get(id);
//		System.out.println("foodGet : "+ food.getFoodReplyCount());
		service.foodPlusCount(id);
		
		
		//현재 일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter = 
				DateTimeFormatter.ofPattern("YYYY-MM-dd hh:mm");
		String nowString = now.format(dateTimeFormatter);
		
		model.addAttribute("nowDate", nowString);
		

		model.addAttribute("food", food);
	}

	@GetMapping("/foodRegister")
	public void foodRegister(RedirectAttributes rttr,Model model, @RequestParam(value= "nowDate", required = false) String nowDate) {
		System.out.println("controller foodRegister 접근");
		//현재 일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter = 
		DateTimeFormatter.ofPattern("YYYY-MM-dd hh:mm");
		String nowString = now.format(dateTimeFormatter);
		
		model.addAttribute("nowDate", nowString);
	}

	@PostMapping("/foodModify")
	public String foodModify(FoodVO food, RedirectAttributes rttr, @RequestParam(value = "id", required = true) Integer id) {
		System.out.println("controller foodModify Post 접근");
				
		if (service.modify(food)) {
			rttr.addFlashAttribute("result", food.getId() + "의 게시글이 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("result", food.getId() + "의 게시글이 수정 실패되었습니다.");
		}
		rttr.addAttribute("id", food.getId());	// 쿼리 스트링

		return "redirect:/food/foodList";
	}
	
//	@GetMapping("/foodRemove")
//	public void foodRemove(@RequestParam(value = "id", required = true) Integer id,  RedirectAttributes rttr) {
//		if (service.remove(id)) {
//			rttr.addFlashAttribute("result", id + "번 게시물이 삭제되었습니다.");
//		}
//	}
	
	@PostMapping("/foodRemove")
	public String foodRemove(@RequestParam(value = "id", required = true) Integer id, FoodVO food, RedirectAttributes rttr) {
		if (service.remove(id)) {
			rttr.addFlashAttribute("result", id + "번 게시물이 삭제되었습니다.");
		}
		
		rttr.addAttribute("id", food.getId());	// 쿼리 스트링
		
		return "redirect:/food/foodList";
	}

	@PostMapping("/foodRegister")
	public String register(FoodVO food, @SessionAttribute(value = "loggedUser", required = false) UserVO logged) {
//		System.out.println("register-images : " + Arrays.toString(food.getImageKey()));
		
		food.setMemberId(logged.getId());
		
		service.register(food);
		
		return "redirect:/food/foodList";
	}

	@RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8" )
	@ResponseBody
	public String uploadSummernoteImageFile(FoodVO food, @RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부경로로 저장
		String contextRoot = "C:\\Users\\user\\Desktop\\COURS\\java\\workspace\\PJproject\\src\\main\\webapp\\";
		String fileRoot = contextRoot + "resources\\fileupload\\";

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

//		File targetFile = new File(fileRoot + savedFileName);
		try {
//			InputStream fileStream = multipartFile.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
//			jsonObject.addProperty("url", targetFile.getAbsolutePath()); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", "/fileupload"); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");

			// s3에 저장
			jsonObject.addProperty("url", service.uploadToS3(savedFileName, multipartFile));
			jsonObject.addProperty("imageKey", "board/food/" + savedFileName);

		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String imageUrl = jsonObject.toString();
		System.out.println("uploadSummernoteImageFile imageUrl : " + imageUrl);
		return imageUrl;
	}
	

	@RequestMapping(value = "/modifySummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String modifySummernoteImageFile(FoodVO food, @RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {

		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부경로로 저장
		String contextRoot = "C:\\Users\\user\\Desktop\\COURS\\java\\workspace\\PJproject\\src\\main\\webapp\\";
		String fileRoot = contextRoot + "resources\\fileupload\\";

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

//		File targetFile = new File(fileRoot + savedFileName);
		try {
//			InputStream fileStream = multipartFile.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
//			jsonObject.addProperty("url", targetFile.getAbsolutePath()); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", "/fileupload"); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");

			// s3에 수정
			jsonObject.addProperty("url", service.modifyToS3(savedFileName, multipartFile));
			jsonObject.addProperty("imageKey", "board/food/" + savedFileName);

		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	
	
}