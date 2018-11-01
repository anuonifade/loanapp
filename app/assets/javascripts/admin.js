// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on ('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip();

  const users = new FormData();

  $('#users-csv-file').on('change', function(e) {
    users.append('file', e.target.files[0], e.target.files[0].name);
  });

  $('#upload-users').on('click', function(e){
    e.preventDefault();
    $.ajaxSetup({
      headers: {
        'X-CSRF-TOKEN': $('meta[name="token"]').attr('value')
      }
    });
    $.ajax({
      method: 'POST',
      url: 'upload-users',
      processData: false,
      contentType: false,
      data: users,
      success: function(response) {
        console.log('uploaded');
      }
    })
    
    return false;
  });
})
  


