class DeviceMailer < ActionMailer::Base
  default from: "devices@pramati.com"

  def request_email(owner, requestor, device)
    @owner_email     = PramatiLdap::get_email(owner)
    @requestor_email = PramatiLdap::get_email(requestor)
    @requestor       = requestor
    @owner           = owner
    @device          = device

    mail(to: @owner_email, subject: "Request for #{@device.make} #{@device.model}")
  end

  def approval_email(owner, requestor, device)
    @requestor_email = PramatiLdap::get_email(requestor)
    @requestor       = requestor
    @owner           = owner
    @device          = device

    mail(to: @requestor_email, subject: "Request for #{@device.make} #{@device.model}")
  end
end
