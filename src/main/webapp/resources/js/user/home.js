const menuOpenBtn = document.querySelector(".header_menu_btn");
const menuCloseBtn = document.querySelector(".menu_title>i");
const menuContainer = document.querySelector(".menu_container");
const communityBtn = document.querySelector(".communityBtn");
const hideBtn = document.querySelector(".menu_coummunity_inner_el");



const openMenuHandler = () =>{
    menuContainer.classList.remove("transfrom");
}

const clostMenuHandler = () =>{
    menuContainer.classList.add("transfrom");
}

const openInnerMenuHandler = () =>{
    hideBtn.classList.remove("display_none");
    communityBtn.removeEventListener("click",openInnerMenuHandler);
    communityBtn.addEventListener("click",closeInnerMenuHandler);
}

const closeInnerMenuHandler = () =>{
    hideBtn.classList.add("display_none");
    communityBtn.removeEventListener("click",closeInnerMenuHandler);
    communityBtn.addEventListener("click",openInnerMenuHandler);
}

const init = () =>{
    menuOpenBtn.addEventListener("click",openMenuHandler)
    menuCloseBtn.addEventListener("click",clostMenuHandler)
    communityBtn.addEventListener("click",openInnerMenuHandler)
}

if(menuContainer!= null){
    init();
}