<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>Insert title here</title>
</head>
<body>
    <h1>내사이트임 ㅎㅇ</h1>
    <p></p>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        $.ajax({
            method: "get",
            url: "https://dapi.kakao.com/v3/search/book?target=title",
            data: { query:"시간은 이야기가 된다" },
            headers : {Authorization: "KakaoAK 1a5706e61206f647085802ffe2b38897"}
        })
            .done(function (msg) {
                console.log(msg.documents[0].title);
                console.log(msg.documents[0].thumbnail);
                $( "p" ).append( "<strong>"+msg.documents[0].title+"</strong>" );
                $( "p" ).append( "<img src='"+msg.documents[0].thumbnail+"<'/>" );
            });
        
    </script>
<h1>여기나오늬?</h1>
	<table>
        <tr>
            <th>이름</th>
            <td><input type="text" name="user_name"></td>
        </tr>
        <tr>
            <th>주소</th>
            <td><input type="text" id="address_kakao" name="address" readonly /></td>
        </tr>
        <tr>
            <th>상세 주소</th>
            <td><input type="text" name="address_detail" /></td>
        </tr>
    </table>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>

<!-- Modernizer api import-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
    <script>
      // geolocation api 가 지원되는 브라우저 인지 확인
      if (Modernizr.geolocation) {
        // 현재 위치 가져오기
        navigator.geolocation.getCurrentPosition(
          // 성공이면 위치를 찍어준다.
          function (pos) {
            console.log(pos.coords.latitude);
            console.log(pos.coords.longitude);
          },
          function () {}
        );
      }
    </script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>



</html>