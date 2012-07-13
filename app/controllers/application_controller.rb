class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_signed_in?, :current_user

  protected

  def user_signed_in?
    !session[:username].nil?
  end

  def current_user
    session[:username]
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:warning] = 'You need to be logged in before accessing this page'
      redirect_to signin_path
    end
  end
end
