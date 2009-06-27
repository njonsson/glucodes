function wireUpAjaxPagination() {
  $('.pagination a').each(function(i, el) {
    el = $(el);
    var href = el.attr('href');
    el.click(function() {
      $('.content').load(href, '', function(responseText, textStatus, xmlHttpRequest) {
        if (textStatus != 'success') return;
        wireUpAjaxPagination();
        autofocus();
      });
      return false;
    });
  }).attr('href', '#');
}

$(document).ready(function() {
  wireUpAjaxPagination();
});
