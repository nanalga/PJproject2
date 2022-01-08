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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<title>User Detail</title>
</head>
<body>
<div class="body_wrapper">
	<tag:flash></tag:flash>
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
                        <label for="user_detail_input2" class="user_detail_label">nickName</label>
                        <input type="text" class="user_detail_input" id="user_detail_input2" value="${sessionScope.loggedUser.nickName}" readonly/>
                    </div>
                    <div class="user_detail_box">
                        <label for="user_detail_input3" class="user_detail_label">Eamil</label>
                        <input type="text" class="user_detail_input" id="user_detail_input3" value="${sessionScope.loggedUser.email}"  readonly/>
                    </div>
                    <div class="user_detail_box">
                        <label for="user_detail_input4" class="user_detail_label">Password</label>
                        <input type="text" class="user_detail_input" id="user_detail_input4" value="${sessionScope.loggedUser.password}" readonly/>
                    </div>
                    <div class="user_detail_box">
                        <label for="user_detail_input5" class="user_detail_label">Address</label>
                        <input type="text" class="user_detail_input" id="user_detail_input5" value="${sessionScope.loggedUser.address}" readonly/>
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
                        <input type="hidden" class="user_power_appRoot" value="${pageContext.request.contextPath}">
                        <input type="hidden" class="user_power_path" value="${path }"/>
                    </div>
                    <div class="user_power_list_container_user">
                        <div class="user_power_content">
                        </div>
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