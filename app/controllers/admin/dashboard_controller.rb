class Admin::DashboardController < ApplicationController
  def index
    @device_types = DeviceType.all
    @accessory_types = AccessoryType.all
  end
end
