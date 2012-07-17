class Admin::AdministratorsController < ApplicationController
  before_filter :admin_required

  def search
    @administrators = PramatiLdap.search(params[:q])

    respond_to do |format|
      format.json { render json: @administrators }
    end
  end

  def create
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to admin_dashboard_path, notice: 'Administrator was successfully created.' }
        format.json { render json: @administrator, status: :created, location: @administrator }
      else
        format.html { redirect_to admin_dashboard_path, notice: "Some errors prevented the administrator from saving" }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      if @administrator.destroy
        format.html { redirect_to admin_dashboard_path, notice: 'Administrator was successfully destroyed.' }
      else
        format.html { redirect_to admin_dashboard_path, notice: "Some errors prevented the administrator from destroying" }
      end
    end
  end
end
