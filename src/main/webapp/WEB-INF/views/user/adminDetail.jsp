<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="adminUrl" value="${pageContext.request.contextPath }/admin"></c:set>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/icon/css/all.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<title>admin Detail</title>
</head>
<body>
<div class="body_wrapper">
	<tag:flash></tag:flash>
	<tag:nav></tag:nav>
	<div class="main_container main_page_default">
		<div class="admin_detail_container">
                <div class="admin_detail_wrapper">
                    <span class="admin_detail_title">Admin Detail</span>
                    <div class="admin_detail_box">
                        <label for="admin_detail_input1" class="admin_detail_label">이름</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input1" value="${sessionScope.loggedUser.name}" readonly/>
                    </div>
                    <div class="admin_detail_box">
                        <label for="admin_detail_input2" class="admin_detail_label">이메일</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input2" value="${sessionScope.loggedUser.email}"  readonly/>
                    </div>
                    <div class="admin_detail_box">
                        <label for="admin_detail_input3" class="admin_detail_label">비밀번호</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input3" value="${sessionScope.loggedUser.password}" readonly/>
                    </div>
                </div>
                <div class="admin_power">
                    <div class="admin_power_menu_container">
                        <div class="admin_power_menu ${path == 'user'? 'select':'' }">
                            <a href="${ContextPath }/admin/adminDetail/user">회원</a>
                        </div>
                        <div class="admin_power_menu ${path == 'food'? 'select':'' }">
                            <a href="${ContextPath }/admin/adminDetail/food">맛집</a>
                        </div>
                        <div class="admin_power_menu ${path == 'resell'? 'select':'' }">
                            <a href="${ContextPath }/admin/adminDetail/resell">중고장터</a>
                        </div>
                    </div>
                    <div class="admin_power_list_container_user">
                        <div class="admin_power_content">
                        	<c:if test="${path == 'user' }">
	                            <div class="admin_power_content_bar">
	                                <span class="admin_power_content_bar_id">ID</span>
	                                <span class="admin_power_content_bar_name">이름</span>
	                                <span class="admin_power_content_bar_nickName">닉네임</span>
	                                <span class="admin_power_content_bar_email">이메일</span>
	                                <span class="admin_power_content_bar_password">비밀번호</span>
	                                <span class="admin_power_content_bar_created">가입일</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${userList }" var="userVO">
									<div class="admin_power_content_info">
	                                <span class="admin_power_conent_id">${userVO.id }</span>
	                                <span class="admin_power_conent_name">${userVO.name }</span>
	                                <span class="admin_power_content_nickName">${userVO.nickName }</span>
	                                <span class="admin_power_conent_email">${userVO.email }</span>
	                                <span class="admin_power_conent_password">${userVO.password }</span>
	                                <span class="admin_power_conent_created">${userVO.userCreated }</span>
	                                <input type="hidden" class="hiddenInfo">
	                                <a href="${adminUrl}/adminDetail/delete/user/${page}/${userVO.id}" class="admin_power_delete"><i class="fas fa-times"></i></a>
	                            </div>                            
	                            </c:forEach>
                        	</c:if>
                        	<c:if test="${path == 'food' }">
                        		<div class="admin_power_content_bar_food">
	                                <span class="admin_power_content_bar_id">ID</span>
	                                <span class="admin_power_content_bar_title">제목</span>
	                                <span class="admin_power_content_bar_writer">작성자</span>
	                                <span class="admin_power_content_bar_inserted">작성일</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${foodList }" var="foodVO">
		                            <div class="admin_power_content_info_food">
		                                <span type="text" class="admin_power_conent_id">${foodVO.id }</span>
		                                <span type="text" class="admin_power_conent_title">${foodVO.title }</span>
		                                <span type="text" class="admin_power_conent_writer">${foodVO.name }</span>
		                                <span type="text" class="admin_power_conent_inserted">${foodVO.userInserted }</span>
		                                <input type="hidden" class="hiddenInfo">
	                                	<a href="${adminUrl}/adminDetail/delete/food/${page}/${foodVO.id}" class="admin_power_delete"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                        	</c:if>
                        	<c:if test="${path == 'resell' }">
                        		<div class="admin_power_content_bar_resell">
	                                <span class="admin_power_content_bar_id">ID</span>
	                                <span class="admin_power_content_bar_name">제목</span>
	                                <span class="admin_power_content_bar_writer">작성자</span>
	                                <span class="admin_power_content_bar_price">가격</span>
	                                <span class="admin_power_content_bar_updated">수정일</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${resellList }" var="resellVO">
		                            <div class="admin_power_content_info_resell">
		                                <span class="admin_power_conent_id">${resellVO.id }</span>
		                                <span class="admin_power_conent_name">${resellVO.title }</span>
		                                <span class="admin_power_content_writer">${resellVO.name }</span>
		                                <span class="admin_power_content_price">${resellVO.price }</span>
		                                <span class="admin_power_conent_updated">${resellVO.userUpdated }</span>
		                                <input type="hidden" class="hiddenInfo">
		                                <a href="${adminUrl}/adminDetail/delete/resell/${page}/${resellVO.id}" class="admin_power_delete"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                        	</c:if>
                        </div>
                    	<tag:adminPagination></tag:adminPagination>
                    </div>
                </div>
            </div>
	</div>
	<tag:confirm_modal></tag:confirm_modal>
	<tag:footer></tag:footer>
    <tag:menu></tag:menu>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>