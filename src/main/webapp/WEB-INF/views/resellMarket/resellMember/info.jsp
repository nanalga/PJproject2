<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>ResellMemberInfo</title>
</head>
<body>
<!-- .container>.row>.col>h1{회원정보} -->
<div class="container main_container">
	<div class="row">
		<div class="col">
			<h1>회원정보</h1>
			<!-- form>.form-group*6>label[for=input$]+input.form-control[name][value] -->
			<form method="post" id="infoForm">
					<div class="form-group">
						<label for="idInput">아이디</label>
						<input type="text" required class="form-control" id="idInput" required name="id" value="${sessionScope.loggedInMember.id }" readonly>
					</div>
					<div class="form-group">
						<label for="pwInput">패스워드</label>
						<input type="text"  required class="form-control" id="pwInput" required name="password" value="${sessionScope.loggedInMember.password }">
					</div>
					<div class="form-group">
						<label for="pwcInput">패스워드확인</label>
						<input type="text" required class="form-control" id="pwcInput">
					</div>
					<div class="form-group">
						<label for="nickNameInput">닉네임</label>
						<input type="text" class="form-control" id="nickNameInput" required name="nickName" value="${sessionScope.loggedInMember.nickName}">
					</div>
					<div class="form-group">
						<label for="emailInput">이메일</label>
						<input type="text" required class="form-control" id="emailInput" required name="email" value="${sessionScope.loggedInMember.email }">
					</div>
					<div class="form-group">
						<label for="addressInput">주소</label>
						<input type="text" required class="form-control" id="addressInput" required name="address" value="${sessionScope.loggedInMember.address }" readonly>
					</div>
										<div class="form-group">
						<label for="addressDetailInput">상세주소</label>
						<input type="text" required class="form-control" id="addressDetailInput" required name="addressDetail" value="${sessionScope.loggedInMember.addressDetail }">
					</div>
					<!-- button.btn.btn-outline-secondary{수정}+button.btn.btn-outline-secondary{삭제} -->
					<button class="btn btn-outline-secondary" id="modifyButton">회원정보수정</button>
					<button class="btn btn-outline-danger" id="removeButton">회원탈퇴</button>	
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
<!--코드 + id값 변경 주소관련? -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
		const infoForm =$("#infoForm")
		
		$("#modifyButton").click(function(e) {
			e.preventDefault();
			
			infoForm.attr("action", "");
			infoForm.submit();
		});
		
		$("#removeButton").click(function(e) {
			e.preventDefault();
			if (confirm("회원을 탈퇴하시겠습니까?")) {
				infoForm.attr("action","remove");
				infoForm.submit();
			}
		});
	});
	
</script>

</html>

