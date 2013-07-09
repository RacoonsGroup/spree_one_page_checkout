Spree::UserSessionsController.class_eval do

  def create
    authenticate_spree_user!

    if spree_user_signed_in?
      respond_to do |format|
        format.html {
          flash[:success] = t(:logged_in_succesfully)
          redirect_to cart_path
        }
        format.js {
          user = resource.record
          render :json => {:ship_address => user.ship_address, :bill_address => user.bill_address}.to_json
        }
      end
    else
      flash.now[:error] = t('devise.failure.invalid')
      render :new
    end
  end

end
