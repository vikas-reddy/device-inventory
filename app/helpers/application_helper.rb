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
end
