module DevicesHelper
  def device_actions(device)
    case device.state.to_sym
    when :available
      link_to 'Request', '#device-actions', class: 'btn btn-mini btn-primary issue-device', id: "request-device-#{device.id}"
    when :waiting
      link_to 'Requested', '#device-actions', class: 'btn btn-mini btn-primary issue-device disabled', id: "issue-device-#{device.id}"
    end
  end
end
