class AddDeviceTypeIdAndAccessoryTypeId < ActiveRecord::Migration
  def change
    add_column :devices, :device_type_id, :integer
    add_column :accessories, :accessory_type_id, :integer
  end
end
