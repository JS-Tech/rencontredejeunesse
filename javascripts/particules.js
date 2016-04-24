$(document).ready(function(){
  $("body").append("<img class='particule' src='images/p1.png'>");
  $(".particule").each(function(){
    animateParticule($(this));
  });

function makeNewPosition() {
  var h = $(window).height() - 50;
  var w = $(window).width() - 50;

  var nh = Math.floor(Math.random() * h);
  var nw = Math.floor(Math.random() * w);

  return [100,100];
}

function animateParticule(p) {
  var newq = makeNewPosition();
  $(p).animate({
    top: newq[0],
    left: newq[1]
  }, function() {
    animateParticule(p);
  });
}

});
