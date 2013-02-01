Spree::Order.class_eval do

  attr_accessible :state, :completed_at

  def run_states
    ActiveRecord::Base.transaction do
      update!
      finalize!
      create_shipment!
      adjustments.each do |adj|
        adj.update!
      end
     update_attributes(:state => 'complete', :completed_at => Time.now)
   end
  end
end