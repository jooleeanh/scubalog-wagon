$(function(){

  $(".tab").on("click", function(e){
    // Hide content
    var tagBye = $('.tabs .active').data('target');
    $(tagBye).toggleClass('hidden')
    // Toggle old tab to inactive
    $('.tabs .active').toggleClass('active');
    // Toggle new tab to active
    $(this).toggleClass('active');
    // Show content
    var tagHello = $('.tabs .active').data('target');
    $(tagHello).toggleClass('hidden')
  });
})
