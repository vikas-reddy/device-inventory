class Device < ActiveRecord::Base

  attr_accessible :environment, :ip_addr, :mac_addr, :manufacturer, :model, :os, :os_version, :phone_num, :project, :serial_num, :service_provider, :device_type_id, :state, :device_photo, :device_photo_file_name, :device_photo_file_size, :device_photo_content_type, :accessories_attributes, :owner, :possessor, :property_of, :label, :imei

  attr_accessor :owner_name, :possesser_name

  # Associations
  has_many :accessories, dependent: :destroy
  has_many :requests
  has_many :events
  belongs_to :device_type
  accepts_nested_attributes_for :accessories, allow_destroy: true

  # Validations
  validates :mac_addr,   format: {with: %r|^(\h\h:){5}\h\h$|, message: "should be 48-bit hexadecimal string", allow_blank: true}
  validates :imei,       format: {with: %r|^\d{15}(\d\d)?$|,  message: "should be 15 or 17-digit",            allow_blank: true}
  validates :phone_num,  format: {with: %r|^[1-9]\d{9}$|,     message: "should be 10-digit",                  allow_blank: true}
  validates :serial_num, uniqueness: true,                    presence: true

  # Paperclip
  has_attached_file :device_photo,
    styles: {thumb: "100x100#", small: "250x250>"},
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    path: "/:style/:id/:filename"

  # State Machine
  state_machine :state, :initial => :available do

    # Any user
    event :ask do
      transition :available => :waiting
    end

    # Device owner only
    event :assign do
      transition :waiting => :in_use
    end
    event :deny do
      transition :waiting => :available
    end
    event :receive do
      transition :in_use => :available
    end

    # Admin only
    event :make_unavailable do
      transition [:available, :in_use, :waiting] => :not_available
    end
    event :make_available do
      transition :not_available => [:available, :in_use, :waiting]
    end
  end


  # Methods
  def self.search(query)
    q = "%#{query}%"
    self.where(["manufacturer LIKE ? OR model LIKE ? OR os LIKE ? OR os_version LIKE ? OR project LIKE ?", q, q, q, q, q])
  end

  def os_name
    "#{os} (#{os_version})"
  end

  def assign_to(u)
    self.possessor = u
    self.assign
  end

  def pending_request
    requests.pending.order("created_at desc").first
  end

  # List of all devices... but the ones owned by `current_user` should be 
  # displayed first... and therefore an Arel union is required for this!
  def self.list_for(u)
    d1, d2 = arel_table, arel_table

    # Owned by current_user
    d1 = d1.project('devices.*').where(
      d1[:state].eq(:not_available).not
    ).where( d1[:owner].eq(u) )

    # Owned by others
    d2 = d2.project('devices.*').where(
      d2[:state].eq(:not_available).not
    ).where( d2[:owner].eq(u).not )

    # TODO: refactor this!
    # Arel is not producing correct union syntax for UNION. It is surrounding
    # the whole SELECT by braces ( ).
    find_by_sql(d1.union(d2).to_sql.delete('()'))
  end
end
