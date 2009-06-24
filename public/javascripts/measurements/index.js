function wireUpAjaxPagination() {
  $('.pagination a').each(function(i, el) {
    el = $(el);
    var href = el.attr('href');
    el.click(function() {
      $('.content').load(href, '', function(responseText, textStatus, xmlHttpRequest) {
        if (textStatus != 'success') return;
        wireUpAjaxPagination();
        var nextPage = $('a.next_page');
        (nextPage.length > 0) ? nextPage.focus() : $('a.prev_page').focus();
      });
      return false;
    });
  }).attr('href', '#');
}

$(document).ready(function() {
  wireUpAjaxPagination();
});
