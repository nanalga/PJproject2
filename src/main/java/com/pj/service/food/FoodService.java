package com.pj.service.food;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pj.domain.food.FoodPageInfoVO;
import com.pj.domain.food.FoodVO;
import com.pj.mapper.food.FoodFileMapper;
import com.pj.mapper.food.FoodMapper;
import com.pj.mapper.food.FoodReplyMapper;

import lombok.Setter;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class FoodService {

	@Setter(onMethod_ = @Autowired)
	private FoodMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private FoodReplyMapper replyMapper;

	@Setter(onMethod_ = @Autowired)
	private FoodFileMapper filemapper;

//	private String staticRoot = "C:\\Users\\user\\Desktop\\course\\fileupload\\";

	// aws image api 활용
	@Value("${aws.accessKeyId}") // @Value (Spring 사용)
	private String accessKeyId;

	@Value("${aws.secretAccessKey}")
	private String secretAccessKey;

	@Value("${aws.bucketName}")
	private String bucketName;
	
	@Value("${aws.staticUrl}")
	private String staticUrl;

	// aws java library 사용
	private Region region = Region.AP_NORTHEAST_2;

	private S3Client s3;

	// aws
	@PostConstruct
	public void init() {
		// spring bean이 만들어진 후 최초로 실행되는 코드 작성

		// 권한 정보 객체
		AwsBasicCredentials credentials = AwsBasicCredentials.create(accessKeyId, secretAccessKey);

		// crud 가능한 s3 client 객체 생성
		this.s3 = S3Client.builder().credentialsProvider(StaticCredentialsProvider.create(credentials)).region(region)
				.build();

		System.out.println("############ s3 cilent ############");
		System.out.println(s3);
	}

	// s3에서 key에 해당하는 객체 삭제
	// 객체(이미지 파일) 업로드/지우기
	private void deleteObject(String key) {
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();

		s3.deleteObject(deleteObjectRequest);
	}

	// s3에서 key로 객체 업로드(put)
	private void putObject(String key, Long size, InputStream source) {
		PutObjectRequest putObjectRequest = PutObjectRequest.builder().bucket(bucketName).key(key)
				.acl(ObjectCannedACL.PUBLIC_READ).build();

		RequestBody requestBody = RequestBody.fromInputStream(source, size);

		s3.putObject(putObjectRequest, requestBody);
	}

	public List<FoodVO> getList() {

		return mapper.getList();
	}

	public boolean register(FoodVO food) {
		System.out.println("Service RegisterFood : " + food);

		return mapper.insert(food) == 1;
	}

	public FoodVO get(Integer id) {
		return mapper.selectRead(id);
	}

	public boolean modify(FoodVO food) {
		return mapper.modify(food) == 1;
	}

	public boolean remove(Integer id) {
		// 게시물에 달린 댓글 지우기
		replyMapper.foodDeleteByBoardId(id);
		
		// 파일(사진) s3 지우기
		
		
		// 게시물 지우기
		return mapper.delete(id) == 1;
	}
	
	public String uploadToS3(String key, MultipartFile file) throws IOException {
//		String key = "";
		putObject("board/" + key, file.getSize(), file.getInputStream());
		
		String foodFileUrl = "board/" + key;
		System.out.println("foodFileUrl : " + foodFileUrl);
		//filemapper.fileUrlInsert(foodFileUrl);
		
		System.out.println("staticUrl : " + staticUrl);
		System.out.println("staticUrl + / + key : " + staticUrl + "/" + key);
		
		return staticUrl + "/" + key;
	}
	
	public String modifyToS3(String key, MultipartFile file) throws IOException {
		
		deleteObject(key);
		
		putObject("board/" + key, file.getSize(), file.getInputStream());
		
		return staticUrl + "/" + key;
	}
	

	public List<FoodVO> getFoodListPage(Integer page, Integer numberPerPage, String searchType, String keyword) {
		Integer from = (page - 1) * 10;
		
		return mapper.getFoodListPage(from, numberPerPage, searchType, keyword);
	}

	public FoodPageInfoVO getFoodPageInfo(Integer page, Integer numberPerPage) {
		// 총 게시물 수
		Integer countRows = mapper.getFoodCountRows();
		
		// 마지막 페이지 번호
		Integer lastPage = (countRows - 1) / numberPerPage + 1;
		
		// 페이지네이션 가장 왼쪽 번호
		Integer leftPageNumber = (page - 1) / 10 * 10 + 1;
		
		// 페이지네이션 가장 오른쪽 번호
		Integer rightPageNumber = (page - 1) / 10 * 10 + 10;
		
		// 가장 마지막 페이지를 넘어가지 않도록
		rightPageNumber = rightPageNumber > lastPage ? lastPage : rightPageNumber;
		
		// 이전 페이지 버튼 유무
		Boolean hasPrevButton = leftPageNumber != 1;
		
		// 다음 페이지 버튼 유무
		Boolean hasNextButton = rightPageNumber != lastPage;
		
		FoodPageInfoVO foodPageInfo = new FoodPageInfoVO();
		
		foodPageInfo.setLastPage(lastPage);
		foodPageInfo.setCountRows(countRows);
		foodPageInfo.setCurrentPage(page);
		foodPageInfo.setLeftPageNumber(leftPageNumber);
		foodPageInfo.setRightPageNumber(rightPageNumber);
		foodPageInfo.setHasPrevButton(hasPrevButton);
		foodPageInfo.setHasNextButton(hasNextButton);
		
		System.out.println(foodPageInfo);
		
		return foodPageInfo;
	}

	public boolean foodPlusCount(Integer id) {
		return mapper.foodPlusCount(id) == 1;
	}



}