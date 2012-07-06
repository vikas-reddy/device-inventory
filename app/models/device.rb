class Device < ActiveRecord::Base
  attr_accessible :environment, :ip_addr, :mac_addr, :make, :model, :os, :os_version, :owner_id, :phone_num, :possesser_id, :project, :serial_num, :service_provider, :device_type, :status
end
