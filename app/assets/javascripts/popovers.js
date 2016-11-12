$(document).ready(function(){
  $(".bottom-popover").popover({
    html: true,
    trigger: "hover",
    container: 'body',
    placement: "bottom"
  });
  $(".top-popover").popover({
    html: true,
    trigger: "hover",
    container: 'body',
    placement: "top"
  });
  $(".right-popover").popover({
    html: true,
    trigger: "hover",
    container: 'body',
    placement: "right"
  });
  $(".left-popover").popover({
    html: true,
    trigger: "hover",
    container: 'body',
    placement: "left"
  });
})
