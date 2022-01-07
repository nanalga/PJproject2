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

const successMessage = $(`
<div class="flash_box">
    <div class="flash_message_box">
        <span class="flash_message_title">sucess</span>
        <span class="flash_message_content">삭제에 성공했습니다.</span>
    </div>
</div>
`)

const failedMessage = $(`
<div class="flash_box">
    <div class="flash_message_box">
        <span class="flash_message_title">fail</span>
        <span class="flash_message_content">삭제에 실패했습니다.</span>
    </div>
</div>
`)

const foodListBar = $(`
<div class="user_power_content_bar_food">
    <span class="user_power_content_bar_id">id</span>
    <span class="user_power_content_bar_name">title</span>
    <span class="user_power_content_bar_name">writer</span>
    <span class="user_power_content_bar_password">inserted</span>
    <span class="user_power_content_bar_password"><i class="fas fa-times"></i></span>
</div>`
);

const resellListBar = $(`
<div class="user_power_content_bar_resell">
    <span class="user_power_content_bar_id">id</span>
    <span class="user_power_content_bar_name">title</span>
    <span class="user_power_content_bar_writer">writer</span>
    <span class="user_power_content_bar_price">price</span>
    <span class="user_power_content_bar_updated">updated</span>
    <span class="user_power_content_bar_delete"><i class="fas fa-times"></i></span>
</div>
`)

const listBoard = function() {
	console.log("work");
    $.ajax({
    url : appRoot + `/GetBaordList/getList/${path}`,
    success : function(list) {
		if(path == "food"){
			userPowerContent.innerHTML = "";
			$(".user_power_content").append(foodListBar);
			for (let i = 0; i < list.length; i++) {
				const deleteLink = `/GetBaordList/delete/food/${list[i].id}`;
		        const foodListObject = $(`
		        <div class="user_power_content_info_food">
		            <span class="user_power_conent_id">${list[i].id }</span>
		            <span class="user_power_conent_title">${list[i].title }</span>
		            <span class="user_power_conent_writer">${list[i].name }</span>
		            <span class="user_power_conent_updated">${list[i].inserted }</span>
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
				const deleteLink = `/GetBaordList/delete/resell/${list[i].id}`;
		        const resellListObject = $(`
		        <div class="user_power_content_info_resell">
                    <span class="user_power_conent_id">${list[i].id}</span>
                    <span class="user_power_conent_title">${list[i].title}</span>
                    <span class="user_power_content_writer">${list[i].name}</span>
                    <span class="user_power_content_price">${list[i].price}</span>
                    <span class="user_power_conent_updated">${list[i].updated}</span>
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
				$(".body_wrapper").append(successMessage)
			},
			error: function(){
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
    listBoard();
}

if(userPower != null){
    init();
}

