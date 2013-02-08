Spree::Order.class_eval do

  # monkey patch for the first time
  def available_shipping_methods(display_on = nil)
    Spree::ShippingMethod.all
  end

  def run_states
    ActiveRecord::Base.transaction do
      update!
      finalize!
      create_shipment!
      adjustments.each do |adj|
        adj.update!
      end
    end
  end

end
