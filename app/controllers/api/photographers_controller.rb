module Api
  class PhotographersController < UsersController
    authorize_resource

    api :GET, '/photographers', "List all photographers in the system"
    description "List all photographers in the system, Order by 'created_at DESC', It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /api/photographers with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    example 'Request_URL: /api/photographers?secret=???&token=???'
    example 'Response_success: {"success":true,"users":[{"id":2,"name":"abcef","email":"abc@def.gh","token":"123"}]}'
    def index
      @user_klass = Photographer
      super
    end


    api :GET, '/photographers/:id', "Show a photographer details"
    description "Show a photographer details, It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /api/photographers/5 with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    example 'Request_URL: /api/photographers/5?secret=???&token=???'
    example 'Response_success: {"success":true,"user":{"id":2,"name":"abcef","email":"abc@def.gh","token":"123"}}'
    def show
      @user_klass = Photographer
      super
    end


    api :POST, '/photographers', "Create new photographer"
    description "Create a new photographer, It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /api/photographers with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    param "photographer['email']", String, :desc => "photographer email", :required => true
    param "photographer['name']", String, :desc => "photographer name", :required => false
    param "photographer['password']", String, :desc => "photographer login password", :required => true
    param "photographer['password_confirmation']", String, :desc => "photographer login password_confirmation", :required => true
    example 'Response_success: {"success":true,"user":{"id":2,"name":"abcef","email":"abc@def.gh","token":"123"}}'
    example 'Response_failure: {"success":false,"errors": {"email": ["cant be blank"]}}'
    def create
      @user_klass = Photographer
      super
    end


    api :PATCH, '/photographers/:id', "Update photographer attributes"
    description "Update a photographer details, It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /api/photographers/5 with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    param "photographer['email']", String, :desc => "photographer email", :required => false
    param "photographer['name']", String, :desc => "photographer name", :required => false
    example 'Response_success: {"success":true,"user":{"id":2,"name":"abcef","email":"abc@def.gh","token":"123"}}'
    example 'Response_failure: {"success":false,"errors": {"email": ["invalid email"]}}'
    def update
      @user_klass = Photographer
      super
    end


    api :delete, '/photographers/:id', "Delete a photographer"
    description "Delete a photographer details, It requires organiser user"
    param :secret, String, :desc => "Generated secret for the url /api/photographers/5 with Organiser user token", :required => true
    param :token, String, :desc => "Organiser user token", :required => true
    example 'Response_success: {"success":true}'
    example 'Response_failure: {"success":false,"errors": {"error": ["error message"]}}'
    def destroy
      @user_klass = Photographer
      super
    end


    #######
    private
    #######

    def user_params
      params.require(:photographer).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
