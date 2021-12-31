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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource//css/kocss/mystyle.css"> <!--외부 css -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<title>Insert title here</title>
</head>
<body>
<rb:navBar></rb:navBar>
<h1 class="myHeader">memberList 나오니여기나오늬?</h1>

<!-- .container>.row>.col>h1{회원목록} -->
<div class="container main_container">
	<div class="row">
		<div class="col">
			<h1>회원목록</h1>
			<!-- table.table>thead>tr>th*7^^tbody -->
				<table class="table tb">
					<thead>
						<tr>
							<th>아이디</th>
							<th>닉네임</th>
							<th>이메일</th>
							<th>주소</th>
							<th>상세주소</th>
							<th>가입날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${memberList }" var="member">
						<!-- tr>td*6>c:out -->
						<tr>
							<td>${member.id }</td>
							<td>
								<c:out value="${member.nickName }"></c:out>
							</td>
							<td>
								<c:out value="${member.email }"></c:out>
							</td>
							<td>
								<c:out value="${member.address }"></c:out>
							</td>
							<td>
								<c:out value="${member.addressDetail }"></c:out>
							</td>
							<td>
								<c:out value="${member.customInserted }"></c:out>
							</td>
						</tr>
						
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>










