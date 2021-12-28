const pw1 = document.querySelector(".join_pw");
const pw2 = document.querySelector(".join_pw_check");
const submitBtn = document.querySelector(".join_submit");
const email = document.querySelector(".join_email");
const emailCheckBtn = document.querySelector(".join_email_check");
let httpRequest;

const changeSubmitBtn = () =>{
    submitBtn.disabled = false;
}

const checkPw = e =>{
    const pw1Value = pw1.value;
    const pw2Value = e.target.value
    if(pw1Value == pw2Value){
        changeSubmitBtn();
    }
}

function makeRequest() {
    httpRequest = new XMLHttpRequest();

    if(!httpRequest) {
      console.log('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('POST', 'http://localhost:8080/controller/user/join/emailCheck',false);
    httpRequest.send();
}

function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
        console.log(httpRequest.responseText);
      } else {
        console.log('request에 뭔가 문제가 있어요.');
      }
    }
  }

const init = () =>{
    pw2.addEventListener("keyup",checkPw);
    emailCheckBtn.addEventListener("click",makeRequest);
}

init();