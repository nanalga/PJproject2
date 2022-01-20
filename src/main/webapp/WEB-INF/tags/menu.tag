<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="menu_container transfrom">
        	<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
            <div class="menu_header">
                <div class="menu_title">
                    <i class="fas fa-times"></i>
                    <span>Menu</span>
                </div>
            </div>
            <div class="menu_list_container">
                <div class="menu_list_box">
                    <div class="menu_food">
                        <a href="${ContextPath }/food/foodList">용피리 골목식당</a>
                    </div>
                </div>
                <div class="menu_list_box">
                    <div class="menu_resell">
                        <a href="${ContextPath }/resellMarket/resellBoard/resellBoardList">용피리 중고장터</a>
                    </div>
                </div>
                <c:if test="${loggedUser != null }">
                	<c:if test="${loggedUser.admin == false }">
		               	<div class="menu_list_box">
		                   	<div class="menu_user">
		                       <a href="${ContextPath }/user/userDetail/food">마이페이지</a>
		                  		</div>
		                </div>
	                </c:if>
	                <c:if test="${loggedUser.admin == true }">
	                	<div class="menu_list_box">
		                   	<div class="menu_user">
		                       <a href="${ContextPath }/admin/adminDetail/user">관리자 페이지</a>
		                  		</div>
		                </div>
	                </c:if>
	                <div class="menu_list_box">
	                    <div class="menu_user">
	                        <a href="${ContextPath }/user/logout">로그아웃</a>
	                    </div>
	                </div>
                </c:if>
                <c:if test="${loggedUser == null }">
	                <div class="menu_list_box">
	                    <div class="menu_user">
	                        <a href="${ContextPath }/user/login">로그인</a>
	                    </div>
	                </div>
	                <div class="menu_list_box">
	                    <div class="menu_user">
	                        <a href="${ContextPath }/user/join">회원가입</a>
	                    </div>
	                </div>
                </c:if>
            </div>
        </div>