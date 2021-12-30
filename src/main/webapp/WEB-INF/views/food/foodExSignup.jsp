<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="<%= request.getContextPath() %>/resource/css/icon/css/all.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<title>Insert title here</title>
</head>
<body>
 <b:navBar></b:navBar> 
 <!-- .container>.row>.col>h1{회원가입} -->
  <div class="container">
  	<div class="row">
  		<div class="col">
  			<h1>회원가입</h1>
  			
  			<c:if test="${not empty alertMessage}">
  				<div class="alter alert-warning">
  					${alertMessage }
  				</div>
  			</c:if>
  			
  			<!-- form>.form-group*4>label[for=input$]+input.form-control#input$[required]^button.btn.btn-outline-primary{가입} -->
  			<form method="post">
  				
  				<div class="form-group">
  					<label for="input1">아이디</label>
  					<!-- .input-group>.input-group-append>button.btn.btn-secondary#idCheckButton{중복확인} -->
  					<div class="input-group">
  						<input type="text" class="form-control" id="input1" required name="id" value="${ResellMember.id }">
  						<div class="input-group-append">
  							<button class="btn btn-secondary" id="idCheckButton" type="button">중복확인</button>
  						</div>
  					</div>
  					<!-- small.form-text#idCheckMessage -->
  					<small class="form-text" id="idCheckMessage"></small>
  				</div>
  				
  				<div class="form-group">
  					<label for="input2">패스워드</label>
  					<input type="password" class="form-control" id="input2" required name="password" value="${ResellMember.password }">
  				</div>
  				<div class="form-group">
  					<label for="input6">패스워드 확인</label>
  					<input type="password" class="form-control" id="input6" required >
  				</div>
  				
				<div class="form-group">
					<label for="input3">닉네임</label>
					<div class="input-group">
						<input type="text" class="form-control" id="input3" required name="nickName" value="${ResellMember.nickName }">
						<div class="input-group-append">
							<button class="btn btn-secondary" type="button" id="nickNameCheckButton">닉네임 중복확인</button>
						</div>
					</div>
					<!-- small.form-text#nickNameCheckMessage -->
  					<small class="form-text" id="nickNameCheckMessage"></small>
				</div>
  				
					<div class="form-group">
  					<label for="input4">이메일</label>
  					<input type="email" class="form-control" id="input4" required name="email" value="${ResellMember.email }">
  				</div>
  				<div class="form-group">
  					<label for="input5">주소</label>
  					<input type="text" class="form-control" id="input5" required name="address" value="${ResellMember.address }">
  				</div>
  				<div class="form-group">
  					<label for="input5">나머지 주소</label>
  					<input type="text" class="form-control" id="input5" required name="address" value="${ResellMember.addressDetail }">
  				</div>
  				<button class="btn btn-outline-primary" id="submitButton1">가입</button>
  			</form>
  		</div>
  	</div>
  </div>
 	
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
 
 <script>
 $(document).ready(function(){
	// 두개의 인풋요소 값이 같을 때만 submit 버튼 활성화
	// 아니면 비활성화
	const passwordInput = $("#input2");
	const passwordConfirmInput = $("#input6");
	const submitButton = $("#submitButton1");
		
	 // submit 버튼 활성화 조건 변수
	 let idAble = false;
	 let passwordCheck = false;
	 let nickNameAble = false;
	 
	 // submit 버튼 활성화 메소드
	 let enableSubmit = function(){
		 if (idAble && passwordCheck && nickNameAble) {
			 submitButton.removeAttr("disabled");
		 } else {
			 submitButton.attr("disabled", true);
		 }
	 } 
	 
	// contextPath
	const appRoot = '${pageContext.request.contextPath}';
	// 아이디 중복확인 버튼이 클릭되면
	// 아이디 input요소에 입력된 값을
	// 서버에 전송하고
	// 응답받은 값에 따라서 
	// 1) 서브밋 버튼 활성화 또는 비활성화 또는 비활성화 AND
	// 2) 사용가능 또는 불가능 메세지 출력
	
	$("#idCheckButton").click(function(){		// 아이디 중복확인 버튼이 클릭되면
		$("#idCheckButton").attr("disabled", true);
		const idValue = $("#input1").val().trim();		// 아이디 input요소에 입력
		// 아이디 input에 입력 안되었을 경우 더 이상 진행하지 않고
		// 아이디 입력하라는 메세지 출력
		if (idValue.trim() === "") {
			$("#idCheckMessage")
				.text("아이디를 입력해주세요.")
				.removeClass("text-warning text-primary")
				.addClass("text-danger");

			return ;
		}
		
		$.ajax({				// 서버에 전송
			url : appRoot + "/food/idcheck",
			data : {	 	// url로 데이터전송
				id : idValue
			},
			success : function(data){ // (controller)/member/idcheck에서 검사 결과 
				switch (data) {
				case "able":
					// 사용 가능할 때
					$("#idCheckMessage")
						.text("사용가능한 아이디 입니다.")
						.removeClass("text-danger text-warning")
						.addClass("text-warning");
					
					$("#input1").attr("readonly", true);
					
					// 서브밋 버튼 활성화 조건 추가
					idAble = true;
					break;
					
				case "unable":
					// 사용 불가능할 때
					$("#idCheckMessage")
						.text("이미 있는 아이디 입니다.")
						.removeClass("text-warning text-primary")
						.addClass("text-danger");
					
					// 서브밋 버튼 비활성화 조건 추가
					idAble = false;
					break;
					
				default:
					break;
				}
			},
			complete : function() {	// 요청 후 중복확인버튼 비활성화
				enableSubmit();	// 조건이 충족되었을 때만 submit 버튼 활성화
				$("#idCheckButton").removeAttr("disabled");
			}
			
		});
		
	});
		
	// 닉네임 중복 확인 Ajax
	$("#nickNameCheckButton").click(function(){		// 아이디 중복확인 버튼이 클릭되면
		$("#nickNameCheckButton").attr("disabled", true);
	
		const nickName = $("#input3").val().trim();		// 아이디 input요소에 입력
		
		console.log(nickName);
		// 닉네임 input에 입력 안되었을 경우 더 이상 진행하지 않고
		// 닉네임 입력하라는 메세지 출력
		if (nickName === "") {
			$("#nickNameCheckMessage")
				.text("닉네임을 입력해주세요.")
				.removeClass("text-warning text-primary")
				.addClass("text-danger");
			$("#nickNameCheckButton").removeAttr("disabled");
			return ;
		}
		
		$.ajax({				// 서버에 전송
			url : appRoot + "/food/nickNameCheck",
			data : {	 	// url로 데이터전송
				nickName : nickName
			},
			success : function(data){ // (controller)/member/nickNameCheck에서 검사 결과 
				switch (data) {
				case "able":
					// 사용 가능 할 때
					console.log("가능");
					$("#nickNameCheckMessage")
						.text("사용가능한 닉네임 입니다.")
						.removeClass("text-danger text-danger")
						.addClass("text-warning");
					
					$("#input3").attr("readonly", true);
					
					// 서브밋 버튼 활성화 조건 추가
					nickNameAble = true;
					
					break;
					
				case "unable":
					// 사용 불가능 할 때
					console.log("불가능");
					$("#nickNameCheckMessage")
						.text("이미 있는 닉네임 입니다.")
						.removeClass("text-warning text-primary")
						.addClass("text-danger");
					
					// 서브밋 버튼 비활성화 조건 추가
					nickNameAble = false;
					
					break;
					
				}
			},
			complete : function() {	// 요청 후 중복확인버튼 비활성화
				enableSubmit();	// 조건이 충족되었을 때만 submit 버튼 활성화
				$("#nickNameCheckButton").removeAttr("disabled");
			}
			
		});
		
	});
		

	
	
	// *아래 코드 필요한 요소들 선택
	 
	// 암호 input과 함호 확인input값 비교해서 서브밋 버튼 활성화 또는 비활성화
	const confirmFunction = function(){
	const passwordValue = passwordInput.val();
	const passwordConfirmValue = passwordConfirmInput.val();
		
	// 두 인풋 요소의 값을 비교해서 서브밋 버튼 활성화 또는 비활성화
	if(passwordValue === passwordConfirmValue) {
		// submitButton.removeAttr("disabled");	// removeAttr("disabled") -> attr("disabled") 삭제 -> 버튼 활성화
		passwordCheck = true;
	} else {
		// submitButton.attr("disabled", true);	// attr("disabled", true(값))에서는 -> 상관없이 disabled 상태
		passwordCheck = false;
	}
		
		enableSubmit(); // 조건이 충족되었을 때만 submit버튼 활성화
	};
	 
	submitButton.attr("disabled", true);	// submitButton 비활성화
	passwordInput.keyup(confirmFunction);	// keyup : keyboard에서 누르고 손땟을때의 이벤트, 패스워드 비교 메소드 실행
	passwordConfirmInput.keyup(confirmFunction);
	 
		 
	 
	 
 });
 </script>
 
 
</body>
</html>