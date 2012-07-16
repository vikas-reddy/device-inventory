class Admin::AccessoryTypesController < ApplicationController
  def create
    @accessory_type = AccessoryType.new(params[:accessory_type])

    respond_to do |format|
      if @accessory_type.save
        format.html { redirect_to admin_dashboard_path, notice: 'Accessory Type was successfully created.' }
        format.json { render json: @accessory_type, status: :created, location: @accessory_type }
      else
        format.html { redirect_to admin_dashboard_path, notice: "Some errors prevented the accessory_type from saving" }
        format.json { render json: @accessory_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @accessory_type = AccessoryType.find(params[:id])

    respond_to do |format|
      if @accessory_type.update_attributes(params[:accessory_type])
      else
      end
    end
  end
end
