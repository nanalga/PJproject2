const deleteBtns = document.querySelectorAll(".admin_power_delete");
const mainContainer = document.querySelector(".main_container");
const confirmModal = document.querySelector(".confirm_modal_container");
const confirmModalYes = document.querySelector(".confirm_modal_yes");
const confirmModalNo = document.querySelector(".confirm_modal_no");	



const deleteBtnHandler = e =>{
	e.preventDefault();
	const target = e.currentTarget;
	confirmModal.classList.remove("confirm_modal_off_modal");
	mainContainer.classList.add("confirm_modal_on_background");
	confirmModalYes.addEventListener("click",()=>{
		target.removeEventListener("click",deleteBtnHandler);
		target.click();
	},{once:true})	
	
	confirmModalNo.addEventListener("click",()=>{
		confirmModal.classList.add("confirm_modal_off_modal");
		mainContainer.classList.remove("confirm_modal_on_background");
	})
	
}

const init = () =>{
	Array.from(deleteBtns).forEach(e=>{
		e.addEventListener("click",deleteBtnHandler);
	})
}

if(deleteBtns != null){
	
	init();
}
