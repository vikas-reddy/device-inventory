class DeviceObserver < ActiveRecord::Observer
  observe :device, :request

  def before_receive(device, transition)
    device.possessor = nil
  end

  def after_approve(req, transition)
    req.device.assign_to(req.requestor)
    DeviceMailer.approval_email(req.owner, req.requestor, req.device).deliver
    Event.record_event(req.device_id, "Device has been issued to #{req.requestor}")
  end

  def after_reject(req, transition)
    req.device.deny
    Event.record_event(req.device_id, "Device has been rejected to #{req.requestor}")
  end

  def before_make_available(device, transition)
    device.possessor = nil
  end

  def before_make_unavailable(device, transition)
    device.possessor = nil
  end
end
