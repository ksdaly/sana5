$(function() {
  $('.edit_user_to_do input[type=submit]').remove();
  $('.edit_user_to_do input[type=checkbox]').click(function(){
    $(this).parent('form').submit();
  });
});

