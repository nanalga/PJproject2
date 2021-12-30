<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rb" tagdir="/WEB-INF/tags/resellBoard"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!--주소화면 외부js  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/address.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<title>Insert title here</title>
</head>
<body>
	<rb:navBar></rb:navBar>

	<!-- .container>.row>.col>h1{회원가입} -->
	<div class="container main_container">
		<div class="row">
			<div class="col">
				<h1>회원가입</h1>
				<c:if test="${not empty alertMessage}">
					<div class="alert alert-warning">${alertMessage }</div>
				</c:if>

				<!-- form>.form-group*4>label[for=input$]+input.form-control#input$[required]^button.btn.btn-outline-primary{가입} -->
				<form method="post">
					<div class="form-group">
						<label for="idInput">아이디</label>
						<input type="text" class="form-control" id="idInput" required name="id" value="${resellMember.id }">
					</div>
					<div class="form-group">
						<label for="pwInput">패스워드</label>
						<input type="text" class="form-control" id="pwInput" required name="password" value="${resellMember.password }">
					</div>
					<div class="form-group">
						<label for="pwcInput">패스워드확인</label>
						<input type="text" class="form-control" id="pwcInput">
					</div>
					<div class="form-group">
						<label for="nickNameInput">닉네임</label>
						<input type="text" class="form-control" id="nickNameInput" required name="nickName" value="${resellMember.nickName }">
					</div>
					<div class="form-group">
						<label for="emailInput">이메일</label>
						<input type="text" class="form-control" id="emailInput" required name="email" value="${resellMember.email }">
					</div>
					<div class="form-group">
						<label for="addressInput">주소</label>
						<input type="text" class="form-control" id="addressInput" required name="address" readonly value="${resellMember.address }">
					</div>
										<div class="form-group">
						<label for="addressDetailInput">상세주소</label>
						<input type="text" class="form-control" id="addressDetailInput" required name="addressDetail" value="${resellMember.addressDetail }">
					</div>
<!--
					<table>
						<tr>
							<th>주소</th>
							<td>
								<input type="text" id="address_kakao" name="address" readonly />
							</td>
						</tr>
						<tr>
							<th>상세 주소</th>
							<td>
								<input type="text" name="address_detail" />
							</td>
						</tr>
					</table>
  -->					
					<button class="btn btn-outline-primary">가입</button>
				</form>
			</div>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>

</html>











