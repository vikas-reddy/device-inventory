class UsersController < ApplicationController
  def search
    @users = User.search(params[:q])

    render json: @users.map(&:hybrid_name)
  end
end
