module ApplicationHelper
  def uri_matches?(paths)
    paths ||= []
    regex = %r|^([^?]*)(\?.*)?$|  # ignore the arguments while matching
    paths.any? do |path|
      request.fullpath.sub(regex, '\1') == path.sub(regex, '\1')
    end
  end

  def sidebar_entries
    entries = [
      {:text => "Search",       :paths => [device_path(0)]},
      {:text => "List Devices", :paths => [devices_path, root_path]},
      {:text => "Add Device",   :paths => [new_device_path]},
      {} # divider
    ]

    content = ''
    entries.each do |entry|
      if entry.empty?
        content << content_tag(:li, nil, :class => 'divider')
      else
        content << content_tag(:li, :class => uri_matches?(entry[:paths]) ? 'active' : '') do
          link_to entry[:text], entry[:paths].first
        end
      end
    end
    content.html_safe
  end
end
