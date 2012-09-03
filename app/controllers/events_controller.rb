class EventsController < ApplicationController

  before_filter :login_required

  def index
    @device = Device.find(params[:device_id])
    @events = @device.events.page(params[:page] || 1)
  end

end
