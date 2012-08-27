module ApplicationHelper
  def accessories_heading(device)
    count = device.accessories.count
    if count > 0
      "Accessories (#{count})"
    else
      "Accessories"
    end
  end

  def device_name(device)
    "#{device.make} #{device.model}"
  end

  def state_label(device)
    if device.is_a? Device
      label_class = case device.state.to_sym
                    when :available
                      'label-success'
                    when :waiting
                      'label-info'
                    when :in_use
                      'label-warning'
                    when :not_available
                      'label-important'
                    end
      content_tag(:span, device.state.to_s.titleize, class: "label #{label_class}")
    end
  end

  def format_date(d)
    d.strftime('%d-%m-%Y')
  end
end
