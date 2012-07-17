class Device < ActiveRecord::Base
  #paper_trail 
  has_paper_trail

  attr_accessible :environment, :ip_addr, :mac_addr, :make, :model, :os, :os_version, :phone_num, :project, :serial_num, :service_provider, :device_type_id, :status, :device_photo, :device_photo_file_name, :device_photo_file_size, :device_photo_content_type, :accessories_attributes, :owner, :possessor

  attr_accessor :owner_name, :possesser_name

  # Associations
  has_many :accessories, dependent: :destroy
  belongs_to :device_type
  accepts_nested_attributes_for :accessories, allow_destroy: true

  # Validations
  validates_presence_of :environment, :ip_addr, :make, :model, :os, :os_version, :project, :serial_num
  validates :mac_addr, format: {with: %r|^(\h\h:){5}\h\h$|, message: "should be 48-bit hexadecimal string"}, presence: true
  validates :phone_num, format: {with: %r|^[1-9]\d{9}$|, message: "should be 10-digit"}, allow_nil: true
  validates :serial_num, uniqueness: true, presence: true

  # Constants
  Statuses = %w(Available In-Use Under-Repair)

  # Paperclip
  has_attached_file :device_photo,
    styles: {thumb: "100x100#", small: "250x250>"},
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "/:style/:id/:filename"

  # Filters
  #before_validation :parse_emails
  #after_find :load_emails


  def self.search(query)
    q = "%#{query}%"
    self.where(["make LIKE ? OR model LIKE ? OR os LIKE ? OR os_version LIKE ? OR project LIKE ?", q, q, q, q, q])
  end

  def os_name
    "#{os} (#{os_version})"
  end

end
