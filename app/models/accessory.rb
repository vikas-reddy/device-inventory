class Accessory < ActiveRecord::Base
  attr_accessible :accessory_type_id, :description, :manufacturer

  # Associations
  belongs_to :device
  belongs_to :accessory_type

end
