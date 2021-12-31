const updateBtn = document.querySelector(".user_edit_updateBtn");
const deleteBtn = document.querySelector(".user_edit_deleteBtn");
const submitBtn = document.querySelector(".user_edit_submitBtn");
const emailCheckBtn = document.querySelector(".edit_email_check");
const emailInput = document.querySelector("#user_edit_input2");
const passwordInput = document.querySelector(".user_edit_password");
const passwordCheckInput = document.querySelector(".user_edit_password_check");

const contextPathInfoElem = document.querySelector(".contextPath");
const firstEamilValueElem = document.querySelector(".firstEamilValue");
const firstPasswordValueElem = document.querySelector(".firstPasswordValue");

const hiddenForm = document.querySelector(".user_edit_hidden_form");
const emailAlertMessage = document.querySelector(".edit_email_message");
const form = document.querySelector(".user_edit_form");
let contextPathInfo 

let firstEamilValue 
let currentInputValue

let firstPwValue

let httpRequest

let canUseEamil = true;
let canUsePassword = true;

const changeFormActionPathAndSubmit = (path) =>{
	console.log(`${path} is work`)
	form.action = contextPathInfo+path;
	submitBtn.click();
}

const updateHandler = (e) =>{
	e.preventDefault()
	changeFormActionPathAndSubmit("/user/update");
}

const deleteHandler = (e) =>{
	e.preventDefault()
	changeFormActionPathAndSubmit("/user/userDelete");
}

const emailValueCheckHandler = (e) =>{
	canUseEamil = false;
	emailCheckBtn.addEventListener("click",makeRequest);
	checkCanPushSubmitBtn();
	const currentInputValue = e.target.value;
	if(currentInputValue == firstEamilValue){
		emailCheckBtn.removeEventListener("click",makeRequest);
		updateBtn.disabled = true;
		canUseEamil = true;
	}
}

const checkCanPushSubmitBtn = () =>{
	const ok1 = passwordInput.value == firstPwValue; 	
	const ok2 = emailInput.value == firstEamilValue;
	const isPwSame = ok1&&ok2
	console.log("5")
	console.log(isPwSame);
	if(canUseEamil&&canUsePassword&&!isPwSame){
		updateBtn.disabled = false;
	}else{
		updateBtn.disabled = true;
	}
}

function makeRequest() {
    httpRequest = new XMLHttpRequest();
	let data ={
		email : emailInput.value
	}
	let jsonData = JSON.stringify(data);
    if(!httpRequest) {
      console.log('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('POST', 'http://localhost:8080/controller/user/checkEmail',false);
	httpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    httpRequest.send(jsonData);
}

function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
		const message = httpRequest.responseText
		if(message == 'able'){
			emailAlertMessage.innerText = "사용가능한 이메일 입니다."
			canUseEamil = true;
			checkCanPushSubmitBtn();
		}else{
			emailAlertMessage.innerText = "사용불가능한 이메일 입니다."
		}
      } else {
        console.log('request에 뭔가 문제가 있어요.');
      }
    }
  }

const passwordCheckHandler = () =>{
	let pw1Value = passwordInput.value;
	let pw2Value = passwordCheckInput.value;
	if(pw1Value == firstPwValue){
		console.log("1")
		canUsePassword= true;
	}else{
		console.log("2")
		canUsePassword= false;
	}
	console.log("3")
	if(pw1Value == pw2Value){
		console.log("4")
		canUsePassword = true;
	}
	checkCanPushSubmitBtn();
}

const init = () =>{
	updateBtn.addEventListener("click",updateHandler);
	deleteBtn.addEventListener("click",deleteHandler);
	emailInput.addEventListener("input",emailValueCheckHandler);
	passwordInput.addEventListener("input",passwordCheckHandler);
	passwordCheckInput.addEventListener("input",passwordCheckHandler);
}

/*window.onload = () =>{
	firstEmailValue = emailInput.value;
	console.log(firstEmailValue)
}*/

if(updateBtn!=null){
	console.log("edit.js file work")
	contextPathInfo = contextPathInfoElem.value;
	firstEamilValue = firstEamilValueElem.value;
	firstPwValue = firstPasswordValueElem.value;
	
	init();	
	setInterval(()=>console.log(canUseEamil,canUsePassword),1000)
}