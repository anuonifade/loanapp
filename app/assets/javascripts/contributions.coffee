# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $('.add-comma').divide()
  $( ".select2" ).select2({
    theme: "bootstrap"
  });
  contribution()

  $('#contribution_start_month, #contribution_start_year').change ->
    contribution()

  $('#amount').blur ->
    contribution()

number_to_thousand = (number) ->
  return parseInt(number).toLocaleString('en')


contribution = () ->
  amount = parseInt($('#amount').val()) || 0

  if amount isnt 0 and amount isnt NaN
    $('#contribution-amount').val(amount)