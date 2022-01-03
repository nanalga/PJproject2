<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rb" tagdir="/WEB-INF/tags/resellBoard" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource//css/kocss/mystyle.css"> <!--외부 css -->

<title>resellBoardList</title>
</head>
<body>
<tag:nav></tag:nav>

<!-- .container>.row>.col>h1{게시물 목록} -->
<div class="container main_container">
	<div class="row">
		<div class="col">
			<h1>게시물 목록</h1>
			<!-- table.table>thead>tr>th*4>^^tbody -->
			<table class="table tb">
				<thead>
					<tr>
						<th><i class="fas fa-tag"></i></th>
						<th>title</th>
						<th>writer</th>
						<th>WritingDate</th>
					</tr>
					<tbody>
						<c:forEach items="${resellList}" var="resellBoard" >
							<tr>
								<td>${resellBoard.id }</td>
								<td><a href="resellBoardGet?id=${resellBoard.id }">
									<c:out value="${resellBoard.title }"></c:out>
								</a>
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
		</div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
 <script>
	$(document).ready(function() {
		if (history.state == null) {
			$("#staticBackdrop").modal('show');
			history.replaceState("historystate not null",null);
		}
		
	});
</script>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

</body>
</html>