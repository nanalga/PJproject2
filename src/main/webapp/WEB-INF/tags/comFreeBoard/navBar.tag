<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:url value = "/community/community_FreeBoard" var = "community_FreeBoardUrl"></c:url>
<c:url value = "/community/community_Register" var = "community_RegisterUrl"></c:url>
<c:url value = "/community/community_signup" var = "community_signupUrl"></c:url>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	
<ul class="navbar-nav mr-auto">
    <li class="nav-item active">
      <a class="nav-link" href="${community_FreeBoardUrl }">목록</a>
    </li>
    
     <li class="nav-item active">
        <a class="nav-link" href="${community_RegisterUrl }">글쓰기</a>
      </li>
      
      <li class="nav-item active">
      	<a class="nav-link" href="${community_signupUrl }">회원가입</a>
      </li>
	</ul>
</nav>