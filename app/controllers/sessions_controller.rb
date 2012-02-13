class SessionsController < ApplicationController

  def cardview
    session[:cardview] = params[:view] unless !params.has_key?(:view)
    render :nothing => true
  end

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
