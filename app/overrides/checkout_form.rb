Deface::Override.new(:virtual_path => "spree/order/edit",
                     :replace => "[data-hook => 'checkout_form_wrapper']",
                     :partial => "spree/order/_checkout_form",
                     :name => "checkout_form")
