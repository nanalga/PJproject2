<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />


<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!--주소화면 외부js  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/address.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<title>resellBoardRegister</title>
</head>
<body>

<div class="body_wrapper">
<tag:nav></tag:nav>

<!-- .contatiner>.row>.col>h1{게시물 작성} -->
<div class="main_container">
	<div class="row" style="width: 80%; margin : auto;" >
		<div class="col">
			<h1>게시물 작성</h1>
			<!-- form>.form-group*4>label[for=input$]+input.form-control#input$ -->
			<form action="" method="post" enctype="multipart/form-data" >
				<div class="form-group">
					<label for="titleInput">제목</label>
					<input type="text" class="form-control" id="titleInput" name="title">
				</div>
				<div class="form-group">
					<label for="contentInput">내용</label>
					<textarea class="form-control" id="summernote" name="content"></textarea>
				</div>
				<!-- .form-group>label[for=input4]+input[type=file].form-control-file#input4[name=files] -->
				  <div class="form-group">
				    <label for="input4"> images files </label>
				    <input type="file" class="form-control-file" id="input4" name="files" accept="" multiple>
				  </div>
				<div class="form-group">
					<label for="writerInput">작성자</label>
					<input type="text" class="form-control" id="writerInput" name="input3"  readonly value="${sessionScope.loggedUser.name }">
				</div>
				<input type="hidden" name="writer" value="${sessionScope.loggedUser.name }">
				<div class="form-group">
					<label for="addressInput">주소</label>
					<input type="text" class="form-control" id="addressInput" required name="address" readonly value="">
				</div>	 				
 				
 				<div class="form-group">
					<label for="priceInput">가격</label>
					<input type="text" class="form-control" id="priceInput" name="price">
				</div>
				<button class="btn btn-outline-primary" id="submitButton1">등록</button>
				<button class="btn btn-outline-primary" style="float: right;"><a href="javascript:history.back();">뒤로가기</a></button>
			<%--
				<input id="subBtn" type="submit" value="글 목록" style="float: right;" onclick="${history.go(-1)}"/>
		 --%>		
			</form>
		</div>
	</div>
</div>
</div>

<tag:footer></tag:footer>
<tag:menu></tag:menu>
<script>
$(document).ready(function(){
	
	const appRoot = '${pageContext.request.contextPath}';
	
	var fontList = ['맑은 고딕', '돋움', '궁서', '굴림', '굴림체', '궁서체', '나눔 고딕', '바탕', '바탕체',
					'새굴림', 'HY견고딕', 'HY견명조', 'HY궁서B', 'HY그래픽M', 'HY목각파임B', 'HY신명조', 'HY얕은샘물M',
					'HY엽서L', 'HY엽서M', 'HY중고딕', 'HY헤드라인M', '휴먼매직체', '휴먼모음T', '휴먼아미체',
					'휴먼둥근헤드라인', '휴먼편지체', '휴먼옛체'
					];
	var toolbar =  [
	    ['style', ['style']],
	    ['font', ['bold', 'underline', 'clear']],
	    ['fontname', ['fontname','fontsize','fontsizeunit']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['table', ['table']],
	    ['insert', ['link', 'picture']],
	    ['view', ['fullscreen', 'codeview', 'help']]
	  ];
	var setting = {
			 placeholder: 'Hello stand alone ui',
			 height: 400,
	         lang : 'ko-KR',
			 minHeight: null,
			 maxHeight: null,
			 fontNames: fontList,
			 fontNamesIgnoreCheck: fontList,
			 fontSizes: ['8','9','10','11','12','14','18','24','36'],
			 toolbar : toolbar,
			 //콜백 함수
			 /*
	         callbacks : { 
	            onImageUpload : function(files, editor, welEditable) {
	            	// 파일 업로드(다중업로드를 위해 반복문 사용)
	            	for (var i = files.length - 1; i >= 0; i--) {
	            		uploadSummernoteImageFile(files[i], this);
	            	}
	            }
	         }
	*/
			 callbacks : {
				 onImageUpload: function(files) {
				     // upload image to server and create imgNode...
				     for(var i = files.length -1; i>= 0; i-- ){
				    	 uploadSummernoteImageFile(files[i], this);
				     }
				     // uploadSummernoteImageFile(files[0], this);
			     }
			 }
	};
	
	$('#summernote').summernote(setting);
	
	/**
	* 이미지 파일 업로드
	*/
    function uploadSummernoteImageFile(file, el) {
		let data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : appRoot + "/food/uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(d) {
				/* const parseData = JSON.parse(d);
				console.log("s-data:", parseData.url); */
				//$(el).summernote('editor.insertImage', d.url);
				let imgNode = document.createElement("img");
				$(imgNode).attr("src", d.url);
				$(el).summernote('insertNode', imgNode);
			}
		});
	}
	
	
	// #submitButton1 버튼 클릭됬을때
	// 사용 가능 또는 불가능 메세지 출려
		// 아래 코드에서 필요한 요소를 선택
		const titleInput = $("#titleInput");
		const contentInput = $("#summernote");
		const priceInput = $("#priceInput")
		const submitButton = $("#submitButton1");

		
		// submit 버튼 활성화 조건 변수
		
		const confirmFunction = function() {
			const titleValue = titleInput.val();
			const contentValue = contentInput.val();
			const priceValue = priceInput.val();
			
		if ( (titleValue != "") && (contentValue != "") && (priceValue != "")  ) {
			submitButton.removeAttr("disabled");
		} else {
			submitButton.attr("disable", true);
			
		}
	};
		

	submitButton.attr("disabled", true);
	
	titleInput.keyup(confirmFunction);
	
	contentInput.keyup(confirmFunction);
	priceInput.keyup(confirmFunction);
	
		

		
	
	
	
});
</script>

<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>








