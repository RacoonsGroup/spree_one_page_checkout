Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :insert_after => "[data-hook = 'outside_cart_form']",
                     :partial => "spree/orders/checkout_form",
                     :name => "checkout_form")
