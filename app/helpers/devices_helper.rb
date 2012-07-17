module DevicesHelper
  def device_actions(device)
    case device.state.to_sym
    when :available
      link_to 'Request', '#device-actions', class: 'btn btn-mini btn-primary request-device', id: "request-device-#{device.id}"
    when :waiting
      link_to(
        'Waiting', '#device-actions',
        :class => 'btn btn-mini btn-primary waiting-device disabled', :id => "waiting-device-#{device.id}",
        'rel' => 'popover', 'data-content' => 'This device has already been requested by "user"',
        'data-original-title' => 'Waiting Approval'
      )
    end
  end
end
