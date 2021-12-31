<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rb" tagdir="/WEB-INF/tags/resellBoard" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>resellBoardGet.jsp</title>
</head>
<body>
<rb:navBar></rb:navBar>

<!-- .container>.row>.col>h1{게시물조회} -->
<div class="container main_container">
	<div class="row">
		<div class="col">
			<h1>게시물조회</h1>
			<div class="board-view">
			<!-- .form-group*3>label[for=input$]+input.form-control#input$[readonly] -->	
				<div class="form-group">
					<label for=""titleInput"">제목</label>
					<input type="text" class="form-control" id="titleInput" style="width: 40%;" readonly value="${resellBoard.title }">
				</div>
				<div class="form-group">
					<label for="contentInput">내용</label>
					<textarea class="form-control" id="contentInput" readonly>${resellBoard.content }</textarea>
				</div>
 				<div class="form-group">
					<label for="priceInput">가격</label>
					<input type="text" class="form-control" id="priceInput" readonly value="${resellBoard.price }">
				</div> 
				<div class="form-group">
					<label for="writerInput">작성자</label><i id="heart" class="far fa-heart"></i>
					<input type="text" class="form-control" id="writerInput" readonly value="${resellBoard.writer }">
				</div>
				<!-- a.btn.btn-outline-secondary{modify/delete} -->
					<a href="resellBoardModify?id=${resellBoard.id }" class="btn btn-outline-secondary">
					modify/delete</a>
				
			
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		if (history.state == null) {
			$("#staticBackdrop").modal('show');
			history.replaceState("historystate not null",null);
		}
		// 하트
	    $("#heart").click(function () {
	        $(this).toggleClass("far").toggleClass("fas");
	    });
		
		
	});

</script>



</body>
</html>









