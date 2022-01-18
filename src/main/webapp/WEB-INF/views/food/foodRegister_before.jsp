<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" integrity="sha512-bnIvzh6FU75ZKxp0GXLH9bewza/OIw6dLVh9ICg0gogclmYGguQJWl8U30WpbsGTqbIiAwxTsbe76DErLq5EDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />

<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- include plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-ko-KR.js" type="module" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-lite.js" type="module" ></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4312ec82fed74fec65ab6c6ffa59a5c8&libraries=services,clusterer,drawing"></script>

<!--주소화면 외부js  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/address.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<title>Insert title here</title>
</head>
<body>
<div class="body_wrapper">	
	<tag:nav></tag:nav>
	<div style="width:80%; margin: auto;">
		<form id="form1" method="post" enctype="multipart/form-data">
		
			<label>작성자</label>
				<input class="form-control" type="text" id="inputWriter" name="writer" style="width: 40%;" readonly="readonly" value="${sessionScope.loggedUser.name }" /> <br>
			<label>제목</label>
				<input class="form-control" type="text" id="inputTitle" name="title" style="width: 100%;" placeholder="제목"/> <br>
			<label>내용</label>
				<textarea id="summernote" name="contents"></textarea>
				
			<div class="form-group">
				<label for="addressInput">주소</label>
				<input type="text" class="form-control" id="addressInput" required name="address" value="${loggedUser.address }">
			</div>
			<div class="form-group">
				<div id="map" style="width: 350px; height: 280px; margin-top: 10px;"></div>
			<%--
 				 <div id="map" style="width:400px;height:400px;"></div> 
   			--%>
				<div id="clickLatlng" style="display: none"></div>
			</div>	
				
			<button id="RegisterSubBtn" >글작성</button>
			
			<!-- <input id="subBtn" type="submit" value="글 작성" style="float: right;" onclick="goWrite(this.form)"/> -->
			<small class="form-text" id="nickNameCheckMessage"></small>
			<!-- <button id="modifySubmitButton" type="submit" value="글 수정" style="float: right;">글 작성</button> -->
		</form>
			<a href="foodList" class="btn btn-outline-secondary">목록</a>
	</div>
</div>
<script>
$(document).ready(function(){
	const appRoot = '${pageContext.request.contextPath}';
	
	$("#RegisterSubBtn").click(function(e){
		e.preventDefault();
		var title = $("#inputTitle").val();
		var contents = $("#summernote").val();
		
		if (title == "") {
			alert("제목을 입력하세요.");
			document.form1.title.focus();
			return;
		} else if (contents == "") {
			alert("내용을 입력하세요.");
			document.form1.contents.focus();
			return;
		}		
		$("#form1").submit();
	});
	
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
			 callbacks : {
				 onImageUpload: function(files) {
				     // upload image to server and create imgNode...
				     for(var i = files.length -1; i>= 0; i-- ){
				    	 uploadSummernoteImageFile(files[i], this);
				     }
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
				
				$("#form1").append($("<input name='imageKey' type='hidden' />").val(d.imageKey));
			}
		});
	}
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.499817, 127.030277), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	var addressMap = $("#addressInput").val();
	console.log(addressMap);

	const mapHandler = () => {
		
		 //카카오 지도 발생
	    new daum.Postcode({
	        oncomplete: function(data) { //선택시 입력값 세팅
	            document.getElementById("addressInput").value = data.address; // 주소 넣기
				
	            geocoder.addressSearch(data.address, function(result, status) {

	                // 정상적으로 검색이 완료됐으면 
	                 if (status === kakao.maps.services.Status.OK) {
	            		
	                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	            		var message = 'latlng: new kakao.maps.LatLng(' + result[0].y + ', ';
	            		message += result[0].x + ')';
	            		
	            		var resultDiv = document.getElementById('clickLatlng'); 
	            		resultDiv.innerHTML = message;
	            		
	                    // 결과값으로 받은 위치를 마커로 표시합니다
	                    var marker = new kakao.maps.Marker({
	                        map: map,
	                        position: coords
	                    });

	                    // 인포윈도우로 장소에 대한 설명을 표시합니다
	                    var infowindow = new kakao.maps.InfoWindow({
	                        content: '<div style="width:150px;text-align:center;padding:6px 0;">장소</div>'
	                    });
	                    infowindow.open(map, marker);

	                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	                    map.setCenter(coords);
	                } 
	            })
	            
			//	document.querySelector("input[name=price]").focus();
			//  document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
	        }


	    }).open();
		
	}
	
	document.getElementById("addressInput").addEventListener("click", mapHandler)//주소입력칸을 클릭하면
	
});
</script>
 
<tag:footer></tag:footer>
<tag:menu></tag:menu>
 ﻿
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>