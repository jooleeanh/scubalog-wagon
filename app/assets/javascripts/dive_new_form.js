$(document).ready(function() {
  $('.dive-new-form-field input,select,textarea').focusin(function() {
    $(this).parents('.dive-input').toggleClass('log-active');
    $(this).parents('.dive-new-form-field').trigger("click");
  });

  $('.dive-new-form-field input,select,textarea').focusout(function() {
    $(this).parents('.dive-input').toggleClass('log-active');
  })
});
