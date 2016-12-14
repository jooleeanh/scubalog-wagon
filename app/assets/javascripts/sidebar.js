$(document).ready(function() {
  $('#close-menu').click(function(){
    $('#sidebar').addClass('closed');
  });

  $('#open-menu').click(function(){
    $('#sidebar').toggleClass('closed');
  });
})
