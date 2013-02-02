Spree::Order.class_eval do

  attr_accessible :state, :completed_at

  checkout_flow do
    go_to_state :finish
  end

  def available_shipping_methods(display_on = nil)
    Spree::ShippingMethod.all
  end

  def finalize!
    update_attribute(:completed_at, Time.now)
    Spree::InventoryUnit.assign_opening_inventory(self)
    # lock any optional adjustments (coupon promotions, etc.)
    adjustments.optional.each { |adjustment| adjustment.update_attribute('locked', true) }
    deliver_order_confirmation_email

    self.state_changes.create({
      :previous_state => 'cart',
      :next_state     => 'complete',
      :name           => 'order' ,
      :user_id        => (Spree::User.respond_to?(:current) && Spree::User.current.try(:id)) || self.user_id
    }, :without_protection => true)
  end

end
