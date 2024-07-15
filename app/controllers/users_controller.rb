class UsersController < ApplicationController
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
         session[:user_id] = user.id
         flash[:success] = "Welcome, #{user.name}!"
         redirect_to user_path(user.id)
      else
         flash[:error] = "Incorrect Credentials"
         redirect_to login_path
      end
   end

private

   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

end