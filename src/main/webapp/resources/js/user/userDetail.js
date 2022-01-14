const userPower = document.querySelector(".user_power");
const userPowerContent = document.querySelector(".user_power_content");
const pathInput = document.querySelector(".user_power_path");
const appRootInput = document.querySelector(".user_power_appRoot");
const bodyWrapper = document.querySelector(".body_wrapper");
const mainContainer = document.querySelector(".main_container");
const confirmModal = document.querySelector(".confirm_modal_container");
const confirmModalYes = document.querySelector(".confirm_modal_yes");
const confirmModalNo = document.querySelector(".confirm_modal_no");

let appRoot;
let path;
let successMessage
let failedMessage
let foodListBar
let resellListBar

const listBoard = function() {
	console.log("work");
    $.ajax({
    url : appRoot + `/getBaordList/user/getList/${path}`,
    success : function(list) {
		if(path == "food"){
			userPowerContent.innerHTML = "";
			$(".user_power_content").append(foodListBar);
			for (let i = 0; i < list.length; i++) {
				const deleteLink = `/getBaordList/user/delete/food/${list[i].id}`;
		        const foodListObject = $(`
		        <div class="user_power_content_info_food">
		            <span class="user_power_conent_id">${list[i].id }</span>
					<a href="${appRoot}/food/foodGet?id=${list[i].id}" class="user_power_conent_name_link">
			            <span class="user_power_conent_title">${list[i].title }</span>
					</a>
		            <span class="user_power_conent_writer">${list[i].name }</span>
		            <span class="user_power_conent_updated">${list[i].userInserted }</span>
		            <input type="hidden" class="board_type_info" value="resell">
		            <a class="user_power_delete" style="cursor:pointer"><i class="fas fa-times"></i></a>
		        </div>`);
				
				foodListObject.find(".user_power_delete").click({deleteLink:deleteLink},deleteBtnHandler)
				$(".user_power_content").append(foodListObject);
        	}
		}else if(path == "resell"){
			userPowerContent.innerHTML = "";
			$(".user_power_content").append(resellListBar);
			for (let i = 0; i < list.length; i++) {
				const deleteLink = `/getBaordList/user/delete/resell/${list[i].id}`;
		        const resellListObject = $(`
		        <div class="user_power_content_info_resell">
                    <span class="user_power_conent_id">${list[i].id}</span>
					<a href="${appRoot}/resellMarket/resellBoard/resellBoardGet?id=${list[i].id}" class="user_power_conent_name_link">
	                    <span class="user_power_conent_title">${list[i].title}</span>
					</a>
                    <span class="user_power_content_writer">${list[i].name}</span>
                    <span class="user_power_content_price">${list[i].price}</span>
                    <span class="user_power_conent_updated">${list[i].userUpdated}</span>
                    <input type="hidden" class="hiddenInfo">
                    <a class="user_power_delete" style="cursor:pointer"><i class="fas fa-times"></i></a>
                </div>
				`);
		
				resellListObject.find(".user_power_delete").click({deleteLink:deleteLink},deleteBtnHandler)
		        $(".user_power_content").append(resellListObject);
        	}
		}
        }
    })
}

const deleteBtnHandler = (e) =>{
	confirmModal.classList.remove("confirm_modal_off_modal");
	mainContainer.classList.add("confirm_modal_on_background");
	confirmModalYes.addEventListener("click",()=>{
		$.ajax({
			url : appRoot + e.data.deleteLink,
			type:"delete",
			success: function(){
				console.log("success")
				$(".body_wrapper").append(successMessage)
			},
			error: function(){
				console.log("fail")
				$(".body_wrapper").append(failedMessage)
			},
			complete :function(){
				listBoard();
				confirmModal.classList.add("confirm_modal_off_modal");
				mainContainer.classList.remove("confirm_modal_on_background");
			}
	})
	},{once:true});
	confirmModalNo.addEventListener("click",()=>{
		confirmModal.classList.add("confirm_modal_off_modal");
		mainContainer.classList.remove("confirm_modal_on_background");
	})
	
}

const init = () =>{
    appRoot = appRootInput.value;
	path = pathInput.value;
	successMessage = $(`
	<div class="flash_box_success">
	    <div class="flash_img_box">
            <img src="${appRoot}/resource/img//잘생긴용피리.png" alt="">
        </div>
        <div class="flash_message_box">
            <span class="flash_message_title">성공!!</span>
            <span class="flash_message_content">삭제성공~~!!</span>
        </div>
	</div>
	`)
	
	failedMessage = $(`
	<div class="flash_box_fail">
	    <div class="flash_img_box">
            <img src="${appRoot}/resource/img/잘생긴용피리.png" alt="">
        </div>
        <div class="flash_message_box">
            <span class="flash_message_title">실패..ㅠㅠ</span>
            <span class="flash_message_content">삭제에 실패했어요..</span>
        </div>
	</div>
	`)
	
	foodListBar = $(`
	<div class="user_power_content_bar_food">
	    <span class="user_power_content_bar_id">ID</span>
	    <span class="user_power_content_bar_name">제목</span>
	    <span class="user_power_content_bar_name">작성자</span>
	    <span class="user_power_content_bar_password">작성일</span>
	    <span class="user_power_content_bar_password"><i class="fas fa-times"></i></span>
	</div>`
	);
	
	resellListBar = $(`
	<div class="user_power_content_bar_resell">
	    <span class="user_power_content_bar_id">ID</span>
	    <span class="user_power_content_bar_name">제목</span>
	    <span class="user_power_content_bar_writer">작성자</span>
	    <span class="user_power_content_bar_price">가격</span>
	    <span class="user_power_content_bar_updated">수정일</span>
	    <span class="user_power_content_bar_delete"><i class="fas fa-times"></i></span>
	</div>
	`)
    listBoard();
}

if(userPower != null){
    init();
}

