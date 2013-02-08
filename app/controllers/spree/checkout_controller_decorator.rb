Spree::CheckoutController.class_eval do

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

  def update
    if @order.update_attributes(object_params)
      @order.run_states
      fire_event('spree.checkout.update')
      flash.notice = t(:order_processed_successfully)
      flash[:commerce_tracking] = "nothing special"
      respond_with(@order, :location => completion_route)
    else
      respond_with(@order) { |format| format.html { render :edit } }
    end
  end
end
