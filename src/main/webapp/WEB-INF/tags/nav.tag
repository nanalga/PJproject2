<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:url value="/user" var="userUrl"></c:url>
<nav class="nav_container">
	<div class="nav_logo">
           <span>동맛중</span>
       </div>
	<div class="nav_menu_box">
		<div class="nav_menu">
               <span>맛집</span>
           </div>
		<div class="nav_menu">
               <span>중고장터</span>
           </div>
		<div class="nav_menu">
               <span>QNA</span>
           </div>
	</div>
	<c:choose>
		<c:when test="${sessionScope.loggedUser != null }">
			<div class="nav_user">
				<div class="nav_user_box">
					<a href="${userUrl}/userDetail" class="nav_user_login_link">
						<span class="nav_user_login">userDetail</span>
					</a>
				</div>
				<div class="nav_user_box">
					<a href="${userUrl}/logout" class="nav_user_join_link">
						<span class="nav_user_join">logout</span>
					</a>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="nav_user">
				<div class="nav_user_box">
					<a href="${userUrl}/login" class="nav_user_login_link">
						<span class="nav_user_login">login</span>
					</a>
				</div>
				<div class="nav_user_box">
					<a href="${userUrl}/join" class="nav_user_join_link">
						<span class="nav_user_join">join</span>
					</a>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
</nav>