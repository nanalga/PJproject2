package com.pj.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.pj.domain.ResellBoardVO;
import com.pj.domain.ResellPageInfoVO;
import com.pj.service.ResellBoardService;

import lombok.Setter;

@Controller
@RequestMapping("/resellMarket/resellBoard")
public class ResellBoardController implements WebMvcConfigurer {
	
	@Setter(onMethod_ = @Autowired)
	private ResellBoardService service;
	
	@RequestMapping("/resell")
	public void method01() {
		System.out.println(" resellMarket/resellBoard test");
	}
	
	@RequestMapping("/test")
	public void example() {
		
	}
	
	@RequestMapping("/test2")
	public void example2() {

	}
	
	@RequestMapping("/test3")
	public void example3 () {
		
	}
	
	@GetMapping("/resellBoardList")
	public void list(@RequestParam(value="page", defaultValue = "1") Integer page,Model model) {

		System.out.println(page);
		Integer numberPerPage = 10; // 한 페이지의 row 수
		
		
		// 3. 비즈니스 로직
		//게시물 목록 조회
//		List<ResellBoardVO> list = service.getList();
		List<ResellBoardVO> list = service.getListPage(page, numberPerPage);
		ResellPageInfoVO pageInfo = service.getPageInfo(page, numberPerPage);
		// 4. add attribute
		model.addAttribute("resellList", list);
		model.addAttribute("pageInfo", pageInfo);
		// 5 . forward, redirect
		
		//jsp path : /WEB-INF/views/resellMarket/list
		
	}
	
	
	//resellBoard/get?id=10
	@GetMapping({"/resellBoardGet","resellBoardModify"})
	public void get(@RequestParam("id") Integer id, Model model) {
		ResellBoardVO resellBoard = service.get(id);
		
		model.addAttribute("resellBoard", resellBoard);
		
	}
	
	@PostMapping("/resellBoardModify")
	public String  modify(ResellBoardVO resellBoard, RedirectAttributes rttr ) {
		if (service.modify(resellBoard)) {
			rttr.addFlashAttribute("result", resellBoard.getId() + "번 게시글이 수정되었습니다.");
		}
		
		rttr.addAttribute("id", resellBoard.getId());
		/*게시물 조회로 redirect
		return "redirect:/resellMarket/resellBoard/resellBoardGet";
		*/
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	

	@GetMapping("/resellBoardRegister")
	public void register() {
		
	}
	
	@PostMapping("/resellBoardRegister")
	public String register(ResellBoardVO resellBoard, RedirectAttributes rttr) {
		// 2. request 분석 가공 dispatcherServlcet이 해줌
		
	
		// 3. 비즈니스 로직
		service.register(resellBoard);
		
		// 4. add attribute
		rttr.addFlashAttribute("result", resellBoard.getId() +"번 게시글이 등록되었습니다.");
		
		// 5. forward.redirect
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	
	@PostMapping("/ResellBoardRemove")
	public String remove(@RequestParam("id") Integer id, ResellBoardVO resellBoard, RedirectAttributes rttr) {
		
		if (service.remove(id)) {
			rttr.addFlashAttribute("result", id + "번 게시글이 삭제되었습니다.");
		}
		rttr.addFlashAttribute("id", resellBoard.getId()); // 쿼리스트링
		
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}

	@RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {

		JsonObject jsonObject = new JsonObject();

		/*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */

		// 내부경로로 저장
		String contextRoot = "C:\\Users\\user\\Desktop\\COURS\\java\\workspace\\PJproject\\src\\main\\webapp\\";
		String fileRoot = contextRoot + "resources\\fileupload\\";

//		System.out.println(fileRoot);

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
//			jsonObject.addProperty("url", targetFile.getAbsolutePath()); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", "/fileupload"); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");

			// s3에 저장
			jsonObject.addProperty("url", service.uploadToS3(savedFileName, multipartFile));

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	
	

}












