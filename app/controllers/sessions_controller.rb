class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:index, :create]
  skip_before_action :require_user, only: [:index, :create]

  def index
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash[:error] = "There was something wrong with your login information"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to signin_path
  end

  private
  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end
end