<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>


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


<!-- include plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-ko-KR.js" type="module" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-lite.js" type="module" ></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4312ec82fed74fec65ab6c6ffa59a5c8&libraries=services,clusterer,drawing"></script>

<!--주소화면 외부js  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/address.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>




<script>
$(document).ready(function() {
	/*contextPath */
	const appRoot = '${pageContext.request.contextPath}'
	
		/* 현재 게시물의 댓글 목록 가져오는 함수 */
	const listReply = function () {
		$("#replyListContainer").empty();	
		
		$.ajax({
			url : appRoot + "/resellReply/resellBoard/${resellBoard.id}",
			success : function(list) {
				for(let i = 0; i <list.length; i++) {
					const replyMediaObject = $(`				
		            		<hr>
			                  <div class="media">
			                    <div class="media-body">
			                      <h5 class="mt-0"><i class="far fa-comment"></i>
			                      <span class="reply-name"></span>
			                    	가 \${list[i].customInserted}에 작성</h5>
			                      <p class="reply-body" style="white-space: pre;"></p>	
			                      
								<div class="input-group" style="display:none;">
								  <textarea id="replyTextarea\${list[i].id}" class="form-control"></textarea>
								 <div class="input-group-append">
									<button class="btn btn-outline-secondary" id="sendReply\${list[i].id}"><i class="far fa-comment-dots fa-lg"></i></button>
									<button class="btn btn-outline-secondary cancel-button"><i class="fas fa-ban"></i></button>
									</div>
							</div>			                      
						 </div>
					</div>`);
				
					
			replyMediaObject.find("#sendReply" + list[i].id).click(function() {
				<%--textarea id="replyTextarea\${list[i].id}" 를 담아서 reply에--%>
				const replyText = replyMediaObject.find("#replyTextarea" + list[i].id).val();
	              const data = {
	                     replyText : replyText
	               };				
	              <%--실제데이터를 제이슨 형태로 바꿔주고 제이슨형태 표시해서..? 
	              	For JSON text : application/json
	              	data {} 객체에서 replyText라는 프로퍼티가 존재하면 된다.
	              	기본값은 form데이터라서 JSON형태로 명시해서 보내주는
	              --%>
			
				$.ajax({
					url : appRoot + "/resellReply/" + list[i].id,
					type : "put",
	                contentType : "application/json",
	                data : JSON.stringify(data),
	                complete : function() {
	                  listReply();  // 댓글 가져오는
	                }	
					
				});
				
			});
			
					
			replyMediaObject.find(".reply-name").text(list[i].name);
			replyMediaObject.find(".reply-body").text(list[i].replyText);		
			replyMediaObject.find(".form-control").text(list[i].replyText);	
			replyMediaObject.find(".cancel-button").click(function() {
				replyMediaObject.find(".reply-body").show();
				replyMediaObject.find(".input-group").hide();
			});
					
					
            if (list[i].own) {
                // 본인이 작성한 것만 
                // 수정버튼 추가
                const modifyButton = $("<button class='btn btn-outline-secondary'><i class='far fa-edit'></i></button>");
				modifyButton.click(function() {
	                $(this).parent().find('.reply-body').hide();
	                $(this).parent().find('.input-group').show();
				});
                                
    
                replyMediaObject.find(".media-body").append(modifyButton);		
                // 삭제버튼 추가
                const removeButton = $("<button class='btn btn-outline-danger'><i class='far fa-trash-alt'></i></button>");
                	removeButton.click(function() {
                		if (confirm("댓글을 삭제할까요?")) {
                			$.ajax({
                				url : appRoot + "/resellReply/" + list[i].id,
                				type : "delete",
                				complete : function() {
                					listReply();
                				}
                				
                			});
                		}
                	});
                	replyMediaObject.find(".media-body").append(removeButton);
            }			
				
				$("#replyListContainer").append(replyMediaObject);
				
				}
			}
		});
	}

	listReply(); // 페이지 로딩 후 댓글 리스트 가져오는 함수 한 번 실행 
	
	// 댓글 전송
	$("#sendReply").click(function() {
		const replyText = $("#replyTextarea").val();
		const userId = "${sessionScope.loggedUser.id}";
		const boardId = "${resellBoard.id}";
		const memberId = "${sessionScope.loggedUser.id}"
		
		const data = {
				replyText : replyText,
				userId : userId,
				boardId : boardId,
				memberId : memberId
			};
		
		$.ajax({
			url : appRoot + "/resellReply/write",
			type : "post",
			data : data,
			success : function() {
				// textarea reset
				$("#replyTextarea").val("");
			},
			error : function() {
				alert("로그인이 필요합니다");
			},
			complete : function() {
				// 댓글 리스트 새로고침
				listReply();				
			}
			
		});
	});
	
	
	
});

