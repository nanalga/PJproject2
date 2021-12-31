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
<title>Admin Detail</title>
</head>
<body>
<div class="body_wrapper">
	<tag:nav></tag:nav>
	<div class="main_container">
		<div class="admin_detail_container">
                <div class="admin_detail_wrapper">
                    <div class="admin_detail_box">
                        <span>Admin Detail</span>
                    </div>    
                    <div class="admin_detail_box">
                        <label for="admin_detail_input1" class="admin_detail_label">Name</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input1" value="${sessionScope.loggedUser.name}" readonly/>
                    </div>
                    <div class="admin_detail_box">
                        <label for="admin_detail_input2" class="admin_detail_label">Eamil</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input2" value="${sessionScope.loggedUser.email}"  readonly/>
                    </div>
                    <div class="admin_detail_box">
                        <label for="admin_detail_input3" class="admin_detail_label">Password</label>
                        <input type="text" class="admin_detail_input" id="admin_detail_input3" value="${sessionScope.loggedUser.password}" readonly/>
                    </div>
                </div>
                <div class="admin_power">
                    <div class="admin_power_menu_container">
                        <div class="admin_power_menu ${path == 'user'? 'select':'' }">
                            <a href="${ContextPath }/user/adminDetail/user">User</a>
                        </div>
                        <div class="admin_power_menu ${path == 'food'? 'select':'' }">
                            <a href="${ContextPath }/user/adminDetail/food">Food</a>
                        </div>
                        <div class="admin_power_menu ${path == 'resell'? 'select':'' }">
                            <a href="${ContextPath }/user/adminDetail/resell">Resell</a>
                        </div>
                        <div class="admin_power_menu ${path == 'community'? 'select':'' }">
                            <a href="${ContextPath }/user/adminDetail/community">Community</a>
                        </div>
                    </div>
                    <div class="admin_power_list_container_user">
                        <div class="admin_power_content">
                        	<c:if test="${path == 'user' }">
	                            <div class="admin_power_content_bar">
	                                <span class="admin_power_content_bar_id">id</span>
	                                <span class="admin_power_content_bar_name">name</span>
	                                <span class="admin_power_content_bar_email">email</span>
	                                <span class="admin_power_content_bar_password">password</span>
	                                <span class="admin_power_content_bar_created">created</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${userList }" var="userVO">
									<div class="admin_power_content_info">
	                                <span type="text" class="admin_power_conent_id">${userVO.id }</span>
	                                <span type="text" class="admin_power_conent_name">${userVO.name }</span>
	                                <span type="text" class="admin_power_conent_email">${userVO.email }</span>
	                                <span type="text" class="admin_power_conent_password">${userVO.password }</span>
	                                <span type="text" class="admin_power_conent_created">${userVO.created }</span>
	                                <input type="hidden" class="hiddenInfo">
	                                <a href="#"><i class="fas fa-times"></i></a>
	                            </div>                            
	                            </c:forEach>
                        	</c:if>
                        	<c:if test="${path == 'food' }">
                        		<div class="admin_power_content_bar_food">
	                                <span class="admin_power_content_bar_id">id</span>
	                                <span class="admin_power_content_bar_title">title</span>
	                                <span class="admin_power_content_bar_writer">writer</span>
	                                <span class="admin_power_content_bar_inserted">inserted</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${foodList }" var="foodVO">
		                            <div class="admin_power_content_info_food">
		                                <span type="text" class="admin_power_conent_id">${foodVO.id }</span>
		                                <span type="text" class="admin_power_conent_title">${foodVO.title }</span>
		                                <span type="text" class="admin_power_conent_writer">${foodVO.writer }</span>
		                                <span type="text" class="admin_power_conent_inserted">${foodVO.inserted }</span>
		                                <input type="hidden" class="hiddenInfo">
	                                	<a href="#"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                        	</c:if>
                        	<c:if test="${path == 'resell' }">
                        		<div class="admin_power_content_bar_resell">
	                                <span class="admin_power_content_bar_id">id</span>
	                                <span class="admin_power_content_bar_name">title</span>
	                                <span class="admin_power_content_bar_writer">writer</span>
	                                <span class="admin_power_content_bar_price">price</span>
	                                <span class="admin_power_content_bar_updated">updated</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${resellList }" var="resellVO">
		                            <div class="admin_power_content_info_resell">
		                                <span class="admin_power_conent_id">${resellVO.id }</span>
		                                <span class="admin_power_conent_name">${resellVO.title }</span>
		                                <span class="admin_power_content_writer">${resellVO.writer }</span>
		                                <span class="admin_power_content_price">${resellVO.price }</span>
		                                <span class="admin_power_conent_updated">${resellVO.updated }</span>
		                                <input type="hidden" class="hiddenInfo">
		                                <a href="#"><i class="fas fa-times"></i></a>
		                            </div>
	                            </c:forEach>
                        	</c:if>
                        	<c:if test="${path == 'community' }">
                        		<div class="admin_power_content_bar_CM">
	                                <span class="admin_power_content_bar_id">id</span>
	                                <span class="admin_power_content_bar_name">title</span>
	                                <span class="admin_power_content_bar_writer">writer</span>
	                                <span class="admin_power_content_bar_inserted">inserted</span>
	                                <span class="admin_power_content_bar_delete"><i class="fas fa-times"></i></span>
	                            </div>
	                            <c:forEach items="${communityList }" var="CM">
	                            	<div class="admin_power_content_info_CM">
	                                <span class="admin_power_conent_id">${CM.id }</span>
	                                <span class="admin_power_conent_name">${CM.title }</span>
	                                <span class="admin_power_content_writer">${CM.writer }</span>
	                                <span class="admin_power_conent_inserted">${CM.inserted }</span>
	                                <input type="hidden" class="hiddenInfo">
	                                <a href="#"><i class="fas fa-times"></i></a>
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