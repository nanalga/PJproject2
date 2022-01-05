<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
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
<%
    String clientId = "I0h6W4S5fUWk4zc_U2h1";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/controller/naver/naverJoin", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
<div class="body_wrapper">
	<c:url value="/user" var="userUrl"></c:url>
	<tag:nav></tag:nav>
	<div class="main_container">
		<div class="join_main_box">
			<div class="join_main_wrapper">
				<span>join</span>
				<form method="post" class="join_main_form">
					<input type="text" name="name" class="join_name" placeholder="name" required/>
					<input type="text" name="nickName" class="join_nickName" placeholder="nickName" />
					 <div class="join_input_group">
	                    <input type="email" name="email" class="join_email" placeholder="email" required/>
	                    <input type="button" class="join_email_check" value="check">
	                    <div class="join_email_message"></div>
	                </div>
					<input type="text" name="password" class="join_pw" placeholder="password" required/>
					<input type="text" class="join_pw_check" placeholder="passwordCheck" required/>
					<input type="text" class="join_address" placeholder="addresss"/>
					<input type="submit" class="join_submit" value="Join" disabled/>
				</form>
				<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=d1f2c7c111ea44b0957fc9dbf10a601f&redirect_uri=http://localhost:8080/controller/kakao/kakaoJoin&prompt=login
                        " class="join_kakao">
                     <div class="join_kakao_img_box">
                         <i class="fas fa-comment"></i>
                         <span>Join with Kakao</span>
                     </div>
                </a>
                <a href="<%=apiURL%>" class="join_naver">
                	<div class="join_naver_img_box">
                		<span>N</span>
                		<span>Join with Naver</span>
                	</div>
                </a>
			</div>
		</div>
	</div>
	<tag:footer></tag:footer>
	<tag:menu></tag:menu>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>