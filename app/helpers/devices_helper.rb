module DevicesHelper
  def device_form_entries(f)
    device = f.object
    attribs = [
      [:serial_num,       :text_field],
      [:device_type,      :select    ],
      [:make,             :text_field],
      [:model,            :text_field],
      [:device_photo,     :file_field],
      [:os,               :text_field],
      [:os_version,       :text_field],
      [:environment,      :text_field],
      [:project,          :text_field],
      [:phone_num,        :text_field],
      [:service_provider, :text_field],
      [:mac_addr,         :text_field],
      [:ip_addr,          :text_field],
      [:status,           :select    ]
    ]
    content = ''

    attribs.each do |attrib, field_type|
      content << content_tag(:div, class: (device.errors[attrib].empty? ? 'control-group' : 'control-group error')) do
        f.label(attrib, attrib.to_s.titleize, class: 'control-label') +

        content_tag(:div, class: 'controls') do

          # field_type-based form element
          # Device model constants to conform to this convention
          case field_type
          when :text_field then f.text_field(attrib)
          when :select     then f.select(attrib, "Device::#{attrib.to_s.pluralize.camelize}".constantize)
          when :file_field then f.file_field(attrib)
          end +

          content_tag(:span, class: 'help-inline') do
            device.errors[attrib].join(', ')
          end
        end

      end
    end
    content.html_safe
  end
end
