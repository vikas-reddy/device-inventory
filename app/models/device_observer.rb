class DeviceObserver < ActiveRecord::Observer
  def after_ask(device, transition)
    # Send email to owner
  end

  def before_receive(device, transition)
    device.possessor = nil
  end
end
