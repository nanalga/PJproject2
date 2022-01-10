<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource//css/kocss/mystyle.css">
<!--외부 css -->


<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<script src="http://d3js.org/d3.v3.min.js"></script>
<style>
        .font_big { font-size: 1em;}
        .font_italic { font-style: italic;}
        .font_bold { font-weight: bold;}
        .font_center { text-align: center;}
        .writeBtn {
            width: 50px;
            height: 25px;
            background-color: #d734ecb2;
            border: 10px solid #FFFFFF;
            border-radius: 30px;
            box-shadow: 5px 5px 5px #9c3131;
        }
        
          .writeBtn > a {
            display: block;
            line-height: 18px;
        }
        
        .tdcss {
       		 font-size: 1em;
       		 font-style: italic;
       		 font-weight: bold;
       		 
        }
        
        .thcss {
        	font-style: italic;
        	color : #889EC8;
        	font-weight : 800;
        }
        
   	.listHead {
		font-size :32px;
		font-weight : bolder;
		font-style : italic;
		text-align : center;
		text-shadow: 5px 5px 11px rgba(137, 68, 116, 1);
		
	}
	
	.listHeadDiv	{
		width : 100%;
		height : 50px;
		-webkit-box-shadow: 0px 0px 23px 0px rgba(217, 111, 77, 0.52);
		-moz-box-shadow:    0px 0px 23px 0px rgba(217, 111, 77, 0.52);
		box-shadow:         0px 0px 23px 0px rgba(217, 111, 77, 0.52);
	}

</style>
<style>
.face {
    fill : #FFF;
    stroke-width: 2px;
    stroke: #000;
}
.number {
    font-family: arial;
	text-anchor: middle;
	text-align: right;
}
.hands{
	stroke: #000;
	stroke-linecap: round;
}
</style>



<title>resellBoardList</title>
</head>
<body>
	<div class="body_wrapper">
		<tag:nav></tag:nav>

		<!-- .container>.row>.col>h1{게시물 목록} -->
		<div class="main_container">
			<div class="row" style="width: 80%">
				<div class="col">
				<div class="listHeadDiv">
					<h1 class="listHead">게시물 목록</h1>
				</div>
					<!-- table.table>thead>tr>th*4>^^tbody -->
					<table class="table tb">
						<thead>
							<tr>
								<th>
									<i class="fas fa-tag"></i>
								</th>
								<th class="thcss">제목</th>
								<th class="thcss">작성자</th>
								<th class="thcss">가격</th>
								<th class="thcss">작성일</th>
								<th class="thcss">조회수</th>
							</tr>
						<tbody>
							<c:forEach items="${resellList}" var="resellBoard">
								<tr>
									<td>${resellBoard.id }</td>
									<td class="tdcss">
										<a href="resellBoardGet?id=${resellBoard.id }">
											<c:out value="${resellBoard.title }"></c:out>
										</a >
										<c:if test="${resellBoard.replyCount > 0 }">
										<i class="far fa-comments">${resellBoard.replyCount }</i>
										</c:if>
									</td>
									<td>
										<c:out value="${resellBoard.nickName }"></c:out>
									</td>
									<td>
										<c:out value="${resellBoard.price }"></c:out>
									</td>
									<td>${resellBoard.customInserted }</td>
									<td> ${resellBoard.boardCount }</td>
								</tr>
							</c:forEach>
						</tbody>
						</thead>
					</table>
					<div >
					<a href='<c:url value='/resellMarket/resellBoard/resellBoardRegister'/>' role="button" class="btn btn-outline-primary font_big font_italic font_bold font_center">글쓰기</a>
						<a href='<c:url value='/resellMarket/resellBoard/test2'/>' role="button" class="btn btn-outline-primary font_big font_italic font_bold font_center" style="float : right;">테트?</a>
					</div>
					<div>
					</div>
				</div>
			</div>
			<!-- search foodBoard -->
			<form action="" name="form1" method="get">
				<div class="form-inline">
					<select class="search_area" id="searchType" name="searchType">
						<option value="">검색조건</option>
						<option value="all">전체조건</option>
						<option value="t">제목</option>
						<option value="w">작성자</option>
						
						
						<!-- 			<option value="c">내용</option>
				<option value="tc">제목+내용</option>
				<option value="all">전체조건</option> -->
					</select>
					<input type="hidden" name="countRows">
					<input type="hidden" name="currentPage">
					<input type="hidden" name="">
					<input type="hidden" name="">
					
					<input class="form-control" type="text" id="keyword" name="keyword" value="${pageInfo.keyword}" placeholder="검색어를 입력하세요" />
					<button id="searchBtn" class="myBtn font_big font_italic font_bold font_center">Search</button>
				<svg id="clock" style="width:100px; height:100px; float: right;"></svg>
				</div>
			</form>
		

			<!--pagination  -->
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${pageInfo.hasPrevButton }">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageInfo.leftPageNumber - 1 }"></c:param>
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>

					<c:forEach begin="${pageInfo.leftPageNumber }" end="${pageInfo.rightPageNumber }" var="pageNumber">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageNumber }"></c:param>
						</c:url>
						<li class="page-item ${pageInfo.currentPage == pageNumber ? 'active' : '' }">
							<a class="page-link" href="${pageLink }">${pageNumber }</a>
						</li>
					</c:forEach>
					<c:if test="${pageInfo.hasNextButton }">
						<c:url value="/resellMarket/resellBoard/resellBoardList" var="pageLink">
							<c:param name="page" value="${pageInfo.rightPageNumber + 1 }"></c:param>
						</c:url>
						<li class="page-item">
							<a class="page-link" href="${pageLink }" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
	
	

	<!-- Modal -->
	<c:if test="${not empty result }">
		<div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">처리결과</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>${result }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>
