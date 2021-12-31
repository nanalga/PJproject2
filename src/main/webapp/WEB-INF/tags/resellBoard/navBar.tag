<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="active"%>

<c:url value="/resellMarket/resellBoard/resellBoardList" var="listUrl"></c:url>
<c:url value="/resellMarket/resellBoard/resellBoardRegister" var="registerUrl"></c:url>
<c:url value="/resellMarket/resellMember/signup" var="signupUrl"></c:url>
<c:url value="/resellMarket/resellMember/login" var="loginUrl"></c:url>
<c:url value="/resellMarket/resellMember/logout" var="logoutUrl"></c:url>
<c:url value="/resellMarket/resellMember/info" var="memberInfoUrl"></c:url>
<c:url value="/resellMarket/resellMember/memberList" var="memberListUrl"></c:url>

<nav class="navbar navbar-expand-lg " style="background-color: #accbe7;">
	<a class="navbar-brand" href="#">홈페이지 이름</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon">
			<i class="fas fa-bars"></i>
		</span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active ${active == 'list' ? 'active' : '' }">
				<a class="nav-link" href="${listUrl}">목록</a>
			</li>

			<c:if test="${empty sessionScope.loggedInMember }">
				<li class="nav-item active ${active == 'signup' ? 'active' : '' }">
					<a class="nav-link" href="${signupUrl }">회원가입</a>
				</li>
				<li class="nav-item active ${active == 'login' ? 'active' : '' }">
					<a class="nav-link" href="${loginUrl }">로그인</a>
				</li>
			</c:if>

			<c:if test="${not empty sessionScope.loggedInMember }">
			<li class="nav-item active ${active == 'register' ? 'active' : '' }">
				<a class="nav-link" href="${registerUrl }">글쓰기</a>
			</li>
				<li class="nav-item active ${active == 'memeberInfo' ? 'active' : '' }">
					<a class="nav-link" href="${memberInfoUrl }">회원정보보기</a>
				</li>
				<li class="nav-item active ${active == 'logout' ? 'active' : '' }">
					<a class="nav-link" href="${memberListUrl }">전체회원목록</a>
				</li>				
				<li class="nav-item active ${active == 'logout' ? 'active' : '' }">
					<a class="nav-link" href="${logoutUrl }">로그아웃</a>
				</li>
			</c:if>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false"> Dropdown link </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					<a class="dropdown-item" href="#">Action</a>
					<a class="dropdown-item" href="#">Another action</a>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</li>

		</ul>
	</div>
</nav>
