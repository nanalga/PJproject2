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
<script src="${ContextPath}/resource/js/main.js" type="module"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/food/foodList.css" />

<title>Insert title here</title>
</head>
<body>
   <div class="food_list_body_container">
   	<tag:nav></tag:nav>
      <div class="food_list_body_main_wrapper">
        <!-- 게시판 상단 메인 안내 -->
        <div class="food_list_body_top_info">
            <div class="food_list_body_top_info_title">
                맛집 공유
            </div>
            <div class="food_list_body_sub_top_info">
                <div class="food_list_body_top_info_content_mainicon">
                    <img src="${pageContext.request.contextPath }/resource/img/foodImg/dragon_head_food.png" alt="" class="food_list_body_top_info_content_mainicon_iconimage">
                </div>
                <div class="food_list_body_top_info_content">
                    용피리에게 다양한 맛집을 알려주세요~
                </div>
            </div>
        </div>
          <!-- board 상단 -->
          <div class="food_list_body_main1">
              <div class="food_list_board_top_menu1">
                  <div class="food_list_board_top_board_count">
                      Total ${foodBoardTotalCount }건
                  </div>
              </div>
              
              <div class="food_list_board_top_menu2">
                  <div class="food_list_board_top_board_search">
                  <form class="food_list_board_top_search" action="" name="form1" method="get" >
	                 <select class="search_area" id="searchType" name="searchType" >
	                    <option value="all"  <c:if test="${pageInfo.searchTypeKeyword eq 'all'}">selected</c:if> >제목+작성자</option>
	                    <option value="t" <c:if test="${pageInfo.searchTypeKeyword eq 't'}">selected</c:if> >제목</option> 
	                    <option value="w" <c:if test="${pageInfo.searchTypeKeyword eq 'w'}">selected</c:if> >작성자</option>
	                 </select>
	                 	<input class="search-input" type="text" id="keyword" name="keyword" value="${pageInfo.keyword}" placeholder="검색어를 입력하세요"/>
	                 <button id="searchBtn" class="food_list_board_search_submit_button">검색</button>
                  </form>
                  </div>
                  <div class="food_list_board_top_board_register">
                    <button class="food_list_register_button" onclick="location.href='foodRegister'">글쓰기</button>
                  </div>
              </div>
              
          </div>
          <!-- board List -->
          <div class="food_list_body_main2">
              <table class="food_list_table_main">
                  <thead class="food_list_table_thread">
                      <tr class="food_list_table_thread_tr">
                          <th class="food_list_table_thread_th_id">번호</th>
                          <th class="food_list_table_thread_th_title">제목</th>
                          <th class="food_list_table_thread_th_writer">작성자</th>
                          <th class="food_list_table_thread_th_date">날짜</th>
                          <th class="food_list_table_thread_th_boardcnt">조회수</th>
                      </tr>
                  </thead>
                  <tbody class="food_list_table_tbody">
                  	<c:forEach items = "${list }" var="food">
                  
                      <tr class="food_list_table_tbody_tr">
                          <td class="food_list_table_tbody_td_id">${food.id }</td>
                          <td class="food_list_table_tbody_td_title">
	                          	<a class="food_list_td_title_a" href="foodGet?id=${food.id }">
									<c:out value="${food.title }" />
								</a>&nbsp; &nbsp;
								
								<c:if test="${food.foodReplyCount > 0 }">
									<i class="far fa-comment-dots"></i> ${food.foodReplyCount }									
								</c:if>
                          </td>
                          <td class="food_list_table_tbody_td_writer">${food.writer }</td>
                          <td class="food_list_table_tbody_td_date">${food.customInserted }</td>
                          <td class="food_list_table_tbody_td_boardcnt">${food.boardCnt }</td>
                      </tr>
                      
                  	</c:forEach>
                  </tbody>
              </table>

          </div>
          <!-- board List 하단 글쓰기버튼 -->
          <div class="food_list_body_main3">
              <div class="food_list_body_button_register">
                <button class="food_list_register_button" onclick="location.href='foodRegister'">글쓰기</button>
              </div>
          </div>
          <!-- pagging 부분 -->
          <div class="food_list_body_main4">
              <div class="food_list_body_main4_pagination">
                   <nav aria-label="Page navigation example">
                        <ul class="pagination">
                        
                        <c:if test="${pageInfo.hasPrevButton }">
                        	<c:url value="/food/foodList" var="foodPageLink">
		    					<c:param name="page" value="${pageInfo.leftPageNumber - 1 }${pageInfo.searchTypeKeyword}"></c:param>
		    				</c:url>
                        <li class="page-item">
                            <a class="food_list_page_link_previous" href="${foodPageLink }" aria-label="Previous">
                            <span aria-hidden="true"><</span>
                            </a>
                        </li>
                        </c:if>
                        <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
                        	<c:url value="/food/foodList" var="foodPageLink">
                        		<c:param name="page" value="${pageNumber }${pageInfo.searchTypeKeyword}"></c:param>
		    					<c:param name="searchType" value="${pageInfo.searchType }"></c:param>
                     			<c:param name="keyword" value="${pageInfo.keyword }"></c:param>
                        	</c:url>
                        	<li class="page-item ${pageInfo.currentPage == pageNumber ? 'active' : '' }" >
                        		<a class="food_list_page_link" href="${foodPageLink }${pageInfo.searchTypeKeyword}">${pageNumber }</a>
                        	</li>
                        </c:forEach>
                        
                        <c:if test="${pageInfo.hasNextButton }">
                        	<c:url value="/food/foodList" var="foodPageLink">
					    		<c:param name="page" value="${pageInfo.rightPageNumber + 1 }${pageInfo.searchTypeKeyword}"></c:param>
					    	</c:url>
	                        <li class="page-item">
	                            <a class="food_list_page_link_next" href="${foodPageLink }" aria-label="Next">
	                            <span aria-hidden="true">></span>
	                            </a>
	                        </li>
	                    </c:if>    
                        </ul>
                   </nav>
              </div>
          </div>

            <!-- get 페이지 하단 -->
            <div class="food_list_body_main_bottom_box">
                <div class="food_list_main_bottom_box_title">
                    <div class="food_list_main_bottom_foodBoardTitle">
                        용피리 골목식당
                    </div>
                </div>
                <div class="food_list_main_bottom_mainicon">
                    <div class="food_list_main_bottom_mainicon">
                         <img src="${pageContext.request.contextPath }/resource/img/foodImg/Dragon_Logo_food.png" alt="" class="food_list_main_bottom_iconimage">
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