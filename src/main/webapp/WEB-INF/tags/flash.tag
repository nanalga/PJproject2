<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${not empty success }">
	<div class="flash_box_success">
	    <div class="flash_img_box">
            <img src="${pageContext.request.contextPath}/resource/img//잘생긴용피리.png" alt="">
        </div>
        <div class="flash_message_box">
            <span class="flash_message_title">성공!!</span>
            <span class="flash_message_content">지금 아주 좋아요 아주 잘되고있어용~</span>
        </div>
	</div>
</c:if>
<c:if test="${not empty fail }">
	<div class="flash_box_fail">
	    <div class="flash_img_box">
            <img src="${pageContext.request.contextPath}/resource/img/잘생긴용피리.png" alt="">
        </div>
        <div class="flash_message_box">
            <span class="flash_message_title">실패..ㅠㅠ</span>
            <span class="flash_message_content">솔직히 말해서 나도 왜 이 에러가 뜨는지 잘 모르겠다..</span>
        </div>
	</div>
</c:if>