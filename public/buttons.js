var prevButtonElement = document.getElementById("prev_button");
var nextButtonElement = document.getElementById("next_button");
var slideTitle = document.getElementById("slide_title");
var slideBody = document.getElementById("slide_body");
var slideStack = document.forms["hider"]["current_stack"];
var xhr = new XMLHttpRequest();
var ip = "http://localhost:4567/";

prevButtonElement.addEventListener("click", showPrevSlide);
nextButtonElement.addEventListener("click", showNextSlide);
xhr.addEventListener("load", changeSlide);

function openSend(method, path){
  xhr.open(method, ip + path);
  xhr.send();
}

var showPrevSlide = function(event){
  openSend("get","prev/" + slideStack.value);
}

var showNextSlide = function(event){
  openSend("get","next/" + slideStack.value);
}

function changeSlide(){
  var slideObject = JSON.parse(xhr.response);
  slideTitle.innerHTML = slideObject.title;
  slideBody.innerHTML = slideObject.body;
  slideStack.value = slideObject.stack;
}