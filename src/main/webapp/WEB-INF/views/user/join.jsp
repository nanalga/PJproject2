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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<title>join page</title>
</head>
<body>
<div class="user_container">
	<c:url value="/user" var="userUrl"></c:url>
	<tag:nav></tag:nav>
	<div class="join_main_box">
		<div class="join_main_wrapper">
			<span>join</span>
			<form method="post" class="join_main_form">
				<input type="text" name="name" class="join_name" placeholder="name" required/>
				 <div class="join_input_group">
                    <input type="email" name="email" class="join_email" placeholder="email" required/>
                    <input type="button" class="join_email_check" value="check">
                    <div class="join_email_message"></div>
                </div>
				<input type="text" name="password" class="join_pw" placeholder="password" required/>
				<input type="text" class="join_pw_check" placeholder="passwordCheck" required/>
				<input type="submit" class="join_submit" disabled/>
			</form>
		</div>
	</div>
	<tag:footer></tag:footer>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>