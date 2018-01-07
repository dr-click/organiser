module Api
  class UsersController < ApiApplicationController

    def index
      @user_klass ||= User
      users = @user_klass.all.order("created_at desc")
      render :json => { success: true, users: users.as_json }, :status => 200
    end

    def show
      @user_klass ||= User
      user = @user_klass.find(params[:id])
      render :json => { success: true, user: user.as_json }, :status => 200
    end

    def create
      @user_klass ||= User
      user = @user_klass.new(user_params)

      if user.save
        render :json => { success: true, user: user.as_json }, :status => 200
      else
        render :json => { success: false, errors: user.errors }, :status => 200
      end
    end

    def update
      @user_klass ||= User
      user = @user_klass.find(params[:id])
      if user.update(user_params)
        render :json => { success: true, user: user.as_json }, :status => 200
      else
        render :json => { success: false, errors: user.errors }, :status => 200
      end
    end

    def destroy
      @user_klass ||= User
      user = @user_klass.find(params[:id])

      if user.destroy
        render :json => { success: true }, :status => 200
      else
        render :json => { success: false, errors: user.errors }, :status => 200
      end
    end
  end
end
