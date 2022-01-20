<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="active"%>

<header class="header_container">
    <div class="header_box">
        <div class="header_menu_btn">
            <i class="fas fa-bars"></i>
        </div>
        <a class="header_home_link" href="${pageContext.request.contextPath }/">
            <!-- <img src="./resource/잘생긴용피리.png" alt=""> -->
            <span>용피리월드</span>
        </a>
    </div>
</header>