module DevicesHelper
  def device_actions(device)
    case device.state
    when 'available'
      link_to 'Issue', '#device-actions', class: 'btn btn-mini btn-primary issue-device', id: "issue-device-#{device.id}"
    when 'in_use'
      link_to 'Return', '#device-actions', class: 'btn btn-mini btn-primary return-device', id: "return-device-#{device.id}"

    end
  end
end
