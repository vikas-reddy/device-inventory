class Admin::DashboardController < ApplicationController
  before_filter :admin_required

  def index
    @device_types = DeviceType.all
    @accessory_types = AccessoryType.all
  end
end
