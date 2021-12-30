const updateBtn = document.querySelector(".user_edit_updateBtn");
const deleteBtn = document.querySelector(".user_edit_deleteBtn");
const emailCheckBtn = document.querySelector(".edit_email_check");
const emailInput = document.querySelector("#user_edit_input2");
const contextPathInfoElem = document.querySelector(".contextPath");
const hiddenForm = document.querySelector(".user_edit_hidden_form");
const firstEamilValueElem = document.querySelector(".firstEamilValue");
const emailAlertMessage = document.querySelector(".edit_email_message");
const form = document.querySelector(".user_edit_form");
let contextPathInfo 
let firstEamilValue 
let httpRequest

let canUseEamil = true;

const changeFormActionPathAndSubmit = (path) =>{
	console.log(`${path} is work`)
	form.action = contextPathInfo+path;
	form.submit();
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
	emailCheckBtn.value="again"
	canUseEamil = false;
	deleteBtn.disabled = true;
	let currentInputValue = e.target.value;
	emailCheckBtn.addEventListener("click",makeRequest);
	checkCanPushSubmitBtn();
	if(currentInputValue == firstEamilValue){
		emailCheckBtn.removeEventListener("click",makeRequest);
		deleteBtn.disabled = false;
		updateBtn.disabled = true;
		canUseEamil = true;
	}
}

const checkCanPushSubmitBtn = () =>{
	if(canUseEamil){
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
			/*emailCheckBtn.value="again"*/
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

const init = () =>{
	updateBtn.addEventListener("click",updateHandler);
	deleteBtn.addEventListener("click",deleteHandler);
	emailInput.addEventListener("input",emailValueCheckHandler);
}

/*window.onload = () =>{
	firstEmailValue = emailInput.value;
	console.log(firstEmailValue)
}*/

if(updateBtn!=null){
	console.log("edit.js file work")
	contextPathInfo = contextPathInfoElem.value;
	firstEamilValue = firstEamilValueElem.value;
	init();	
	/*setInterval(()=>console.log(canUseEamil),1000)*/
}