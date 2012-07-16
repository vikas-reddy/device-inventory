class Admin::DashboardController < ApplicationController
  before_filter :admin_required

  def index
    @administrators = Administrator.all
    @device_types = DeviceType.all
    @accessory_types = AccessoryType.all

    @administrator = Administrator.new
    @device_type = DeviceType.new
    @accessory_type = AccessoryType.new
  end
end
