<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="active"%>

<c:url value="/user" var="userUrl"></c:url>
<c:url value="/resellMarket/resellBoard/resellBoardList" var="listUrl"></c:url>
<c:url value="/resellMarket/resellBoard/resellBoardRegister" var="registerUrl"></c:url>
<c:url value="/resellMarket/resellMember/signup" var="signupUrl"></c:url>
<c:url value="/resellMarket/resellMember/login" var="loginUrl"></c:url>
<c:url value="/resellMarket/resellMember/logout" var="logoutUrl"></c:url>
<c:url value="/resellMarket/resellMember/info" var="memberInfoUrl"></c:url>
<c:url value="/resellMarket/resellMember/memberList" var="memberListUrl"></c:url>

<header class="header_container">
       <div class="header_box">
           <div class="header_menu_btn">
               <i class="fas fa-bars"></i>
           </div>
           <a class="header_home_link" href="${pageContext.request.contextPath }/">
               <span>DNFriend</span>
           </a>
            <a class="header_home_link" href="${listUrl }">
               <span>목록</span>
           </a>           
        <c:if test="${empty sessionScope.loggedInMember }">   
         
             <a class="header_home_link" href="${signupUrl }">
               <span>회원가입</span>
           </a>
             <a class="header_home_link" href="${loginUrl }">
               <span>로그인</span>
           </a>
         </c:if> 
	<c:if test="${not empty sessionScope.loggedInMember }">
	             <a class="header_home_link" href="${logoutUrl }">
               <span>로그아웃</span>
           </a>
            <a class="header_home_link" href="${registerUrl }">
               <span>글쓰기</span>
           </a>  

             <a class="header_home_link" href="${memberInfoUrl }">
               <span>회원정보보기</span>
           </a>    
              <a class="header_home_link" href="${memberListUrl }">
               <span>전체회원목록</span>
           </a>  
    </c:if>                                                          
       </div>
   
       
       
</header>