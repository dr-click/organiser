module Api
  class ApisController < Api::ApiApplicationController
    skip_before_action :authenticate_user
    authorize_resource :class => ApisController

    api :GET, '/apis', "Show Current API Version"
    example " 1.0.0 "
    def index
      render :json => "1.0.0"
    end

    api :GET, '/generate_secret', "Generate new secret code"
    description "Generate new secret code for a specific URI"
    param :uri, String, desc: "URL of generated secret", required: true
    param :user_id, String, desc: "User ID", required: false
    param :user_klass, String, desc: "User Class", required: false
    meta [call_example: "/api/generate_secret?uri=/api/apis", response: "{'secret':'123'}"]
    example " 'secret': {123} "
    formats ['json']
    def generate_secret
      uri = params[:uri] || ""
      user_id = params[:user_id] || ""
      user_klass = params[:user_klass] ? params[:user_klass].constantize || User : User
      render :json => {secret: Api::Authentication.generate_secret(uri, user_klass.where(id: user_id).first)}.to_json
    end
  end
end
