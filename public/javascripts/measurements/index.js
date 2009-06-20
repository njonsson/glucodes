$(document).ready(function() {
  $('.pagination a').live('click', function(eventObject) {
    var href = $(eventObject.target).attr('href');
    $('.data').load(href + ' .data', '', function() {
      var nextPage = $('a.next_page');
      (nextPage.length > 0) ? nextPage.focus() : $('a.prev_page').focus();
    });
    return false;
  });
});
