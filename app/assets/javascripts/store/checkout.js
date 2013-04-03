(function() {
  this.disableSaveOnClick = function() {
    return ($('form.edit_order')).submit(function() {
      return ($(this)).find(':submit, :image').attr('disabled', true).removeClass('primary').addClass('disabled');
    });
  };

  $(function() {
    var country_from_region, get_states, get_states_required, update_state;

    if (($('#checkout_form_payment')).is('*')) {
      ($('#checkout_form_payment')).validate();
      country_from_region = function(region) {
        return ($('p#' + region + 'country' + ' span#' + region + 'country-selection :only-child')).val();
      };
      get_states = function(region) {
        return state_mapper[country_from_region(region)];
      };
      get_states_required = function(region) {
        return states_required_mapper[country_from_region(region)];
      };
      update_state = function(region) {
        var selected, state_input, state_para, state_select, state_span_required, states, states_required, states_with_blank;

        states = get_states(region);
        states_required = get_states_required(region);
        state_para = $('p#' + region + 'state');
        state_select = state_para.find('select');
        state_input = state_para.find('input');
        state_span_required = state_para.find('state-required');
        if (states) {
          selected = parseInt(state_select.val());
          state_select.html('');
          states_with_blank = [['', '']].concat(states);
          $.each(states_with_blank, function(pos, id_nm) {
            var opt;

            opt = ($(document.createElement('option'))).attr('value', id_nm[0]).html(id_nm[1]);
            if (selected === id_nm[0]) {
              opt.prop('selected', true);
            }
            return state_select.append(opt);
          });
          state_select.prop('disabled', false).show();
          state_input.hide().prop('disabled', true);
          state_para.show();
          return state_span_required.show();
        } else {
          state_select.hide().prop('disabled', true);
          state_input.show();
          if (states_required) {
            state_span_required.show();
          } else {
            state_input.val('');
            state_span_required.hide();
          }
          state_para.toggle(!!states_required);
          return state_input.prop('disabled', !states_required);
        }
      };
      ($('p#bcountry select')).change(function() {
        return update_state('b');
      });
      ($('p#scountry select')).change(function() {
        return update_state('s');
      });
      update_state('b');
      update_state('s');
      ($('input#order_use_billing')).click(function() {
        if (($(this)).is(':checked')) {
          ($('#shipping .inner')).hide();
          return ($('#shipping .inner input, #shipping .inner select')).prop('disabled', true);
        } else {
          ($('#shipping .inner')).show();
          ($('#shipping .inner input, #shipping .inner select')).prop('disabled', false);
          if (get_states('s')) {
            return ($('span#sstate input')).hide().prop('disabled', true);
          } else {
            return ($('span#sstate select')).hide().prop('disabled', true);
          }
        }
      }).triggerHandler('click');
    }
    if (($('#checkout_form_payment')).is('*')) {
      ($('input[type="radio"][name="order[payments_attributes][][payment_method_id]"]')).click(function() {
        ($('#payment-methods li')).hide();
        if (this.checked) {
          return ($('#payment_method_' + this.value)).show();
        }
      });
      ($(document)).on('click', '#cvv_link', function(event) {
        var window_name, window_options;

        window_name = 'cvv_info';
        window_options = 'left=20,top=20,width=500,height=500,toolbar=0,resizable=0,scrollbars=1';
        window.open(($(this)).attr('href'), window_name, window_options);
        return event.preventDefault();
      });
      return ($('input[type="radio"]:checked')).click();
    }
  });

}).call(this);
