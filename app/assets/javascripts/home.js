$(function(){
  $(".btn-banner").on("click", function(e){
    // On click, reveal form
    $('.form-login').removeClass('hidden');
    // and hide banner-content
    $('.banner-content').addClass('hidden');
  });
});

$(function(){
  $("#login").on("click", function(e){
    // On click, reveal form
    $('.form-signup').addClass('hidden');
    $('.form-login').removeClass('hidden');
    // and hide banner-content
    $('.banner-content').addClass('hidden');
  });
});

$(function(){
  $("#signup").on("click", function(e){
    // On click, reveal form
    $('.form-login').addClass('hidden');
    $('.form-signup').removeClass('hidden');
    // and hide banner-content
    $('.banner-content').addClass('hidden');
  });
});

// $(function(){
//   $(".banner-home").on("click", function(e){
//     // On click, hide form
//     $('.form-signup').addClass('hidden');
//     $('.form-login').addClass('hidden');
//     // and reveal banner-content
//     $('.banner-content').removeClass('hidden');
//   });
// });
