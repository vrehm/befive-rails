$(function(){
  $(".list-card-s").on("click", function(){
    // Change active list-card
    $('.list-card-s').removeClass('list-active');
    $(this).addClass('list-active');
    // Hide all events_list(use class="hidden")
    $('.events_list').addClass('hidden');
    // Show target events_list (use class="hidden")
    $($(this).data("target")).removeClass('hidden');
  });
});
