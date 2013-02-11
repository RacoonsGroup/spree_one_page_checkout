Spree::Order.class_eval do

  checkout_flow do
    go_to_state :address
    go_to_state :delivery
    go_to_state :payment, :if => lambda { |order| order.payment_required? }
    go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
    go_to_state :complete, :if => lambda { |order| (order.payment_required? && order.payments.exists?) || !order.payment_required? }
    remove_transition :from => :delivery, :to => :confirm
  end

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
