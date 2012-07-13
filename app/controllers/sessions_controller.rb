class SessionsController < ApplicationController

  # GET /sign_in
  def new
  end

  # POST /sign_in
  def create
    if PramatiLdap::authenticate(params[:username], params[:password])
      session[:username] = params[:username]
      flash.now[:alert] = 'Successfully signed in'
      redirect_to devices_path
    else
      flash.now[:error] = 'Invalid username and password'
      render action: :new
    end
  end

  # DELETE /sign_out
  def destroy
    session[:username] = nil
    flash[:alert] = 'You\'re logged out of the application'
    redirect_to signin_path
  end
end