<tag:footer></tag:footer>
	<tag:menu></tag:menu>
	<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

	<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function() {
			if (history.state == null) {
				$("#staticBackdrop").modal('show');
				history.replaceState("historystate not null", null);
			}

		});
	</script>

<%-- 시계 --%>
<script>
/*
 * 1초 한번씩 시간을 다시 표시
 */
var clock = document.getElementById('clock');
var center = parseInt(clock.style.height) / 2;
var radius = center * 0.90;

drawFace(radius);
drawNumbers(radius);

var hourHand = drawHand(0, 0, radius*0.07);
var minuteHand = drawHand(0, 0, radius*0.07);
var secondHand = drawHand(0, 0, radius*0.02);

drawClock();

function drawClock() {
	drawTime(radius);
	setTimeout(drawClock, 1000);
}

function drawFace(radius) {
	createElement('circle', clock, {"cx": center, "cy": center, "r": radius, "class": "face"});
	createElement('circle', clock, {"cx": center, "cy": center, "r": radius*0.1, "fill": "#000"});
}

function drawNumbers(radius) {
	var pos = radius*0.85;
	for (var num = 1; num < 13; num++) {
		var x = pos * Math.cos(Math.PI* ((30 * num)-90)/ 180);
		var y = pos * Math.sin(Math.PI* ((30 * num)-90)/ 180);

		var text = createElement('text', clock, {"x": x+center, "y": y+center, "class": "number"});
		text.style.fontSize = radius*0.15 + "px";
		text.appendChild(document.createTextNode(num))
	}
}

function drawTime(radius){
    var now = new Date();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
	var pos = radius*0.5;
	
    //hour
    x = pos* Math.cos(Math.PI* ((hour*30)- 90 + 30/60*minute + 30/60/60*second) / 180); 
    y = pos* Math.sin(Math.PI* ((hour*30)- 90 + 30/60*minute + 30/60/60*second) / 180);
	setAttributes(hourHand, {"x1": center, "y1": center, "x2": x+center, "y2": y+center});

    //minute
	pos = radius*0.8;
    x = pos * Math.cos(Math.PI* ((minute * 6)- 90 + 6/60*second)/ 180); 
    y = pos * Math.sin(Math.PI* ((minute * 6)- 90 + 6/60*second)/ 180);
	setAttributes(minuteHand, {"x1": center, "y1": center, "x2": x+center, "y2": y+center});
	
    // second
	pos = radius*0.9;
    x = pos * Math.cos(Math.PI* ((second * 6)- 90)/ 180); 
    y = pos * Math.sin(Math.PI* ((second * 6)- 90)/ 180);
	setAttributes(secondHand, {"x1": center, "y1": center, "x2": x+center, "y2": y+center});
}

function drawHand( x, y, width) {
	var hand = createElement('line', clock, {"x1": center, "y1": center, "x2": x+center, "y2": y+center, "class": "hands"});
	hand.style["stroke-width"] = width;
	return hand;
}

function createElement(eleType, parent, attributes) {
	var ele = document.createElementNS('http://www.w3.org/2000/svg', eleType);
	parent.appendChild(ele);

    for (var item in attributes) ele.setAttribute(item, attributes[item]);

	return ele;
}

function setAttributes(ele, attributes) {
    for (var item in attributes) ele.setAttribute(item, attributes[item]);
}
</script>


</body>
</html>