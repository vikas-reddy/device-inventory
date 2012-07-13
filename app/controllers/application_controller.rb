class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_signed_in?, :current_user, :is_admin?

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

  def is_admin?
    unless session.has_key?(:is_admin)
      session[:is_admin] = Administrator.exists?(username: current_user)
    end
    session[:is_admin]
  end

  def admin_required
    unless is_admin?
      flash.now[:error] = 'Only administrators can access this page'
      redirect_to root_path
    end
  end
end
