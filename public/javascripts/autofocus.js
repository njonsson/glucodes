// Activates (focuses and selects) the appropriate control on a page, either a
// control having the 'autofocus' CSS class or otherwise the first control
// encountered.
$(document).ready(function() {
  $($('.autofocus, :input[type!="hidden"]').get(0)).focus().select();
});
