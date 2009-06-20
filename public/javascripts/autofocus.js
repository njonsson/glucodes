// Activates (focuses and selects) the appropriate focusable element on a page,
// either an element having the 'autofocus' CSS class or the first control
// encountered, or the first link encountered.
function autofocus() {
  var selectors = ['.autofocus', ':input[type!="hidden"]', 'a[href]'];
  for (var s in selectors) {
    var el = $(selectors[s]);
    if (el.length > 0) {
      $(el.get(0)).focus().select();
      return;
    }
  };
}

$(document).ready(function() {
  autofocus();
});
