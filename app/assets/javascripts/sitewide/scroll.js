$(document).on("turbolinks:load", function() {

  var closeBtn = document.getElementById("close-header");
  var headerBtn = document.getElementById("header-btn");
  var headerFrame = document.getElementById("header-frame");

  var hideHeader = function() {
    headerFrame.style.display = "none";
  }

  headerBtn.onclick = function() {
    headerFrame.style.display = "block";
  }

  closeBtn.onclick = hideHeader;

  gumshoe.init({
    callback: hideHeader
  });

  // Fixed burger menu
  var $burgerMenu = $("#logo-burger").find("#header-btn");
  var burgerVisible = false;
  $(window).scroll(function() {
    var scroll = $(window).scrollTop();
    if(!burgerVisible && scroll > 500) {
      $burgerMenu.addClass("keep");
      burgerVisible = true;
    }
    if(burgerVisible && scroll < 500) {
      $burgerMenu.removeClass("keep");
      burgerVisible = false;
    }
  });

});
