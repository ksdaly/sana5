$(function() {
  $('.edit_user_to_do input[type=submit]').remove();
  $('input[type=checkbox]').click(function(){
    $(this).parent('.user_to_do_completed').parent('form').submit();
  });
});

