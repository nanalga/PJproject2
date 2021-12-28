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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
				<input type="text" name="name" class="join_name" placeholder="name"/>
				 <div class="join_input_group">
                    <input type="text" name="email" class="join_email" placeholder="email"/>
                    <input type="button" class="join_email_check" value="check">
                    <div class="join_email_message"></div>
                </div>
				<input type="text" name="password" class="join_pw" placeholder="password"/>
				<input type="text" class="join_pw_check" placeholder="passwordCheck"/>
				<input type="submit" class="join_submit" disabled/>
			</form>
		</div>
	</div>
	<tag:footer></tag:footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/join.js"></script>
</body>
</html>