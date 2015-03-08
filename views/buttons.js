var prevButtonElement = document.getElementById("prev_button");
var nextButtonElement = document.getElementById("next_button");
var slideTitle = document.getElementById("slide_title");
var slideBody = document.getElementById("slide_body");
var slideStack = document.forms["hidden"]["current_stack"];
var xhr = new XMLHttpRequest();
var ip = "http://localhost:4567/";

prevButtonElement.addEventListener("click","showPrevSlide");
nextButtonElement.addEventListener("click","showNextSlide");

function openSend(method, path){
  xhr.open(method, ip + path);
  xhr.send();
}

var showPrevSlide = function(event){
  openSend("get","next/" + slideStack.value);
  var slideObject = JSON.parse(xhr.repsonse);
  slideTitle.innerHTML = slide.title;
  slideBody.innerHTML = slide.body;
  slideStack.value = slide.stack;
}
