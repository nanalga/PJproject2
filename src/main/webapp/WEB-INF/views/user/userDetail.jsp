<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="userUrl" value="${pageContext.request.contextPath }/user"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/icon/css/all.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<title>User Detail</title>
</head>
<body>
<div class="user_detail_container">
	<tag:nav></tag:nav>
	<div class="user_detail_wrapper">
		<div class="user_detail_box">
			<label for="user_detail_input1" class="user_detail_label">Name</label>
			<input type="text" class="user_detail_input" id="user_detail_input1" value="${sessionScope.loggedUser.name}" readonly/>
		</div>
		<div class="user_detail_box">
			<label for="user_detail_input2" class="user_detail_label">Eamil</label>
			<input type="text" class="user_detail_input" id="user_detail_input2" value="${sessionScope.loggedUser.email}"  readonly/>
		</div>
		<div class="user_detail_box">
			<label for="user_detail_input3" class="user_detail_label">Password</label>
			<input type="text" class="user_detail_input" id="user_detail_input3" value="${sessionScope.loggedUser.password}" readonly/>
		</div>
		<div class="user_detail_box">
			<a href="${pageContext.request.contextPath }/user/edit" class="user_detail_editBtn">edit</a>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>