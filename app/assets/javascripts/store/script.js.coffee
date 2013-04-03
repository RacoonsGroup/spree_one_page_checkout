$ ->
  if ($ '#checkout_form_payment').is('*')
    ($ 'input[type="radio"][name="order[payments_attributes][][payment_method_id]"]').click(->
      ($ '#payment-methods li').hide()
      ($ '#payment_method_' + @value).show() if @checked
    )


    ($ '#cvv_link').on('click', (event) ->
      window_name = 'cvv_info'
      window_options = 'left=20,top=20,width=500,height=500,toolbar=0,resizable=0,scrollbars=1'
      window.open(($ this).attr('href'), window_name, window_options)
      event.preventDefault()
    )

    # Activate already checked payment method if form is re-rendered
    # i.e. if user enters invalid data
    ($ 'input[type="radio"]:checked').click()

    ($ 'input#order_use_billing').click(->
      if ($ this).is(':checked')
        ($ 'input[type="submit"][value="Checkout"][data-hook="one_page_checout_button"]').css("margin-left", "10px")
        ($ '#shipping_method_wrapper').removeClass('alpha')
        ($ '#shipping_method_wrapper').addClass('omega')
      else
        ($ 'input[type="submit"][value="Checkout"][data-hook="one_page_checout_button"]').css("margin-left", "0")
        ($ '#shipping_method_wrapper').removeClass('omega')
        ($ '#shipping_method_wrapper').addClass('alpha')
    ).triggerHandler 'click'
    # deface cannot did it
    ($ 'button#checkout-link').remove()

    fetch_available_shipping_methods = (country, state) ->
      $.ajax
        type: 'POST'
        dataType: 'json'
        url: $('#shipping_method').data('url')
        data: {country_id : country, state : state}
        beforeSend: ( jqXHR ) ->
          $('#methods').html '<center><img src="assets/spinner.gif" alt="loading..." class="one-page-checkout-loader"></center>'
        success: (data) ->
          if data? && data.length
            $('#methods').html JST["store/templates/shipping_methods"](data: data)
          else
            $('#methods').html "<center><p class='info'> #{$('#shipping_method').data('not-delivery')} </p></center>"

    $('#check-shipping-methods').click(->
      if $('input#order_use_billing').is(':checked')
        if $('#order_bill_address_attributes_state_name').css('display') == 'none' && $('#order_bill_address_attributes_state_id').css('display') == 'none' || $('#order_bill_address_attributes_state_name').css('display') != 'none' && $('#order_bill_address_attributes_state_id').css('display') != 'none'
          return false
        if $('input#order_bill_address_attributes_state_name').css('display') == 'none'
          fetch_available_shipping_methods($('#order_bill_address_attributes_country_id').val(), $('#order_bill_address_attributes_state_id').val())
        if $('#order_bill_address_attributes_state_id').css('display') == 'none'
          fetch_available_shipping_methods($('#order_bill_address_attributes_country_id').val(), $('#order_bill_address_attributes_state_name').val())
    ).triggerHandler 'click'
