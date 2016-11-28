$(document).ready(function() {
  $('.dive-new-form-field input,select,textarea').focusin(function() {
    $(this).parents('.dive-new-form-field').toggleClass('log-active');
    $(this).parents('.dive-new-form-field').trigger("click");
    // TODO:  Simulate click on next input to zoom to next.
  });

  $('.dive-new-form-field input,select,textarea').focusout(function() {
    $(this).parents('.dive-new-form-field').toggleClass('log-active');
  })
});
