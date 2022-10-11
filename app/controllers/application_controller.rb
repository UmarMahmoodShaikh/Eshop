class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    # skip_before_action :verify_authenticity_token

    # def require_user 
    #     if (Redis.current.get("shopper_id") == nil && Redis.current.get("retailer_id") == nil  && Redis.current.get("company_id") == nil ) 
    #         flash[:alert] = 'You must be logged in to navigate'
    #         redirect_to '/'
    #     end
    # end

end
