<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="adminDetail_pagination">
	<c:set value="${pageContext.request.contextPath}/admin/adminDetail/${path}" var="paginationLink"></c:set>
	<c:if test="${pageInfo.hasPrevButton }">
	    <div class="adminDetail_pagination_preBtn_box">
	        <a href="${paginationLink}/${pageInfo.leftPageNumber-1}" class="adminDetail_pagination_preBtn"><i class="fas fa-chevron-left"></i></a>
	    </div>
	</c:if>
    <div class="adminDetail_pagination_content_box">
    	<c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
	        <a href="${paginationLink}/${pageNumber}" class="adminDetail_pagination_content">${pageNumber }</a>
    	</c:forEach>
    </div>
    <c:if test="${pageInfo.hasNextButton }">
	    <div class="adminDetail_pagination_nextBtn_box">
	        <a href="${paginationLink}/${pageInfo.rightPageNumber+1}" class="adminDetail_pagination_nextBtn"><i class="fas fa-chevron-right"></i></a>
	    </div>
    </c:if>
</div>