</script>



<title>resellBoardGet.jsp</title>
</head>
<body>

	<div class="body_wrapper">
		<tag:nav></tag:nav>
		<!-- .container>.row>.col>h1{게시물조회} -->
		<div class="main_container">
			<div class="row" style="width: 80%">
				<div class="col">
					<h1>게시물조회</h1>
					<div class="board-view">
						<!-- .form-group*3>label[for=input$]+input.form-control#input$[readonly] -->
						<div class="form-group">
							<label for="titleInput">제목</label>
							<input type="text" class="form-control" id="titleInput" readonly value="${resellBoard.title }">
						</div>
						<div class="form-group">
							<label for="contentInput">내용</label>
<!--  
							<textarea class="form-control" id="contentInput" readonly>${resellBoard.content }</textarea>
-->							
		<div>
							<td>
							${resellBoard.content }
							</td>
		</div>
						</div>
						<div class="form-group">
							<label for="writerInput">작성자</label>
							<input type="text" class="form-control" id="nickName" readonly value="${resellBoard.nickName }">
						</div>
					<div class="form-group">
						<label for="addressInput">주소</label>
						<input type="text" class="form-control" id="addressInput" required name="address" readonly value="${resellBoard.address }">
					</div>						
						<div class="form-group">
							<label for="priceInput">가격</label>
							<input type="text" class="form-control" id="priceInput" readonly value="${resellBoard.price }">
						</div>
		 				<div class="form-group">
							<div id="map" style="width: 500px; height: 280px; margin-top: 10px;"></div>
							<div id="clickLatlng" style="display: none"></div>
		 				</div>						
						
					<!-- <button class="btn btn-outline-primary" style="float: right;"><a href="resellBoardList">글목록</a></button> -->
					<a href='<c:url value='/resellMarket/resellBoard/resellBoardList'/>' role="button" class="btn btn-outline-primary font_big font_italic font_bold font_center" style="float : right;">글 목록</a>
						<!-- a.btn.btn-outline-secondary{modify/delete} -->
						<c:if test="${sessionScope.loggedUser.id eq resellBoard.memberId }">
						<a href="resellBoardModify?id=${resellBoard.id }" class="btn btn-outline-secondary"> modify/delete</a>
						</c:if>
						<button class="btn btn-outline-primary" style="float: right;">
							<a href="javascript:history.back();">뒤로가기</a>
						</button>
					</div>
				</div>
			</div>



		<c:if test="${not empty sessionScope.loggedUser }">
			<!-- 댓글 쓰기 textarea container  -->
			<div class="container">
				<div class="row">
					<div class="col">
						<hr>
						<!-- .input-group>textarea#replyTextarea.form-control+.input-group-append>button.btn.btn-outline-secondary#sendReply -->
						<div class="input-group">
							<textarea id="replyTextarea" class="form-control"></textarea>
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" id="sendReply"><i class="far fa-comment-dots fa-lg"></i></button>
							</div>
						</div>

					</div>
				</div>
			</div>
		</c:if>

			<hr>
			<!-- 댓글 container -->
			<div class="container">
				<div class="row">
					<div class="col">

						<div id="replyListContainer"></div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<!--확인 Modal -->
	<c:if test="${not empty result }">
		<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">처리결과</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>${result }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>


	<tag:footer></tag:footer>
	<tag:menu></tag:menu>
	<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

	<script>
	$(document).ready(function() {
		const mapInput = document.querySelector("#addressInput");
		if (history.state == null) {
			$("#staticBackdrop").modal('show');
			history.replaceState("hello",null);
		}
		
		
/*ㅇㅇㅇ  */		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
		    center: new kakao.maps.LatLng(37.499817, 127.030277), // 지도의 중심좌표
		    level: 3 // 지도의 확대 레벨
		};  

		//지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var addressMap = $("#addressInput").val();
		console.log(addressMap);
		//주소로 좌표를 검색합니다

		const mapHandler = () => {
		 //카카오 지도 발생
		
		    	const mapValue = mapInput.value; // 주소 넣기
		       
		        geocoder.addressSearch(mapValue, function(result, status) {
		            // 정상적으로 검색이 완료됐으면 
		             
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

		})

		}

		
		
		
		setTimeout(mapHandler,2000);

		})
		
</script>

</body>
</html>






