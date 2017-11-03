# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $('.add-comma').divide()
  $('#total-payment-block').hide()
  $('#monthly-payment-block').hide()

  $('#loan_type').change ->
    calculate_loan()

  $('#amount').blur ->
    calculate_loan()

  $('#duration').change ->
    calculate_loan()

number_to_thousand = (number) ->
  return parseInt(number).toLocaleString('en')


calculate_loan = ->
  $('#total-payment-block').hide()
  $('#monthly-payment-block').hide()
  loan_type = $('#loan_type').val()
  interest = 1
  maximum_months = 10 * 12
  maximum_loan = 0
  total_contribution = parseInt($('#total_contribution').val())
  if loan_type is 'savings'
    interest = 10
    maximum_months = 3 * 12
    maximum_loan = 2000000
    $('#duration-block').show()
  else if loan_type is 'housing'
    interest = 17
    $('#duration-block').hide()
  else if loan_type is 'normal'
    interest = 6.5
    maximum_months = 3 * 12
    maximum_loan = total_contribution * 2
    $('#duration-block').show()

  amount = parseInt($('#amount').val()) || 0
  duration = parseInt($('#duration').val()) || 0
  total_payment = amount + (amount * interest / 100)

  if amount isnt 0 and loan_type isnt ""
    $('#total-payment-word').text(numberToEnglish(total_payment) + ' Naira')
    $('#total-payment').text(number_to_thousand(total_payment))
    $('#total-payment-block').show()

    if duration isnt 0 and loan_type isnt 'housing'
      monthly_payment = parseInt(total_payment / duration)
      $('#monthly-payment-word').text(numberToEnglish(monthly_payment) + ' Naira per month')
      $('#monthly-payment').text(number_to_thousand(monthly_payment))
      $('#monthly-payment-block').show()
