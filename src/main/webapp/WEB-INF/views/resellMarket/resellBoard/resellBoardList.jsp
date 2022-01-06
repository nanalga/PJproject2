<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rb" tagdir="/WEB-INF/tags/resellBoard"%>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource//css/kocss/mystyle.css">
<!--외부 css -->


<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />

<title>resellBoardList</title>
</head>
<body>
	<div class="body_wrapper">
		<tag:nav></tag:nav>

		<!-- .container>.row>.col>h1{게시물 목록} -->
		<div class="main_container">
			<div class="row" style="width: 80%">
				<div class="col">
					<h1>게시물 목록</h1>
					<!-- table.table>thead>tr>th*4>^^tbody -->
					<table class="table tb">
						<thead>
							<tr>
								<th>
									<i class="fas fa-tag"></i>
								</th>
								<th>제목</th>
								<th>작성자</th>
								<th>가격</th>
								<th>작성일</th>
							</tr>
						<tbody>
							<c:forEach items="${resellList}" var="resellBoard">
								<tr>
									<td>${resellBoard.id }</td>
									<td>
										<a href="resellBoardGet?id=${resellBoard.id }">
											<c:out value="${resellBoard.title }"></c:out>
										</a>
										<c:if test="${resellBoard.replyCount > 0 }">
										<i class="far fa-comments">${resellBoard.replyCount }</i>
										</c:if>
									</td>
									<td>
										<c:out value="${resellBoard.writer }"></c:out>
									</td>
									<td>
										<c:out value="${resellBoard.price }"></c:out>
									</td>

									<td>${resellBoard.customInserted }</td>
								</tr>
							</c:forEach>
						</tbody>
						</thead>
					</table>
					<a href='<c:url value='/resellMarket/resellBoard/resellBoardRegister'/>' role="button" class="btn btn-outline-primary">글쓰기</a>
				</div>
			</div>
			<!-- search foodBoard -->
			<form action="" name="form1" method="get">
				<div class="form-inline">
					<select class="search_area" id="searchType" name="searchType">
						<option value="">검색조건</option>
						<option value="all">전체조건</option>
						<option value="t">제목</option>
						<option value="w">작성자</option>
						<!-- 			<option value="c">내용</option>
				<option value="tc">제목+내용</option>
				<option value="all">전체조건</option> -->
					</select>
					<input class="form-control" type="text" id="keyword" name="keyword" value="${pageInfo.keyword}" placeholder="검색어를 입력하세요" />
					<button id="searchBtn" class="btn btn-primary">Search</button>
				</div>
			</form>


			<!--pagination  -->
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${pageInfo.hasPrevButton }">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageInfo.leftPageNumber - 1 }"></c:param>
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>

					<c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageNumber }"></c:param>
						</c:url>
						<li class="page-item ${pageInfo.currentPage == pageNumber ? 'active' : '' }">
							<a class="page-link" href="${pageLink }">${pageNumber }</a>
						</li>
					</c:forEach>
					<c:if test="${pageInfo.hasNextButton }">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageInfo.rightPageNumber + 1 }"></c:param>
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>

	<!-- Modal -->
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