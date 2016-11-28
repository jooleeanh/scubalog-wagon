var app = window.app = {};

app.Divesites = function() {
  this._input = $('#divesites-search-txt');
  this._initAutocomplete();
};

app.Divesites.prototype = {

_initAutocomplete: function() {
  this._input
    .autocomplete({
      source: '/divesites/search',
      appendTo: '#divesites-search-results',
      select: $.proxy(this._select, this)
    })
    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
},

_render: function(ul, item) {
  var markup = [
    '<span class="img">',
        '<img src="' + 'http://portalnacional.com.pt/images/empresas/8/3/0/0/9/83009.jpg' + '" />',
    '</span>',
    '<span class="name">' + item.name + '</span>',
    '<span class="latitude">' + 'Lat: ' + item.latitude + '</span>',
    '<span class="longitude">' + 'Lgn: ' + item.longitude + '</span>'
  ];
  return $('<li>')
    .append(markup.join(''))
    .appendTo(ul);
},

_select: function(e, ui) {
  this._input.val(ui.item.name);
  return false;
}
};
