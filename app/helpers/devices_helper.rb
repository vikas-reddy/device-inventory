module DevicesHelper
  def device_actions(device)
    case device.status
    when 'Available'
      link_to 'Issue', '#device-actions', class: 'btn btn-mini btn-primary issue-device', id: "issue-device-#{device.id}"
    when 'In-Use'
      link_to 'Return', '#device-actions', class: 'btn btn-mini btn-primary return-device', id: "return-device-#{device.id}"

    end
  end
end
