console.log("hello");

//--------------------------------

//<!-- Modernizer api import 예시;-->
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