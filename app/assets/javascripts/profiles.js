// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {

  $('#passport-file').on('change', function() {
    var files = !!this.files ? this.files : [];
    if (!files.length || !window.FileReader) {
      $("img#rounded-circle").attr('src', 'https://opennebula.org/wp-content/uploads/2017/01/placeholder.jpg')
      $('div#upload-message').html('<div class="alert alert-danger" role="alert">You did not upload any image</div>');
      return;
    }
    var ReaderObj = new FileReader(); // Create instance of the FileReader
    ReaderObj.readAsDataURL(files[0]); // read the file uploaded
    ReaderObj.onloadend = function(e){ // set uploaded image data as background of div
      $("img#rounded-circle").attr('src', e.target.result);
    }
  });
});