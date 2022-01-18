<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/kocss/resellBoardList.css">
<!--외부 css -->


<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>

<script src="http://d3js.org/d3.v3.min.js"></script>
<style>
</style>




<title>resellBoardList</title>
</head>
<body>
	<div class="body_wrapper">
		<tag:nav></tag:nav>

		<!-- .container>.row>.col>h1{게시물 목록} -->
		<div class="main_container resell_page ">

			<div class="resell_list_body_container">
				<div class="resell_list_body_main_wrapper">
					<!-- 게시판 상단 메인 안내 -->
					<div class="resell_list_body_top_info">
						<div class="resell_list_body_top_info_title">중고 장터</div>
						<div class="resell_list_body_sub_top_info">
							<div class="resell_list_body_top_info_content_mainicon">
								<img src="${pageContext.request.contextPath }/resource/img/foodImg/resellBoardImage.png" alt="" class="resell_list_body_top_info_content_mainicon_iconimage">
							</div>
							<div class="resell_list_body_top_info_content">용피리에게 다양한 맛집을 알려주세요~</div>
						</div>
					</div>
					<!-- board 상단 -->
					<div class="resell_list_body_main1">
						<div class="resell_list_board_top_menu1">
							<div class="resell_list_board_top_board_count">Total ${BoardTotalCnt }건</div>
						</div>

						<div class="resell_list_board_top_menu2">
							<div class="resell_list_board_top_board_search">
								<form class="resell_list_board_top_search" action="" name="form1" method="get">
									<select class="search_area" id="searchType" name="searchType">
										<option value="">검색조건</option>
										<option value="all">제목+작성자</option>
										<option value="title">제목</option>
										<option value="writer">작성자</option>
									</select>
									<input class="search-input" type="text" id="keyword" name="keyword" value="${pageInfo.keyword}" placeholder="검색어를 입력하세요" />
									<button id="searchBtn" class="resell_list_board_search_submit_button">검색</button>
									<input type="hidden" name="countRows">
									<input type="hidden" name="currentPage">
								</form>
							</div>
							<div class="resell_list_board_top_board_register">
								<button class="resell_list_register_button" onclick="location.href='resellBoardRegister'">글쓰기</button>
							</div>
						</div>

					</div>
					<!-- board List -->
					<div class="resell_list_body_main2">
						<table class="resell_list_table_main">
							<thead class="resell_list_table_thread">
								<tr class="resell_list_table_thread_tr">
									<th class="resell_list_col-md-1-id_id">번호</th>
									<th class="resell_list_col-md2-title_title">제목</th>
									<th class="resell_list_table_col-md3-price_th_price">가격</th>
									<th class="resell_list_col-md4-writer_writer">작성자</th>
									<th class="resell_list_col-md5-date_date">날짜</th>
									<th class="resell_list_col-md5-date_block"></th>
									<th class="resell_list_table_thread_th_boardcnt">조회수</th>
								</tr>
							</thead>
							<tbody class="resell_list_table_tbody">
								<c:forEach items="${resellList }" var="resellBoard">

									<tr class="resell_list_table_tbody_tr">
										<td class="resell_list_col-md1-td_id">${resellBoard.id }</td>
										<td class="resell_list_col-md2-td_title">
											<a href="resellBoardGet?id=${resellBoard.id }">
												<c:out value="${resellBoard.title }" />
											</a>
										</td>
										<td class="resell_list_col-md3-td-price">
											<c:out value="${resellBoard.price }"></c:out>
										</td>
										<td class="resell_list_col-md4-td-writer">
											<c:out value="${resellBoard.nickName }"></c:out>
										</td>
										<td class="resell_list_table_tbody_td_date">${resellBoard.customInserted }</td>
										<td class="resell_list_table_tbody_td_boardcnt">${resellBoard.boardCount }</td>
									</tr>

								</c:forEach>
							</tbody>
						</table>

					</div>
					<!-- board List 하단 글쓰기버튼 -->
					<div class="resell_list_body_main3">
						<div class="resell_list_body_button_register">
							<button class="resell_list_register_button" onclick="location.href='resellBoardRegister'">글쓰기</button>
						</div>
					</div>
					<!-- pagging 부분 -->
					<div class="resell_list_body_main4">
						<div class="resell_list_body_main4_pagination">
							<nav aria-label="Page navigation example">
								<ul class="pagination">

									<c:if test="${pageInfo.hasPrevButton }">
										<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
											<c:param name="page" value="${pageInfo.leftPageNumber - 1 }"></c:param>
										</c:url>
										<li class="page-item">
											<a class="resell_list_page_link_previous" href="${PageLink }" aria-label="Previous">
												<span aria-hidden="true"></span>
											</a>
										</li>
									</c:if>

									<c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
										<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
											<c:param name="page" value="${pageNumber }"></c:param>
											<c:param name="searchType" value="${pageInfo.searchType }"></c:param>
											<c:param name="keyword" value="${pageInfo.keyword }"></c:param>
										</c:url>
										<li class="page-item ${pageInfo.currentPage == pageNumber ? 'active' : '' }">
											<a class="resell_list_page_link" href="${pageLink }">${pageNumber }</a>
										</li>
									</c:forEach>

									<c:if test="${pageInfo.hasNextButton }">
										<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
											<c:param name="page" value="${pageInfo.rightPageNumber + 1 }"></c:param>
										</c:url>
										<li class="page-item">
											<a class="resell_list_page_link_next" href="${pageLink }" aria-label="Next">
												<span aria-hidden="true">></span>
											</a>
										</li>
									</c:if>
								</ul>
							</nav>
						</div>
					</div>

					<!-- get 페이지 하단 -->
					<div class="resell_list_body_main_bottom_box">
						<div class="resell_list_main_bottom_box_title">
							<div class="resell_list_main_bottom_resellBoardTitle">용피리 중고장터</div>
						</div>
						<div class="resell_list_main_bottom_mainicon">
							<div class="resell_list_main_bottom_mainicon">
								<img src="${pageContext.request.contextPath }/resource/img/foodImg/Dragon_Logo_food.png" alt="" class="resell_list_main_bottom_iconimage">
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<tag:footer></tag:footer>
	<tag:menu></tag:menu>


	<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

	<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function() {
			if (history.state == null) {
				$("#staticBackdrop").modal('show');
				history.replaceState("historystate not null", null);
			}

		});
	</script>
</body>
</html>