class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user_signed_in?, :current_user, :is_admin?, :is_owner?

  protected

  def user_signed_in?
    !session[:username].nil?
  end

  def current_user
    session[:username]
  end

  def login_required
    unless user_signed_in?
      redirect_to signin_path, notice: 'You need to be logged in before accessing this page'
    end
  end

  def is_admin?
    unless session.has_key?(:is_admin)
      session[:is_admin] = Administrator.exists?(username: current_user)
    end
    session[:is_admin]
  end

  def is_owner?(device)
    current_user == device.owner
  end

  def admin_required
    unless is_admin?
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Only administrators can access this page' }
      end
    end
  end
end
