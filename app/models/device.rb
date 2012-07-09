class Device < ActiveRecord::Base
  attr_accessible :environment, :ip_addr, :mac_addr, :make, :model, :os, :os_version, :owner_id, :phone_num, :possesser_id, :project, :serial_num, :service_provider, :device_type, :status
  validates_presence_of :environment, :ip_addr, :make, :model, :os, :os_version, :project, :serial_num
  belongs_to :user

  # Validations
  validates :mac_addr, format: {with: %r|^(\h\h:){5}\h\h$|, message: "should be 48-bit hexadecimal string"}, presence: true
  validates :phone_num, format: {with: %r|^[1-9]\d{9}$|, message: "should be 10-digit"}, allow_nil: true

  # Constants
  DeviceTypes = %w(Smartphone Tablet)


  def self.search(query)
    q = "%#{query}%"
    self.where(["make LIKE ? OR model LIKE ? OR os LIKE ? OR os_version LIKE ? OR project LIKE ?", q, q, q, q, q])
  end
end
