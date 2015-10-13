class UsersController < ApplicationController


  def signup
    if request.post?
      logger.info params[:password]
      @user = User.new
      @user.name= params[:username]
      @user.password_digest= User.hash_password params[:password][:pwd]
      @user.email=params[:email]
      if @user.save
        flash[:notice] = "Succussfully Signed Up!"
        redirect_to :login
      else
        flash[:error] = "Duplicate Name!"
      end
    end
  end

  def login
    if request.post?
      name = params[:username]
      @user = User.find_by_name(name)
      if @user
        if @user.password_digest == User.hash_password(params[:password][:pwd])
          flash[:notice] = "Successfully Logged in!"
          session[:user_id] = @user.id
          redirect_to :root
        else
          flash[:error] = "Incorrect password!"
        end
      else
        flash[:error] = "No Such User!"
      end
    end
  end

  def logout
    reset_session
    redirect_to :root
  end

end
