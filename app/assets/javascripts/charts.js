$(function(){
  $(".chart:first-child").addClass('active');

  $(".chart").on("click", function(e){
    // Hide content
    var tagBye = $('.charts .active').data('target');
    $(tagBye).toggleClass('hidden')
    // Toggle old chart to inactive
    $('.charts .active').toggleClass('active');
    // Toggle new chart to active
    $(this).toggleClass('active');
    // Show content
    var tagHello = $('.charts .active').data('target');
    $(tagHello).toggleClass('hidden')
  });
})
