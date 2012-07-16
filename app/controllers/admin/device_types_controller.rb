class Admin::DeviceTypesController < ApplicationController
  before_filter :admin_required

  def create
    @device_type = DeviceType.new(params[:device_type])

    respond_to do |format|
      if @device_type.save
        format.html { redirect_to admin_dashboard_path, notice: 'Device Type was successfully created.' }
        format.json { render json: @device_type, status: :created, location: @device_type }
      else
        format.html { redirect_to admin_dashboard_path, notice: "Some errors prevented the device_type from saving" }
        format.json { render json: @device_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @device_type = DeviceType.find(params[:id])

    respond_to do |format|
      if @device_type.update_attributes(params[:device_type])
      else
      end
    end
  end
end
