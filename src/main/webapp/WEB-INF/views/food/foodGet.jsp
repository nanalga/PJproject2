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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/food/foodGet.css" />

<script>
$(document).ready(function(){
	// contextPath
	const appRoot = '${pageContext.request.contextPath}';
	
	// 현재 게시물의 댓글 목록을 가져오는 함수
	const foodListReply = function(){
		// 가져올때 댓글 비우기
		$("#foodReplyListContainer").empty();
		$.ajax({
			url : appRoot + "/foodReply/food/${food.id}",
			success : function(list){
				for(let i = 0; i < list.length; i++){
					const foodReplyMediaObject =$(`
								
					<div class="food_get_body_main_box_comment_txt_media">
						<div class="food_get_body_main_box_comment_txt_media-body">
							<div class="food_get_body_main_box_comment_writer_content">
								<p class="food_reply_body" style="white-space: pre;"></p>
								<h5 class="food_reply_mt">
									<i class="far fa-comment"></i>
									<span class="reply-name"> \${list[i].name} </span>님이 \${list[i].customInserted}에 작성
								</h5>
							</div>
							<div class="food_reply_input_group" style="display:none">
								<textarea name="" id="replyTextarea\${list[i].id}" class="form-control"></textarea>
								<div class="input_group_append_button">
									<button class="btn-outline-secondary cancel-button">취소</button>
									<button class="btn-outline-secondary" id="sendReply\${list[i].id}">댓글수정</button>
								</div>
							</div>
							<div class="food_reple_input_modify_group">
								<button class='recoment_modify_button'>수정</button>
								<button class='recoment_remove_button'>삭제</button>
							</div>
						</div>
					</div>`);
					
					foodReplyMediaObject.find("#sendReply" + list[i].id).click(function(){
						const replyText = foodReplyMediaObject.find("#replyTextarea" + list[i].id).val();
						const data = {
							replyText : replyText 
						};
						$.ajax({
							url : appRoot + "/foodReply/" + list[i].id,
							type : "put",	// data를 Json 형식으로 보내야함 
							contentType : "application/json",	// json형태로 바꿔줌
							data : JSON.stringify(data),	// Json 형식으로 보내는 메소드 
							complete : function(){
								foodListReply();
							}
						});
					});
					
					foodReplyMediaObject.find(".reply-name").text(list[i].name);
					foodReplyMediaObject.find(".food_reply_body").text(list[i].replyText);
					foodReplyMediaObject.find(".form-control").text(list[i].replyText);
					foodReplyMediaObject.find(".cancel-button").click(function(){
						foodReplyMediaObject.find(".food_reply_body").show();
						foodReplyMediaObject.find(".food_reply_input_group").hide();
					});
					
					/* 로그인 후 댓글 수정,삭제 버튼 추가 */
					if (list[i].own) {	// own true(로그인)경우 버튼 추가
						// 본인이 작성한 것만 수정버튼 추가
						//const modifyButton = $(".btn btn-outline-secondary");
						$(".recoment_modify_button").click(function(){
							$(this).parent().find('.food_reply_body').hide();
							$(this).parent().parent().find('.food_reply_input_group').show();
						});
						
						//foodReplyMediaObject.find(".food_get_body_main_box_comment_txt_media-body").append(modifyButton);
						
						// 삭제버튼 추가
						//const removeButton = $(".btn.btn-outline-danger");
						//foodReplyMediaObject.find(".food_get_body_main_box_comment_txt_media-body").append(removeButton);
						$(".recoment_remove_button").click(function(){
							if(confirm("삭제하시겠습니까?")){
								$.ajax({
									url : appRoot + "/foodReply/" + list[i].id,
									type : "delete",
									complete : function(){
										foodListReply();
									}
								});
							}
						});
					}
					
					$("#foodReplyListContainer").append(foodReplyMediaObject);
				}
			}
		});
	};
	
	foodListReply();	// 페이지 로딩 후 댓글 리스트 가져오는 함수 한 번 실행
	
	/* 댓글 전송 */
	$("#sendReply").click(function(){
		const replyText = $("#replyTextarea").val();
		const userId = '${sessionScope.loggedUser.id}';
		const foodBoardId = '${food.id}';
		const data = {
			replyText : replyText,
			userId : userId,
			foodBoardId : foodBoardId
		};
		$.ajax({
			url : appRoot + "/foodReply/foodReplyWrite",
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
				foodListReply();				
			}
		});
	});
	
});


</script>


<title>Insert title here</title>
</head>
<body>

