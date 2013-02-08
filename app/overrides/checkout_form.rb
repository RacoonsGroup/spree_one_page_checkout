Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :insert_after => "[data-hook = 'outside_cart_form']",
                     :partial => "spree/orders/checkout_form",
                     :name => "checkout_form",
                     :original => '0b5774f437a257c218490c5846dafd63ea5909a1')
