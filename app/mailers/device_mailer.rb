class DeviceMailer < ActionMailer::Base
  default from: "devices@pramati.com"

  def request_email(owner, requestor, device)
    @owner_name, @owner_email         = PramatiLdap::get_details(owner)
    @requestor_name, @requestor_email = PramatiLdap::get_details(requestor)
    @device                           = device

    mail(to: @owner_email, subject: "Request for #{@device.make} #{@device.model}")
  end

  def approval_email(owner, requestor, device)
    @owner_name, @owner_email         = PramatiLdap::get_details(owner)
    @requestor_name, @requestor_email = PramatiLdap::get_details(requestor)
    @device                           = device

    mail(to: @requestor_email, subject: "Request for #{@device.make} #{@device.model}")
  end

  def rejection_email(owner, requestor, device, reason)
    @owner_name, @owner_email         = PramatiLdap::get_details(owner)
    @requestor_name, @requestor_email = PramatiLdap::get_details(requestor)
    @device                           = device
    @reason                           = reason

    mail(to: @requestor_email, subject: "Request for #{@device.make} #{@device.model} rejected!")
  end
end
