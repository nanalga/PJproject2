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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/kocss/resellGet.css">


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
	
		// 현재 게시물의 댓글 목록을 가져오는 함수
		const resellListReply = function(){
			// 가져올때 댓글 비우기
			$("#resellReplyListContainer").empty();
			$.ajax({
				url : appRoot + "/resellReply/resellBoard/${resellBoard.id}",
				success : function(list){
					for(let i = 0; i < list.length; i++){
						const resellReplyMediaObject =$(`
									
						<div class="resell_get_body_main_box_comment_txt_media">
							<div class="resell_get_body_main_box_comment_txt_media-body">
								<div class="resell_get_body_main_box_comment_writer_content">
									<p class="resell_reply_body" style="white-space: pre;"></p>
									<h5 class="resell_reply_mt">
										<i class="far fa-comment"></i> 
										<span class="reply-name"> \${list[i].nickName} </span>님이 \${list[i].customInserted}에 작성
									</h5>
								</div>
								<div class="resell_reply_input_group" style="display:none">
									<textarea name="" id="replyTextarea\${list[i].id}" class="form-control"></textarea>
									<div class="input_group_append_button">
										<button class="btn-outline-secondary cancel-button">취소</button>
										<button class="btn-outline-secondary" id="sendReply\${list[i].id}">댓글수정</button>
									</div>
								</div>
								<div class="resell_reple_input_modify_group">
									<button class='recoment_modify_button'>수정</button>
									<button class='recoment_remove_button'>삭제</button>
								</div>
							</div>
						</div>`);
						
						resellReplyMediaObject.find("#sendReply" + list[i].id).click(function(){
							const replyText = resellReplyMediaObject.find("#replyTextarea" + list[i].id).val();
							const data = {
								replyText : replyText 
							};
							$.ajax({
								url : appRoot + "/resellReply/" + list[i].id,
								type : "put",	// data를 Json 형식으로 보내야함 
								contentType : "application/json",	// json형태로 바꿔줌
								data : JSON.stringify(data),	// Json 형식으로 보내는 메소드 
								complete : function(){
									resellListReply();
								}
							});
						});
						
						resellReplyMediaObject.find(".reply-name").text(list[i].name);
						resellReplyMediaObject.find(".resell_reply_body").text(list[i].replyText);
						resellReplyMediaObject.find(".form-control").text(list[i].replyText);
						resellReplyMediaObject.find(".cancel-button").click(function(){
							resellReplyMediaObject.find(".resell_reply_body").show();
							resellReplyMediaObject.find(".resell_reply_input_group").hide();
						});
						
						/* 로그인 후 댓글 수정,삭제 버튼 추가 */
						if (list[i].own) {	// own true(로그인)경우 버튼 추가
							// 본인이 작성한 것만 수정버튼 추가
							//const modifyButton = $(".btn btn-outline-secondary");
							resellReplyMediaObject.find(".recoment_modify_button").click(function(){
								$(this).parent().find('.resell_reply_body').hide();
								$(this).parent().parent().find('.resell_reply_input_group').show();
							});
							
							//resellReplyMediaObject.find(".resell_get_body_main_box_comment_txt_media-body").append(modifyButton);
							
							// 삭제버튼 추가
							//const removeButton = $(".btn.btn-outline-danger");
							//resellReplyMediaObject.find(".resell_get_body_main_box_comment_txt_media-body").append(removeButton);
							resellReplyMediaObject.find(".recoment_remove_button").click(function(){
								if(confirm("삭제하시겠습니까?")){
									$.ajax({
										url : appRoot + "/resellReply/" + list[i].id,
										type : "delete",
										complete : function(){
											resellListReply();
										}
									});
								}
							});
						}
						
						$("#resellReplyListContainer").append(resellReplyMediaObject);
					}
				}
			});
		};
		
		resellListReply();	// 페이지 로딩 후 댓글 리스트 가져오는 함수 한 번 실행
		
		/* 댓글 전송 */
		$("#sendReply").click(function(){
			const replyText = $("#replyTextarea").val();
			const userId = '${sessionScope.loggedUser.id}';
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
				success : function(){
					// textarea reset
					$("#replyTextarea").val("");
				},
				error : function(){
					alert("댓글 작성되지 않았습니다. 권한이 있는지 확인해보세요.");
					$("#replyTextarea").val("");
				},
				complete : function(){
					// 댓글 리스트 새로 고침
					resellListReply();				
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
	<div class="resell_get_body_container">
	   <!-- 공지사항 -->
	   <div class="resell_get_body_main_wrapper">
	     <div class="resell_get_body_top_info">
	         <div class="resell_get_body_top_info_title">
	             중고 거래
	         </div>
	         <div class="resell_get_body_sub_top_info">
	             <div class="resell_get_body_top_info_content_mainicon">
	                 <img src="${pageContext.request.contextPath }/resource/img/foodImg/resellBoardImage.png" alt="" class="resell_get_body_top_info_content_mainicon_iconimage">
	             </div>
	             <div class="resell_get_body_top_info_content">
	                 용필이에게 다양한 아나바다...
	             </div>
	         </div>
	     </div>
	     <!-- 게시판 제목 -->
	    <div class="resell_get_body_wrapper">
	        <div class="resell_get_body_main_box">
	            <div class="resell_get_main_box_title">
	                <div class="resell_get_body_resellBoardTitle">
	                    용필이 중고장터
	                </div>
	            </div>
	            <div class="resell_get_body_main_box_backList">
	                <a href="resellBoardList" class="resell_get_body_main_box_backList_reselllist">목록으로</a>
	            </div>
	        </div>
	        <!-- 게시글 제목, 날짜, 조회수, 댓글수  -->
	        <div class="resell_get_body_main_box">
	            <div class="resell_get_body_main_discriptionBox">
	                <div class="resell_get_body_sub_discriptionBox">
	                    <div class="resell_get_body_main_box_bTitle" >
	                    	<div class="resell_get_body_title_price">
	                    		<div class="resellBoard_title">
				                     ${resellBoard.title }     
	                    		</div>
								<div class="resellBoard_price">
				                     <i class="fas fa-won-sign money" >　</i> ${resellBoard.price }원
								</div>		                     
	                    	</div>
	                    </div>
	                </div>
	                 <div class="resell_get_body_sub_discriptionBox">
	                     <div class="resell_get_body_sub_sub_discriptionBox">
	                         <div class="resell_get_body_main_box_bWriter">
	                             작성자 : ${resellBoard.nickName } | ${resellBoard.customInserted }
	                         </div>
	                         <div class="resell_get_body_main_box_bDate">
	                         </div>
	                         <div class="resell_get_body_main_box_bCnt_bComentCnt">
	                            조회수 : ${resellBoard.boardCount } |
	                            댓글 : <c:if test="${resellBoard.replyCount >= 0 }">
					                		${resellBoard.replyCount }
					                   </c:if>
										개
	                         </div>
	                     </div>
	
	                 </div>
	            </div>
	        </div>
	        <!-- 게시글 내용 -->
	        <div class="resell_get_body_main_box">
	            <div class="resell_get_body_main_box_content_text">
	               <tr>
	               	  <td>${resellBoard.content }</td>
	               </tr>
	            </div>
	        </div>
	     
	        <!-- 입력된 주소 / 주소 이미지(4) -->
	        <div class="resell_get_body_main_box">
	             <div class="resell_get_body_main_box_address_text_part">
	                 <div class="resell_get_body_main_box_address_title_text" >
	                     주소 : 
	                 </div>
	                 <div class="resell_get_body_main_box_address_content_text" id="" name="address" >
	                    <input type="text" class="resell_get_body_main_box_address_content_addressInput" id="addressInput" readonly value="${resellBoard.address }"> 
	                 </div>
	             </div>
	             <div class="resell_get_body_main_box_address_image_part">
	                 <div class="resell_get_body_main_box_address_image">
	                     <div id="map" style="width: 500px; height: 280px; margin-top: 10px;"></div>
						 <div id="clickLatlng" style="display: none"></div>
	                 </div>
	             </div>
	         </div>
	
	        <!-- 리스트 이동 버튼 -->
	        <div class="resell_get_body_main_box">
	            <div class="resell_get_body_main_box_bottomList">
	            	<c:if test="${sessionScope.loggedUser.id eq resellBoard.memberId }">
	                	<button class="resell_reselllist_sub_button" onclick="location.href='resellBoardModify?id=${resellBoard.id }'">수정 | 삭제</button>
	            	</c:if>
	            </div>
	        </div>
	        <!-- 댓글 개수 -->
	        <div class="resell_get_body_main_box">
	            <div class="resell_get_body_main_box_comment">
	                댓글
	                	<c:if test="${resellBoard.replyCount >= 0 }">
	                		${resellBoard.replyCount }
	                	</c:if>
					개
	            </div>
	        </div>
	        
	        <!-- 댓글 작성 구역 -->
	        <c:if test="${not empty sessionScope.loggedUser }">
	        <div class="resell_get_body_main_box">
	<!--        <div class="resell_get_body_comment_title_frame">
	                <div class="resell_get_body_comment_write"></div>
	            </div> -->
	            <div class="resell_get_body_comment_textarea_frame">
	                <textarea name="" id="replyTextarea" class="resell_get_body_comment_textarea"></textarea>
	            </div>
	            <div class="resell_get_body_comment_button_frame">
	                <div class="resell_get_body_comment_button_sub_frame">
	                 <button id="sendReply" class="resell_comment_sub_button">댓글작성</button>
	                </div>
	            </div>
	        </div>
	        </c:if>
	        
	        <!-- 댓글 리스트 -->
	        <div class="resell_get_body_main_box">
	             <div class="resell_get_body_main_discriptionBox">
	                 
	                 <div class="resell_get_body_main_box_comment_writer">
	                 </div>
	                 <div id="resellReplyListContainer" class="resell_get_body_main_box_comment_txt">
	                 </div>
	                 <div class="resell_get_body_main_box_comment_date">
	                 </div>
	             </div>
	        </div>
	        
	        <!-- get 페이지 하단 -->
	        <div class="resell_get_body_main_bottom_box">
	            <div class="resell_get_main_bottom_box_title">
	                <div class="resell_get_main_bottom_resellBoardTitle">
	                    용필이 중고장터
	                </div>
	            </div>
	            <div class="resell_get_main_bottom_mainicon">
	                <div class="resell_get_main_bottom_mainicon">
	                     <img src="${pageContext.request.contextPath }/resource/img/foodImg/Dragon_Logo_food.png" alt="" class="resell_get_main_bottom_iconimage">
	                </div>
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

		                var iwContent = '<div style="padding:5px 10px 5px 5px; font-size: small;white-space: nowrap;">'+addressMap+'<br><a href="https://map.kakao.com/link/map/'+addressMap+','+result[0].y+','+result[0].x+
		                '" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/'+addressMap+
		                ','+result[0].y+','+result[0].x+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		                iwPosition = new kakao.maps.LatLng(result[0].y, result[0].x);		                
		                
		                
		                // 인포윈도우로 장소에 대한 설명을 표시합니다
		                var infowindow = new kakao.maps.InfoWindow({
		                	position : iwPosition,
		                    content: iwContent
		                });
		                infowindow.open(map, marker);

		                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		                map.setCenter(coords);

		})

		}

		
		
		
		setTimeout(mapHandler,2000);

});
		
		
		
		
</script>

</body>
</html>






