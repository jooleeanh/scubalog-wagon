$.ajax({
    url: "/dives/show.html.erb",
    cache: false,
    success: function(html){
      $("#pageloader").append(html);
    }
});
