class DeviceObserver < ActiveRecord::Observer
  observe :device, :request

  def before_receive(device, transition)
    device.possessor = nil
  end

  def after_approve(req, transition)
    req.device.assign_to(req.requestor)
    DeviceMailer.approval_email(req.owner, req.requestor, req.device).deliver
  end

  def after_reject(req, transition)
    req.device.deny
  end
end
