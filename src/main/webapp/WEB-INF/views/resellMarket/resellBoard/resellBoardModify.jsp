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

<title>resellBoardModify</title>
</head>
<body>

<div class="body_wrapper">
<tag:nav></tag:nav>
<!-- .contatiner>.row>.col>h1{게시물 수정} -->
<div class="main_container">
	<div class="row" style="width: 80%">
		<div class="col">
			<h1>게시물 수정</h1>
			<!-- form>.form-group*4>label[for=input$]+input.form-control#input$ -->
			<form id="modifyForm" name="modifyForm"  method="post">
				<!-- input:hidden[value][name=id] -->
				<input type="hidden" name="id" value="${resellBoard.id }">
				<div class="form-group">
					<label for="titleInput">제목</label>
					<input type="text" class="form-control" id="titleInput" value="${resellBoard.title }"  name="title">
				</div>
				<div class="form-group">
					<label for="contentInput">내용</label>
					<textarea class="form-control" id="summernote"  name="content" >${resellBoard.content }</textarea>
				</div>
				  <div class="form-group">
				    <label for="exampleFormControlFile1"> images files </label>
				    <input type="file" class="form-control-file" id="imgInput" name="files" accept="image/*" multiple>
				  </div>
				<div class="form-group">
					<label for="writerInput">작성자</label>
					<input type="text" class="form-control" id="writerInput"  value="${resellBoard.writer }" name="writer" readonly>
				</div>
					<div class="form-group">
						<label for="addressInput">주소</label>
						<input type="text" class="form-control" id="addressInput" required name="address" readonly value="">
					</div>				
				<div class="form-group">
					<label for="priceInput">가격</label>
					<input type="text" class="form-control" id="priceInput"  value="${resellBoard.price }"  name="price">
				</div>				
				<a class="btn btn-outline-primary" id="modifyA" data-toggle="modal" >수정하기</a>
				<%--
				<button id="modifySubmitButton" class="btn btn-outline-primary" type="button" data-toggle="modal" data-target="#modifyModal">수정</button>
				 --%>
				
				<button id="removeSubmitButton" class="btn btn-outline-danger" type="button"  data-toggle="modal" data-target="#deleteModal">삭제</button>
			
			</form>
		</div>
	</div>
</div>
</div>

<!-- 수정Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabelmodify">수정확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>수정하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button id="modifyModalButton" type="button" class="btn btn-secondary" data-dismiss="modal">수정하기</button>
        <button id="notModifyModalButton" type="button" class="btn btn-primary"  data-toggle="modal">취소</button>
      </div>
    </div>
  </div>
</div>



<!-- 삭제Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabeldelete">삭제 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>정말로 삭제 하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button id="removeModalButton"type="button" class="btn btn-secondary" data-dismiss="modal">"삭제하기"</button>
        <button id="notRemoveModalButton" type="button" class="btn btn-primary"  data-toggle="modal" >삭제 취소</button>
      </div>
    </div>
  </div>
</div>



<tag:footer></tag:footer>
<tag:menu></tag:menu>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	const appRoot = '${pageContext.request.contextPath}';
	
	$("#removeModalButton").click(function(e) {
		e.preventDefault();  // 기본동작을 진행 안함
		$("#modifyForm").attr("action","ResellBoardRemove").submit();
	});
	
	$("#modifyModalButton").click(function(e){
		e.preventDefault();
		$("#modifyForm").attr("action","resellBoardModify").submit();
	});
	$("#notRemoveModalButton").click(function(e) {
		e.preventDefault();
		$("#deleteModal").modal("hide");
	})
	
	$("#notModifyModalButton").click(function(e) {
		e.preventDefault();
		$("#modifyModal").modal("hide");
	})

	// summerNote
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
			url : appRoot + "/food/modifySummernoteImageFile",
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
		const titleIp = $("#titleInput");
		const contentIp = $("#summernote");
		const priceIp = $("#priceInput");
		const submitButton1 = $("#submitButton1");
	

		
	$("#modifyA").click(function(e) {
		e.preventDefault();
		const titleValue = $("#titleInput").val();
		const contentValue = $("#summernote").val();
		const priceValue = $("#priceInput").val();
		
		console.log(titleValue);
		console.log(contentValue);
		console.log(priceValue);
		if (titleValue =="") {
			alert("제목을 작성해주세요");
			console.log("title if");
			document.modifyForm.title.focus();
			return ;
		} 
/*  
 
		else if ( contentValue === "") {
			console.log("content if");
			alert("내용을 작성해주세요");
			document.modifyForm.content.focus();
			return ;
		}
 */		
		else if ( priceValue == "") {
			console.log("price if");
			alert("가격을 입력해주세요");
			document.modifyForm.price.focus();
			return ;
		} 
		
		$("#modifyForm").submit();
		
	});
	
	
	
	
	
});
/* 	$(document).ready(function() {
		$("#removeSubmitButton").click(function(e) {
			e.preventDefault();  // 기본동작을 진행 안함
			$("#modifyForm").attr("action","ResellBoardRemove").submit();
		});
		
		$("#modifySubmitButton").click(function(e){
			e.preventDefault();
			$("#modifyForm").attr("action","resellBoardModify").submit();
		});
		
	}); */
</script>


</body>
</html>