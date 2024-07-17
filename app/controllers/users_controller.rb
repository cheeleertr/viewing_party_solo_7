class UsersController < ApplicationController
   before_action :require_user, only: :show
   before_action :authorize_user, only: :show

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
      @invited_parties = @user.invited_parties
      @hosted_parties = @user.hosted_parties
   end

   def create
      user = User.new(user_params)
      if user.save
         session[:user_id] = user.id
         flash[:success] = "Welcome, #{user.name}!"
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end
   end

   def login_form
   end

   def login
      user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
         unless cookies[:location]
            cookies[:location] = params[:location]
         end
         session[:user_id] = user.id
         flash[:success] = "Welcome, #{user.name}!"
         redirect_to user_path(user.id)
      else
         flash[:error] = "Incorrect Credentials"
         redirect_to login_path
      end
   end

   def logout
      session[:user_id] = nil
      redirect_to root_path, notice: "Logged out successfully."
   end

private

   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

   def require_user
      if !current_user
        flash[:error] = "You Must Be Logged In"
        redirect_to root_path
      end
   end

   def authorize_user
      if current_user != User.find(params[:id])
        flash[:error] = "You Cannot View This User's Dashboard"
        redirect_to root_path
      end
    end
end