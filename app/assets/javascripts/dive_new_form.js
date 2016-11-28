$(document).ready(function() {
  $('.dive-new-form-field input,select,textarea').focusin(function() {
    $(this).parents('.dive-new-form-field').toggleClass('log-active');
  })
  $('.dive-new-form-field input,select,textarea').focusout(function() {
    $(this).parents('.dive-new-form-field').toggleClass('log-active');
  })
});
