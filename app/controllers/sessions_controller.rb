class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
     @user = User.new
   end

   def create
     if auth

       @user = User.find_or_create_by(uid: auth['uid']) do |u|
         u.name = auth['info']['nickname']
         u.email = auth['info']['email']
       end
       @user.save(validate: false)

     elsif @user = User.find_by(name: params[:user][:name])

       if !@user.authenticate(params[:user][:password])
         flash[:notice] = "Password is incorrect"
         render 'new'
         return
       end
     elsif !@user
         flash[:notice] = "Username not found"
     else
        render 'new'
     end

     session[:user_id] = @user.id
     if !@user.portfolio
       @user.portfolio = Portfolio.new
     end
     redirect_to portfolio_path(@user.portfolio)

   end

   def auth
     request.env['omniauth.auth']
   end

   def destroy
     session.delete("user_id")
     redirect_to home_path
   end

end
