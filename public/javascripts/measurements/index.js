function wireUpAjaxPagination() {
  $('.pagination a').click(function(eventObject) {
    var href = $(eventObject.target).attr('href');
    $('.content').load(href, '', function(responseText, textStatus, xmlHttpRequest) {
      if (textStatus != 'success') return;
      wireUpAjaxPagination();
      var nextPage = $('a.next_page');
      (nextPage.length > 0) ? nextPage.focus() : $('a.prev_page').focus();
    });
    return false;
  });
}

$(document).ready(function() {
  wireUpAjaxPagination();
});
