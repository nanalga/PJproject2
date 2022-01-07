<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />

<style>
.bbsTitleBox{
    border: 1px solid #DDD;
    /* margin: 0 auto 10px; */
    width: 90%;
    margin-bottom: 10px;
}
.bbsTitle {
    position: relative;
    padding: 0 0.6em;
    font-size: 15px;
    font-weight: bold;
    line-height: 34px;
    background: #EEE;
    border-bottom: 1px solid #DDD;
}
.bbsBtnGroup {
    position: absolute;
    right: 0;
    top: 0;
    height: 100%;
}
.bbsNotice {
    padding: 0.5em 0.4em;
    color: #666;
    font-size: 13px;
    line-height: 1.4;
}
div {
    display: block;
}

.table {
	border-collapse: collapse;
	width: 90%;
}
th {
	background-color : #ffcccc;
	color : white;
}

td {
  padding: 8px;
  text-align: left;
  border-bottom: 2px solid #ddd;
}

tr:hover {background-color: #f2f2f2;}

.form-inline {
	margin-top: 0px;
  	margin-bottom: 10px;
}

.main_bbsFood {
	display : flex;
	flex-direction:column;
	justify-content: center;
	align-items: center;
}
.row {
	justify-content: center;
	align-items: center;
}
.writer_btn {
	position: relative;
	align-content: flex-end;
	width: 80px;
	height: 30px;
	background-color: #ffcccc;
	border-bottom-color:#ddd;
	margin-left: 8px;
}
#page_navi_main {
	margin-top: 5px;
	margin-bottom: 10px;
}
#searchBtn {
	width: 30px;
	height: 30px;
}
.page-link {
	background-color: #ffcccc;
}


</style>

<title>Insert title here</title>
</head>
<body>

<!-- .container>.row>.col>h1{맛집 목록} -->
<div class="body_wrapper">	
	<tag:nav></tag:nav>
	<div class="main_container">
		<div class="row" style="width: 100%" >
			<div class="main_bbsFood" style="width: 80%">
				<div class="bbsTitleBox">
					<div class="bbsTitle">
						<a href="#">맛집</a>
						<div class="bbsBtnGroup"></div>
					</div>
					<div class="bbsNotice">
						<div>- 공유할 동네 맛집 정보 글을 올려주세요.</div>
					</div>
				</div>
			
				<!-- table.table>thead>tr>th*4^^tbody -->
				<table class="table">
					<thead id="title_thead">
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>##</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items = "${list }" var="food">
							<tr>
								<td>${food.id }</td>
								<td>
									<a href="foodGet?id=${food.id }">
										<c:out value="${food.title }" />
									</a>
								</td>
								<td>
									<c:if test="${food.foodReplyCount > 0 }">
										<i class="far fa-comment-dots"></i> ${food.foodReplyCount }									
									</c:if>
								</td>
								<td>${food.writer }</td>
								<td>${food.customInserted }</td>
								<td>${food.boardCnt }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
		</div>

		<!-- search foodBoard -->
		<div class="form-inline">
		<form action="" name="form1" method="get" >
			<select class="search_area" id="searchType" name="searchType">
				<option value="">검색조건</option>
				<option value="all">전체조건</option>
				<option value="t">제목</option> 
				<option value="w">작성자</option>
		   <!-- <option value="c">내용</option>
				<option value="tc">제목+내용</option>
				<option value="all">전체조건</option> -->
			</select>
			<input class="search-input" type="text" id="keyword" name="keyword" value="${pageInfo.keyword}" placeholder="검색어를 입력하세요"/>

			<button id="searchBtn" class="" style="background-color:#ffcccc;"><i class="fas fa-search" style="color:white;"></i></button>
		</form>
		<a href='<c:url value='/food/foodRegister'/>' role="button" ><button class="writer_btn" >글쓰기</button></a>
		
		</div>
		
		<!-- pagenation -->
		<nav aria-label="Page navigation example" id="page_navi_main">
		  <ul class="pagination justify-content-center">
		    <c:if test="${pageInfo.hasPrevButton }">
		    	<c:url value="/food/foodList" var="foodPageLink">
		    		<c:param name="page" value="${pageInfo.leftPageNumber - 1 }"></c:param>
		    	</c:url>
			    <li class="page-item">
			      <a class="page-link" href="${foodPageLink }" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
		    </c:if>
		    
		    <c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
		    	<c:url value="/food/foodList" var="foodPageLink">
		    		<c:param name="page" value="${pageNumber }"></c:param>
		    	</c:url>
		    	 <li class="page-item  ${pageInfo.currentPage == pageNumber ? 'active' : '' }">
		    	 	<a class="page-link" href="${foodPageLink }">${pageNumber }</a>
		    	 </li>
		    </c:forEach>
		    
		    <c:if test="${pageInfo.hasNextButton }">
		    	<c:url value="/food/foodList" var="foodPageLink">
		    		<c:param name="page" value="${pageInfo.rightPageNumber + 1 }"></c:param>
		    	</c:url>
			    <li class="page-item">
			      <a class="page-link" href="${foodPageLink }" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
		    </c:if>
		  </ul>
		</nav>
	</div>
</div>


<!-- modal -->
<c:if test="${not empty result }">
	<div class="modal" tabindex="-1" id="modal1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">처리 결과</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>${result }</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
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
	if (history.state == null) {
		$("#modal1").modal('show');
		history.replaceState({}, null);
	}
});
</script>

</body>
</html>