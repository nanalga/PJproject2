const userPowerBox = document.querySelector(".user_power_content");
const deleteBtn = document.querySelector(".user_power_conent_delete");
const boardType = document.querySelector(".board_type_info");
const boardId = document.querySelector(".user_power_conent_id");




function makeRequest() {
    httpRequest = new XMLHttpRequest();
	let data ={
		boardId : boardId.value
	}
	let jsonData = JSON.stringify(data);
    if(!httpRequest) {
      console.log('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('POST', `http://localhost:8080/controller/user/userDetail/${boardType.value}`,false);
	httpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    httpRequest.send(jsonData);
}

function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
		const message = httpRequest.responseText
		if(message == 'able'){
			emailAlertMessage.innerText = "사용가능한 이메일 입니다."
			email.readOnly=true;
			emailCheckBtn.value="again"
			canUseEamil = true;
			emailCheckBtn.removeEventListener("click",makeRequest);
			emailCheckBtn.addEventListener("click",()=>{
				email.innerText ="";
				email.readOnly=false;
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

const foodBoardDeleteHandler = () =>{
	
}

const resellBoardDeleteHandler = () =>{
	
}

const cmBoardDeleteHandler = () =>{
	
}

const init = () =>{
	switch(boardType.value){
		case "food":
			deleteBtn.addEventListener("click",foodBoardDeleteHandler);
			break;
		case "resell":
			deleteBtn.addEventListener("click",resellBoardDeleteHandler);
			break;
		case "cm":
			deleteBtn.addEventListener("click",cmBoardDeleteHandler);
			break;
					
	}
}

if(userPowerBox != null){
	init();
}
