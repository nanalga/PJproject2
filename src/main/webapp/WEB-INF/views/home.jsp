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
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/icon/css/all.css" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
	<title>Home</title>
</head>
<body>
<body>
    <div class="body_wrapper main_page">  
    	<tag:nav></tag:nav>
        <div class="main_container">
        	<div class="main_page_container">
        		<div class="main_title_box">
                <div class="main_title_img_box">
                    <img src="#" class="main_title_img">
                </div>   
                <div class="main_title_content_box">
                    <h2>New that lasts.</h2>
                    <p>Schwartz Media publishes intelligent news and current affairs that breaks the 24-hour news cycle. We offer a nuanced examination of Australia and the world, focused on fresh insight and literary expression. Our audience reads to know, not just to agree. We invest in long-form journalism where the issues demand it, providing writing of a quality that makes difficult topics clear. Schwartz Media publishes Australia’s most respected writers across The Saturday Paper, The Monthly magazine and the daily podcast 7am, alongside our sister publications, Quarterly Essay and Australian Foreign Affairs.</p>
                </div>
            </div>
            <div class="main_content_box">
                <div class="main_content_food_box content_box">
                    <div class="main_content_img_box">
                        <img src="" alt="">
                    </div>
                    <div class="main_content_text_box">
                        <h2>Food</h2>
                        <p>Our journalists create in-depth, independent, original public interest reporting, focusing on storytelling and insight.</p>
                        <div class="food_link_btn">
                            <a href="${ContextPath }/food/foodList">go to Food</a>
                        </div>
                    </div>     
                </div>
                <div class="main_content_resell_box content_box">
                    <div class="main_content_text_box">
                        <h2>Resell</h2>
                        <p>publishes long-form journalism from the nation's leading writers and thinkers, covering Australian politics, culture and ideas.</p>
                        <div class="food_link_btn">
                            <a href="${ContextPath }/resellMarket/resellBoard/resellBoardList">go to Resell</a>
                        </div>
                    </div>
                    <div class="main_content_img_box">
                        <img src="" alt="">
                    </div>
                </div>
                <div class="main_content_community_box content_box">
                    <div class="main_content_img_box">
                        <img src="" alt="">
                    </div>
                    <div class="main_content_text_box">
                        <h2>community</h2>
                        <p> is a weekly newspaper, dedicated to telling the whole story. It publishes long-form accounts of the week’s key stories.</p>
                        <div class="food_link_btn">
                            <a href="${ContextPath }/community/community_FreeBoard">go to Community</a>
                        </div>
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
