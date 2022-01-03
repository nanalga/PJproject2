<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "b" tagdir="/WEB-INF/tags/comFreeBoard" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>

<%-- div class="body_wrapper"
   <tag:nav></tag:nav>
   div class="main_container"
  <tag:footer></tag:footer>
  <tag:menu></tag:menu> --%>



<!-- 여기에 리다이렉트 하는 코드도 심어놔야함. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/fontawesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/icon/css/all.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />

<title>자유게시판</title>
</head>
<body>
<a href="#">여기에 홈으로 들어가는 링크 들어갈것</a><td>
<a href="#"><i class="fas fa-home"></i></a><td>
  <tag:nav></tag:nav>

  <div class="main_container">
  	<div class="row">
  		<div class="col">
  			<h1>자유게시판</h1>
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
  					<c:forEach items="${list }" var="comFreeBoard">
  					<tr>
  						<td>${comFreeBoard.id }</td>
  						<td>
  						<a href="community_free_get?id=${comFreeBoard.id }">
  						${comFreeBoard.title }
  						</a>
  						
  						</td>
  						<td>${comFreeBoard.nickName }</td>
  						<td>${comFreeBoard.customInserted }</td>
  					</tr>
  					</c:forEach>
  				</tbody>
  			</table>
  		</div>
  	</div>
  </div>
  

<!--  modal -->
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
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
  <script>
  
  $(document).ready(function(){
	  $("#modal1").modal('show');
  });
  </script>
  
  <script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>
















