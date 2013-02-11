$ ->
  if ($ '#checkout_form_address').is('*')
    ($ 'input[type="radio"][name="order[payments_attributes][][payment_method_id]"]').click(->
      ($ '#payment-methods li').hide()
      ($ '#payment_method_' + @value).show() if @checked
    )


    ($ '#cvv_link').live('click', (event) ->
      window_name = 'cvv_info'
      window_options = 'left=20,top=20,width=500,height=500,toolbar=0,resizable=0,scrollbars=1'
      window.open(($ this).attr('href'), window_name, window_options)
      event.preventDefault()
    )

    # Activate already checked payment method if form is re-rendered
    # i.e. if user enters invalid data
    ($ 'input[type="radio"]:checked').click()