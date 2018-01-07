module Api
  class ApiApplicationController < ::ActionController::Base
    #Set null_session for API calls
    protect_from_forgery with: :null_session
    #Load current user for each API call using the token and the secret
    before_action :load_current_user

    #Authenticate the user using the secret and the token
    before_action :authenticate_user

    #return current_user from the instance variable
    def current_user
      @current_user
    end

    #########
    protected
    #########

    #Each API call should be sent with secret and user token
    def load_current_user
      @current_user = Api::Authentication.is_valid_token_and_secret?(params[:token], params[:secret], request.path, User) unless params[:token].blank?
    end

    def authenticate_user
      if (params[:token].blank? && !Api::Authentication.is_valid_secret?(params[:secret], request.path)) || (!params[:token].blank? && !current_user)
          render :json=> { :error => "Invalid Token" }, :status=>:unauthorized and return false
      end
    end
  end
end
