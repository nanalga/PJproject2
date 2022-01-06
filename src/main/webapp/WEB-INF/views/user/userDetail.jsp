<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="userUrl" value="${pageContext.request.contextPath }/user"></c:set>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/icon/css/all.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<title>User Detail</title>
</head>
<body>
<div class="body_wrapper">
	<tag:nav></tag:nav>
	<div class="main_container">
		<div class="user_detail_container">
                <div class="user_detail_wrapper">
                    <div class="user_detail_box">
                        <span>User Detail</span>
                    </div>    
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
                <div class="user_power">
                    <div class="user_power_menu_container">
                        <div class="user_power_menu ${path == 'food'? 'select':''}">
                            <a href="${ContextPath }/user/userDetail/food">Food</a>
                        </div>
                        <div class="user_power_menu ${path == 'resell'? 'select':''}">
                            <a href="${ContextPath }/user/userDetail/resell">Resell</a>
                        </div>
                        <div class="user_power_menu ${path == 'cm'? 'select':''}">
                            <a href="${ContextPath }/user/userDetail/cm">Community</a>
                        </div>
                    </div>
                    <div class="user_power_list_container_user">
                        <div class="user_power_content">
                        	<c:if test="${path == 'food' }">
                        		<div class="user_power_content_bar_food">
	                                <span class="user_power_content_bar_id">id</span>
	                                <span class="user_power_content_bar_title">title</span>
	                                <span class="user_power_content_bar_writer">writer</span>
	                                <span class="user_power_content_bar_inserted">inserted</span>
	                                <span class="user_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${foodList }" var="food">
		                            <div class="user_power_content_info_food">
		                                <span class="user_power_conent_id">${food.id }</span>
		                                <span class="user_power_conent_title">${food.title }</span>
		                                <span class="user_power_conent_writer">${food.writer }</span>
		                                <span class="user_power_conent_inserted">${food.inserted }</span>
		                                <input type="hidden" class="board_type_info" value="food">
		                                <a href="" class="user_power_conent_delete"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                        	</c:if>
                            <c:if test="${path == 'resell' }">
                            	<div class="user_power_content_bar_resell">
	                                <span class="user_power_content_bar_id">id</span>
	                                <span class="user_power_content_bar_title">title</span>
	                                <span class="user_power_content_bar_writer">writer</span>
	                                <span class="user_power_content_bar_price">price</span>
	                                <span class="user_power_content_bar_password">updated</span>
	                                <span class="user_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${resellList }" var="resell">
		                            <div class="user_power_content_info_resell">
		                                <span class="user_power_conent_id">${resell.id }</span>
		                                <span class="user_power_conent_title">${resell.title }</span>
		                                <span class="user_power_conent_writer">${resell.writer }</span>
		                                <span class="user_power_content_price">${resell.price }</span>
		                                <span class="user_power_conent_password">${resell.updated }</span>
		                                <input type="hidden" class="board_type_info" value="resell">
		                                <a href="" class="user_power_conent_delete"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                            </c:if>
                            <c:if test="${path == 'cm' }">
                            	<div class="user_power_content_bar_CM">
	                                <span class="user_power_content_bar_id">id</span>
	                                <span class="user_power_content_bar_title">title</span>
	                                <span class="user_power_content_bar_writer">writer</span>
	                                <span class="user_power_content_bar_password">inserted</span>
	                                <span class="user_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${cmList }" var="cm">
		                            <div class="user_power_content_info_food">
		                                <span class="user_power_conent_id">${cm.id }</span>
		                                <span class="user_power_conent_title">${cm.title }</span>
		                                <span class="user_power_conent_writer">${cm.writer }</span>
		                                <span class="user_power_conent_inserted">${cm.inserted }</span>
		                                <input type="hidden" class="board_type_info" value="cm">
		                                <a href="" class="user_power_conent_delete"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
	</div>
	<tag:footer></tag:footer>
    <tag:menu></tag:menu>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>