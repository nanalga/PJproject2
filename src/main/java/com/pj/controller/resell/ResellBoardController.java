package com.pj.controller.resell;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.pj.domain.resell.ResellBoardVO;
import com.pj.domain.resell.ResellPageInfoVO;
import com.pj.domain.resell.ResellReplyVO;
import com.pj.domain.user.UserVO;
import com.pj.service.resell.ResellBoardService;
import com.pj.service.resell.ResellReplyService;

import lombok.Setter;

@Controller
@RequestMapping("/resellMarket/resellBoard")
public class ResellBoardController implements WebMvcConfigurer {
	
	@Setter(onMethod_ = @Autowired)
	private ResellBoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private ResellReplyService rservice;
	
	@RequestMapping("/resell")
	public void method01() {
		System.out.println(" resellMarket/resellBoard test");
	}
	

	
/*
	// 위에 꺼 테스트용
	@GetMapping("/resellBoardSearch")
	public void searchPageList(HttpServletRequest request,@RequestParam(value="page", defaultValue = "1") Integer page,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			Model model) {
		
		System.out.println("resellBoardSearch 도착");
		System.out.println(searchType + ", " + keyword);
		System.out.println("boardlistpage : " + page);
		
		Integer numberPerPage = 10; // 한 페이지의 row 수
		
		// 3. 비즈니스 로직
		//게시물 목록 조회
//		List<ResellBoardVO> list = service.getList();
		List<ResellBoardVO> list = service.getListPage(page, numberPerPage, searchType, keyword);
		
		ResellPageInfoVO pageInfoSearch = service.getPageInfoSearch(page, numberPerPage, searchType, keyword);
		// 4. add attribute
		model.addAttribute("resellList", list);
		model.addAttribute("pageInfo", pageInfoSearch);
		// 5 . forward, redirect
		
		//jsp path : /WEB-INF/views/resellMarket/list
		System.out.println("---------");
		System.out.println("pageinfo : " + pageInfoSearch);
	}	
 * */	
	
	@GetMapping("/resellBoardList")
	public void list(HttpServletRequest request,@RequestParam(value="page", defaultValue = "1") Integer page,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			Model model) {
		
		Integer numberPerPage = 10; // 한 페이지의 row 수
		
		// 3. 비즈니스 로직
		//게시물 목록 조회
		List<ResellBoardVO> list = service.getListPage(page, numberPerPage, searchType, keyword);
		Integer BoardTotalCnt = service.getBoardTotalCnt();
		
		ResellPageInfoVO pageInfo = service.getPageInfoSearch(page, numberPerPage, searchType, keyword);
		// 4. add attribute
		model.addAttribute("resellList", list);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("BoardTotalCnt", BoardTotalCnt);
		// 5 . forward, redirect
		
		//jsp path : /WEB-INF/views/resellMarket/list
	}
		
	
	
	//resellBoard/get?id=10
	@GetMapping({"/resellBoardGet","resellBoardModify"})
	public void get(@RequestParam("id") Integer id, Model model, MultipartFile file,
			@RequestParam(value= "nowDate", required = false) String nowDate) {
		System.out.println("resellBoardGet or Modify 도착");
		
		ResellBoardVO resellBoard = service.get(id);
		System.out.println("board주소 : " + resellBoard.getAddress());
		
		service.boardPlusCnt(id);
		
		//현재 일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter = 
				DateTimeFormatter.ofPattern("YYYY-MM-dd hh:mm");
		String nowString = now.format(dateTimeFormatter);
		
		model.addAttribute("nowDate", nowString);
		
		model.addAttribute("resellBoard", resellBoard);
		
	}
	
	@PostMapping("/resellBoardModify")
	public String  modify(ResellBoardVO resellBoard, RedirectAttributes rttr ) {
		System.out.println("resellBoardModify Post 도착");
		
		if (service.modify(resellBoard)) {
			rttr.addFlashAttribute("result", resellBoard.getId() + "번 게시글이 수정되었습니다.");
		}
		//쿼리 스트링
		rttr.addAttribute("id", resellBoard.getId()); 
		/*게시물 조회로 redirect
		return "redirect:/resellMarket/resellBoard/resellBoardGet";
		*/
		System.out.println("imageKey :" + resellBoard.getImageKey());
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	

	@GetMapping("/resellBoardRegister")
	public void register(RedirectAttributes rttr,Model model, @RequestParam(value= "nowDate", required = false) String nowDate) {
		System.out.println("resellBoardRegister도착");
		
		//현재 일시
		LocalDateTime now = LocalDateTime.now(ZoneId.of("+09:00"));
		DateTimeFormatter dateTimeFormatter = 
				DateTimeFormatter.ofPattern("YYYY-MM-dd hh:mm");
		String nowString = now.format(dateTimeFormatter);
		
		model.addAttribute("nowDate", nowString);
		
		
	}
	
	@PostMapping("/resellBoardRegister")
	public String register(ResellBoardVO resellBoard, MultipartFile[] files, RedirectAttributes rttr,@SessionAttribute(value= "loggedUser", required = false) UserVO logged) {
		System.out.println("resellBoard :" + resellBoard);
		
		// 2. request 분석 가공 dispatcherServlcet이 해줌
		resellBoard.setMemberId(logged.getId());
		
	
		
		// 3. 비즈니스 로직
		service.register(resellBoard);
		
		System.out.println("imageKey :" + resellBoard.getImageKey());
		// 4. add attribute
		rttr.addFlashAttribute("result", resellBoard.getId() +"번 게시글이 등록되었습니다.");
		
		// 5. forward.redirect
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	
	@PostMapping("/resellBoardRemove")
	public String remove(@RequestParam("id") Integer id, ResellBoardVO resellBoard, RedirectAttributes rttr) {
		System.out.println("삭제 도착");
		if (service.remove(id)) {
			rttr.addFlashAttribute("result", id + "번 게시글이 삭제되었습니다.");
		}
		rttr.addFlashAttribute("id", resellBoard.getId()); // 쿼리스트링
		
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	
	// 검색내
	@RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(ResellBoardVO ResellBoard,@RequestParam("file") MultipartFile multipartFile,
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

//		File targetFile = new File(fileRoot + savedFileName);
		try {
//			InputStream fileStream = multipartFile.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
//			jsonObject.addProperty("url", targetFile.getAbsolutePath()); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("url", "/fileupload"); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");

			// s3에 저장
			jsonObject.addProperty("url", service.uploadToS3(savedFileName, multipartFile));
			jsonObject.addProperty("imageKey", "resell/" + savedFileName);
			
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
	public String modifySummernoteImageFile(ResellBoardVO ResellBoard, @RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		System.out.println("modifySummernoteImageFile 접근");
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
			jsonObject.addProperty("imageKey", "resell/" + savedFileName);
			System.out.println("urlModify :"  + savedFileName);
		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String imageUrl = jsonObject.toString();
		System.out.println("uploadSummernoteImageFile imageUrl : " + imageUrl);
		return imageUrl;
	}
	

}