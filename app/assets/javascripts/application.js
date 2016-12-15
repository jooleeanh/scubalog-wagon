//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-fileupload/basic
//= require swipebox
//= require chartkick
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require zoomooz/jquery.zoomooz.js
//= require_tree .

$(document).ready(function() {
  if (window.location.hash == '#_=_'){
    history.replaceState
        ? history.replaceState(null, null, window.location.href.split('#')[0])
        : window.location.hash = '';
}
});
