# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  $('.add-comma').divide()
  $( ".select2" ).select2({
    theme: "bootstrap"
  });
  calculate_loan()

  $('#loan_type,
    #loan_duration,
    #loan_yearly_deduction,
    #guarantor_one_id,
    #guarantor_two_id,
    input:checkbox').change ->
    calculate_loan()

  $('#amount').blur ->
    calculate_loan()

number_to_thousand = (number) ->
  return parseInt(number).toLocaleString('en')


calculate_loan = ->
  # Hide informational fields
  $('#total-payment-block').hide()
  $('#monthly-payment-block').hide()
  $('#yearly-payment-block').hide()
  $('#loan-button').prop('disabled', true)

  # Set default values
  savings = '1'
  housing = '2'
  cooperative = '3'
  interest = 1
  maximum_months = 10 * 12
  maximum_loan = 0
  total_contribution = parseInt($('#total_contribution').val())

  # Get values of fields from form
  loan_type = $('#loan_type').val()
  amount = parseInt($('#amount').val()) || 0
  duration = parseInt($('#loan_duration').val()) || 0

  if loan_type is housing
    duration = parseInt($('#loan_yearly_deduction').val()) || 0
    $('#loan_yearly_deduction').show()
    $('#loan_duration').hide()
  else
    $('#loan_yearly_deduction').hide()
    $('#loan_duration').show()

  # Configure interest & maximum months based on loan_type
  if loan_type is savings
    interest = 10
    maximum_months = 3 * 12
    maximum_loan = 2000000
  else if loan_type is housing
    interest = 17
  else if loan_type is cooperative
    interest = 6.5
    maximum_months = 3 * 12
    maximum_loan = total_contribution * 2
  else
    return false

  # Check if the maximum loan is exceeded
  if amount > maximum_loan and loan_type isnt "" and loan_type isnt housing
    $('#amount').val()
    toastr.error('Your maximum loan is ' + number_to_thousand(maximum_loan), 'Error!')
    return false

  # Check if the user selected valid guarantors
  guarantor_one = $('#guarantor_one_id').val() || 0
  guarantor_two = $('#guarantor_two_id').val() || 0
  
  total_payment = Math.ceil(amount + (amount * interest / 100))

  if amount isnt 0 and loan_type isnt ""
    $('#total-payment-word').text(numberToEnglish(total_payment) + ' Naira')
    $('#total-payment').text(number_to_thousand(total_payment))
    $('#total-payment-block').show()
    $('#loan-amount').val(amount)

    if duration isnt 0
      monthly_payment = Math.ceil(total_payment / duration)

      if loan_type is housing
        monthly_payment = Math.ceil((total_payment - amount) / duration)
        yearly_payment = Math.ceil((amount / duration) * 12)
        $('#yearly-payment').text(number_to_thousand(yearly_payment))
        $('#yearly-payment-word').text(numberToEnglish(yearly_payment) + ' Naira per year')
        $('#yearly-payment-block').show()

      $('#monthly-payment-word').text(numberToEnglish(monthly_payment) + ' Naira per month')
      $('#monthly-payment').text(number_to_thousand(monthly_payment))
      $('#monthly-payment-block').show()

    if guarantor_one == guarantor_two and guarantor_one != 0 and guarantor_two != 0
      toastr.error("You cannot select the same guarantor twice", "Error!")
      return false

    if ($("#loan-agreement").is(':checked'))
      $('#loan-button').prop('disabled', false)
    else
      $('#loan-button').prop('disabled', true)
