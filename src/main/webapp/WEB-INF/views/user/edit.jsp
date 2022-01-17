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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>Edit</title>
</head>
<body>
<div class="body_wrapper">
	<tag:flash></tag:flash>
	<tag:nav></tag:nav>
	<div class="main_container main_page_default">
            <div class="user_edit_container">
                <div class="user_edit_wrapper">
                    <span class="user_edit_title">수정</span>
                    <form class="user_edit_form" method="post">
                        <div class="user_edit_box">
                            <label for="user_edit_input1" class="user_edit_label">이름*</label>
                            <div class="user_edit_input_group">
                                <input type="text" name="name" class="user_edit_input1" id="user_edit_input1" value="${sessionScope.loggedUser.name}" required/>
                            </div>
                        </div>
                        <div class="user_edit_box">
                            <label for="user_edit_input2" class="user_edit_label">이메일*</label>
                            <div class="user_edit_input_group">
                                <input type="email" name="email" class="user_edit_input2" id="user_edit_input2" value="${sessionScope.loggedUser.email}"  required/>
                                <input type="button" class="edit_email_check" value="check"/>
                        		<div class="edit_email_message"></div>
                            </div>
                        </div>
                        <div class="user_edit_box">
                            <label for="user_edit_input5" class="user_edit_label">닉네임</label>
                            <input type="text" name="nickName" class="user_edit_nickName" id="user_edit_input5" value="${sessionScope.loggedUser.nickName}" required/>
                        </div>
                        <div class="user_edit_box">
                            <label for="user_edit_input3" class="user_edit_label">비밀번호*</label>
                            <label for="user_edit_input4" class="user_edit_label">비밀번호 확인*</label>
                            <input type="text" name="password" class="user_edit_input3 user_edit_password" id="user_edit_input3" value="${sessionScope.loggedUser.password}" required/>
                            <input type="text" class="user_edit_input4 user_edit_password_check" id="user_edit_input4"/>
                        </div>
                        <div class="user_edit_box">
                            <label for="user_edit_input6" class="user_edit_label">주소</label>
                            <input type="text" name="address" class="user_edit_address" id="user_edit_input6" value="${sessionScope.loggedUser.address}">
                        </div>
                        <div class="user_edit_box">
                            <input type="submit" class="user_edit_updateBtn" disabled value="Update"/>
                            <input type="submit" class="user_edit_deleteBtn" value="Delete"/>
                            <input type="submit" class="user_edit_submitBtn" style="display:none" />
                        </div>
                        <input type="hidden" class="contextPath" value="${pageContext.request.contextPath }"/>
                        <input type="hidden" class="firstEamilValue" value ="${sessionScope.loggedUser.email }" />
                        <input type="hidden" class="firstNickNameValue" value ="${sessionScope.loggedUser.nickName }"/>
                        <input type="hidden" class="firstPasswordValue" value = "${sessionScope.loggedUser.password }" />
                        <input type="hidden" class="firstAddressValue" value="${sessionScope.loggedUser.address}"/>
                        <input type="hidden" name="id" value="${sessionScope.loggedUser.id }"/>
                    </form>
                </div>
            </div>
        </div>
	<tag:footer></tag:footer>
	<tag:menu></tag:menu>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>