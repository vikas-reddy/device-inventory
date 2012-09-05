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
    "#{device.manufacturer} #{device.model}"
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
      content_tag(:span, class: "label #{label_class}") do
        device.in_use? ? device.possessor : device.state.to_s.titleize
      end
    end
  end

  def format_date(d)
    d.strftime('%d-%m-%Y')
  end

  def request_datespan(req)
    %{#{req.from_date} to #{req.to_date.nil? ? 'NONE' : req.to_date}} if req.is_a?(Request)
  end


  def labeled_form_for(object, options = {}, &block)
    options[:builder] = LabeledFormBuilder
    form_for(object, options, &block)
  end
end
