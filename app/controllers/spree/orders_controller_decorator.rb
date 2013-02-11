Spree::OrdersController.class_eval do

  def edit
    @order = current_order(true)
    associate_user
    @order.bill_address ||= Spree::Address.default
    @order.ship_address ||= Spree::Address.default
    #before_delivery
    @order.payments.destroy_all if request.put?
  end

  # change this to alias / spree
  def object_params
    if params[:payment_source].present? && source_params = params.delete(:payment_source)[params[:order][:payments_attributes].first[:payment_method_id].underscore]
      params[:order][:payments_attributes].first[:source_attributes] = source_params
    end
    if (params[:order][:payments_attributes])
      params[:order][:payments_attributes].first[:amount] = @order.total
    end
    params[:order]
  end

  private
    def before_delivery
      return if params[:order].present?
      @order.shipping_method ||= (@order.rate_hash.first && @order.rate_hash.first[:shipping_method])
    end

end
