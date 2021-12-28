const pw1 = document.querySelector(".join_pw");
const pw2 = document.querySelector(".join_pw_check");
const submitBtn = document.querySelector(".join_submit");
const email = document.querySelector(".join_email");
const emailCheckBtn = document.querySelector(".join_email_check");
const emailAlertMessage = document.querySelector(".join_email_message")
let httpRequest;

let canUseEamil = false;
let canUsePw = false;

const ableSubmitBtn = () =>{
    submitBtn.disabled = false;
}

const unableSubmitBtn = () =>{
	submitBtn.disabled = true;
}

const checkPw = e =>{
    const pw1Value = pw1.value;
    const pw2Value = pw2.value;
    if(pw1Value == pw2Value){
        canUsePw = true;
    }else{
		canUsePw = false;
	}
	checkCanPushSubmitBtn();
}

function makeRequest() {
    httpRequest = new XMLHttpRequest();
	let data ={
		email : email.value
	}
	let jsonData = JSON.stringify(data);
    if(!httpRequest) {
      console.log('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('POST', 'http://localhost:8080/controller/user/join/checkEmail',false);
	httpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    httpRequest.send(jsonData);
}

function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
		const message = httpRequest.responseText
		if(message == 'able'){
			emailAlertMessage.innerText = "사용가능한 이메일 입니다."
			email.disabled=true;
			emailCheckBtn.value="again"
			canUseEamil = true;
			emailCheckBtn.removeEventListener("click",makeRequest);
			emailCheckBtn.addEventListener("click",()=>{
				email.innerText ="";
				email.disabled=false;
				canUseEamil = false;
				emailCheckBtn.value="check"
				checkCanPushSubmitBtn();
				emailCheckBtn.addEventListener("click",makeRequest);
			})
			checkCanPushSubmitBtn();
		}else{
			emailAlertMessage.innerText = "사용불가능한 이메일 입니다."
		}
      } else {
        console.log('request에 뭔가 문제가 있어요.');
      }
    }
  }

const checkCanPushSubmitBtn = () =>{
	if(canUseEamil&&canUsePw){
		ableSubmitBtn();
	}else{
		unableSubmitBtn();
	}
}

const init = () =>{
    pw2.addEventListener("keyup",checkPw);
	pw1.addEventListener("keyup",checkPw);
    emailCheckBtn.addEventListener("click",makeRequest);
}

init();