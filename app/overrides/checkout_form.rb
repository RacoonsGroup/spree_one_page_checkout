Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :insert_after => "[data-hook = 'outside_cart_form']",
                     :partial => "spree/orders/checkout_form",
                     :name => "checkout_form",
                     :original => '0b5774f437a257c218490c5846dafd63ea5909a1')
Deface::Override.new(:virtual_path => "spree/orders/edit",
                     :replace => "[data-hook = 'cart_items']",
                     :text => '<%= render :partial => "spree/orders/form", :locals => { :order_form => order_form } %>',
                     :name => "rename_cart_form",
                     :original => '236cabe9d54396b4f9e90830f2274f349a2814aa')
Deface::Override.new(:virtual_path => "spree/orders/_form",
                     :replace => "tbody#line_items",
                     :partial => "spree/orders/line_items_fix",
                     :name => "rename_line_items_form")

