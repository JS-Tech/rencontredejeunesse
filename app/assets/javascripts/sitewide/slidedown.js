$(document).on("turbolinks:load", function() {

  // TODO
  $("#programme .guest").click(function() {
    var $personText = $(this).find(".text");
    if($personText.hasClass("active")) {
      $personText.css("height", 0).removeClass("active");
    } else {
      $(".text.active").css("height", 0).removeClass("active");
      $personText.animate({
        height: "270px"
      }, 500, function() {
        $personText.addClass("active");
      });
    }
  });
});