<div class="food_get_body_container">
	<tag:nav></tag:nav>
   <!-- 공지사항 -->
   <div class="food_get_body_main_wrapper">
     <div class="food_get_body_top_info">
         <div class="food_get_body_top_info_title">
             맛집 공유
         </div>
         <div class="food_get_body_sub_top_info">
             <div class="food_get_body_top_info_content_mainicon">
                 <img src="${pageContext.request.contextPath }/resource/img/foodImg/dragon_head_food.png" alt="" class="food_get_body_top_info_content_mainicon_iconimage">
             </div>
             <div class="food_get_body_top_info_content">
                 용피리에게 다양한 맛집을 알려주세요~
             </div>
         </div>
     </div>
     <!-- 게시판 제목 -->
    <div class="food_get_body_wrapper">
        <div class="food_get_body_main_box">
            <div class="food_get_main_box_title">
                <div class="food_get_body_foodBoardTitle">
                    용피리 골목식당
                </div>
            </div>
            <div class="food_get_body_main_box_backList">
                <a href="foodList">목록으로</a>
            </div>
        </div>
        <!-- 게시글 제목, 날짜, 조회수, 댓글수  -->
        <div class="food_get_body_main_box">
            <div class="food_get_body_main_discriptionBox">
                <div class="food_get_body_sub_discriptionBox">
                    <div class="food_get_body_main_box_bTitle" >
                     ${food.title }
                    </div>
                </div>
                 <div class="food_get_body_sub_discriptionBox">
                     <div class="food_get_body_sub_sub_discriptionBox">
                         <div class="food_get_body_main_box_bWriter">
                             작성자 : ${food.writer } | ${food.customInserted }
                         </div>
                         <div class="food_get_body_main_box_bDate">
                         </div>
                         <div class="food_get_body_main_box_bCnt_bComentCnt">
                            조회수 : ${food.boardCnt } |
                            댓글 : 
                            <c:if test="${food.foodReplyCount > 0 }">
                            	${food.foodReplyCount }
                            </c:if>
                         </div>
                     </div>

                 </div>
            </div>
        </div>
        <!-- 게시글 내용 -->
        <div class="food_get_body_main_box">
            <div class="food_get_body_main_box_content_text">
               <tr>
               	  <td>${food.contents }</td>
               </tr>
            </div>
        </div>
     
        <!-- 입력된 주소 / 주소 이미지(4) -->
        <div class="food_get_body_main_box">
             <div class="food_get_body_main_box_address_text_part">
                 <div class="food_get_body_main_box_address_title_text">
                     주소 : 
                 </div>
                 <div class="food_get_body_main_box_address_content_text">
                     샘플 서울시 강남구 어쩌구 저쩌구 123-12
                 </div>
             </div>
             <div class="food_get_body_main_box_address_image_part">
                 <div class="food_get_body_main_box_address_image">
                     샘플 imge
                 </div>
             </div>
         </div>

        <!-- 리스트 이동 버튼 -->
        <div class="food_get_body_main_box">
            <div class="food_get_body_main_box_bottomList">
                <button class="food_foodlist_sub_button" onclick="location.href='foodModify?id=${food.id }'">수정 / 삭제</button>
            </div>
        </div>
        <!-- 댓글 개수 -->
        <div class="food_get_body_main_box">
            <div class="food_get_body_main_box_comment">
                댓글 ${food.foodReplyCount }개
            </div>
        </div>
        
        <!-- 댓글 작성 구역 -->
        <c:if test="${not empty sessionScope.loggedUser }">
        <div class="food_get_body_main_box">
            <div class="food_get_body_comment_title_frame">
                <div class="food_get_body_comment_write">
                 
                </div>
            </div>
            <div class="food_get_body_comment_textarea_frame">
                <textarea name="" id="replyTextarea" class="food_get_body_comment_textarea"></textarea>
            </div>
            <div class="food_get_body_comment_button_frame">
                <div class="food_get_body_comment_button_sub_frame">
                 <button id="sendReply" class="food_comment_sub_button">댓글작성</button>
                </div>
            </div>
        </div>
        </c:if>
        
        <!-- 댓글 리스트 -->
        <div class="food_get_body_main_box">
             <div class="food_get_body_main_discriptionBox">
                 
                 <div class="food_get_body_main_box_comment_writer">
                 </div>
                 <div id="foodReplyListContainer" class="food_get_body_main_box_comment_txt">
                 </div>
                 <div class="food_get_body_main_box_comment_date">
                 </div>
             </div>
        </div>
        
        <!-- get 페이지 하단 -->
        <div class="food_get_body_main_bottom_box">
            <div class="food_get_main_bottom_box_title">
                <div class="food_get_main_bottom_foodBoardTitle">
                    용피리 골목식당
                </div>
            </div>
            <div class="food_get_main_bottom_mainicon">
                <div class="food_get_main_bottom_mainicon">
                     <img src="${pageContext.request.contextPath }/resource/img/foodImg/Dragon_Logo_food.png" alt="" class="food_get_main_bottom_iconimage">
                </div>
            </div>   
        </div>
    </div>
 </div>
</div>






<tag:footer></tag:footer>
<tag:menu></tag:menu>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>