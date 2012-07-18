class DeviceObserver < ActiveRecord::Observer
  def after_ask(device, transition)
    # Send email to owner
  end

  def after_return(device, transition)
    device.update_attributes(possessor: nil)
  end
end
