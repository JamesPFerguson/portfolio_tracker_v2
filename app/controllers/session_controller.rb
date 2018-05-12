class SessionController < ApplicationController

  def new
     @user = User.new
   end

   def create
     if @user = User.find_by(name:params[:user][:name])
       if @user.authenticate(params[:password])
         session[:user_id] = @user.id
       else
         head(:forbidden)
       end
     elsif auth['uid']
       @user = User.find_or_create_by(uid: auth['uid']) do |u|
         u.name = auth['info']['name']
         u.email = auth['info']['email']
     else
       render 'new'
     end
      session[:user_id] = @user.id
      redirect_to portfolio_path(@user.portfolio)
   end

   def auth
     request.env['omniauth.auth']
   end

   def destroy
     session.delete("user_id")
     redirect_to root_path
   end

end
