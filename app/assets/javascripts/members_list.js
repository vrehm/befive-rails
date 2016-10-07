// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $(".list-card-m").on("click", function(){
    // Change active list-card
    $('.list-card-m').removeClass('list-active');
    $(this).addClass('list-active');
    // Hide all events_list(use class="hidden")
    $('.team_member_infos').addClass('hidden');
    // Show target events_list (use class="hidden")
    $($(this).data("target")).removeClass('hidden');
  });
});
