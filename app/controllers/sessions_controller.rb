class SessionsController < ApplicationController

  def new
     @user = User.new
   end

   def create

     if auth

       @user = User.find_or_create_by(uid: auth['uid']) do |u|
         u.name = auth['info']['name']
         u.email = auth['info']['email']
       end

       session[:user_id] = @user.id

     elsif @user = User.find_by(name: params[:user][:name])

       if @user.authenticate(params[:password])
         session[:user_id] = @user.id
         redirect_to portfolio_path(@user.portfolio)
       else
         if !@user.authenticate(params: [:password])
           flash[:notice] = "password is incorrect"
          end
         render 'new'
       end

     elsif !@user
         flash[:notice] = "Username not found"
         render 'new'
       end
     else
       session[:user_id] = @user.id
       redirect_to portfolio_path(@user.portfolio)
     else
       render 'new'
     end

   end

   def auth
     request.env['omniauth.auth']
   end

   def destroy
     session.delete("user_id")
     redirect_to root_path
   end

end
