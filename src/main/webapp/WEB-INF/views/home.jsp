<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="${ContextPath }/resource/css/icon/css/all.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
	<link rel="stylesheet" href="${ContextPath}/resource/css/styles.css" />
	<title>Home</title>
</head>
<body>
<body>
    <div class="body_wrapper">  
    	<tag:flash></tag:flash>
    	<tag:nav></tag:nav>
        <div class="main_container main_page_default">
        	<div class="main_page_container">
        		<div class="main_title_box">
	                <div class="main_title_img_box">
                        <div class="main_title_img_circle">
                            <div class="main_title_img_yong_box">
                                <img src="${ContextPath}/resource/img/머리만있는용피리.png" class="main_title_img">
                                <img src="${ContextPath}/resource/img/용피리파이어.png" alt="">
                            <!-- <img src="#" alt="" class="main_title_img"> -->
                            </div>
                            <div class="main_title_img_mountain_container">
                                <div class="main_title_img_mountain_box">
                                    <div class="main_title_img_mountain"></div>
                                    <div class="main_title_img_mountain"></div>
                                </div>
                                <div class="main_title_img_mountain_box">
                                    <div class="main_title_img_mountain"></div>
                                    <div class="main_title_img_mountain"></div>
                                </div>
                                <div class="main_title_img_mountain_box">
                                    <div class="main_title_img_mountain"></div>
                                    <div class="main_title_img_mountain"></div> 
                                </div>
                            </div>
                        </div>
	                </div>   
	                <div class="main_title_content_box">
	                    <p>용피리 월드에 오신걸 환영합니다</p>
                        <p>이제부터 용피리와 함께 양산시에 대해 알아보아용</p>
	                </div>
            	</div>
            	<div class="main_content_box">
                	<div class="main_content_food_box content_box">
                        <a class="main_content_text_link_box" href="${ContextPath }/food/foodList">
	                        <div class="main_content_box_background1 display_none"></div>
	                    	<div class="main_content_img_box1">
	                        	<img src="${ContextPath}/resource/img/foodIcon.png" alt="">
	                    	</div>
	                    	<div class="main_content_text_box">
	                                <h2>용피리 골목식당</h2>
	                                <p>배고프죠? 용피리와 함께 맛집을 찾아떠나요~</p>
	                    	</div>     
                        </a>
                	</div>
	                <div class="main_content_resell_box content_box">
                        <a class="main_content_text_link_box" href="${ContextPath }/resellMarket/resellBoard/resellBoardList">
	                        <div class="main_content_box_background2 display_none"></div>
	                        <div class="main_content_img_box2">
	                       	<img src="${ContextPath}/resource/img/resellIcon.png" alt="">
		                   	</div>
		                    <div class="main_content_text_box">
		                               <h2>용피리 중고장터</h2>
		                               <p>쓰지 않는 물건이 있다면</p>
		                               <p>버리지말고 용피리와 함께 팔아보아요~</p>
		                   	</div>
                        </a>
                	</div>
            	</div>
        	</div>
        </div>
        <tag:footer></tag:footer>
        <tag:menu></tag:menu>
    </div>
    <script src="${ContextPath}/resource/js/main.js" type="module"></script>
</body>
</html>