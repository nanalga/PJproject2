<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Insert title here</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>
</head>
<body>

<!-- .container>.row>.col>h1{맛집 목록} -->
<div class="container">
	<div class="row">
		<div class="col">
			<h1>맛집 목록</h1>
			<a href='<c:url value='/food/foodRegister'/>' role="button" class="btn btn-outline-primary">글쓰기</a>
			<!-- table.table>thead>tr>th*4^^tbody -->
			<table class="table">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items = "${list }" var="food">
						<tr>
							<th>${food.id }</th>
							<th>
								<a href="foodGet?id=${food.id }">
									<c:out value="${food.title }" />
								</a>
							</th>
							<th>${food.writer }</th>
							<th>${food.customInserted }</th>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</div>
	</div>
</div>

<!-- pagenation -->
<nav aria-label="Page navigation example">
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