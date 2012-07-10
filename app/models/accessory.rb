class Accessory < ActiveRecord::Base
  attr_accessible :accessory_type, :description, :manufacturer

  belongs_to :device

  AccessoryTypes = [
    'Charger',
    'USB Cable',
    'Case/Cover',
    'Headset (Wired)',
    'Headset (Bluetooth)'
  ]

end
