$(document).on('keypress', function(e) {
  var tag = e.target.tagName.toLowerCase();
  if (e.which === 13 && tag == 'textarea' && e.target.id == 'comment_body') {
    $(e.target).closest("form").submit();			
  }
});
