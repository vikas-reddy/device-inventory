class RemoveDeviceTypeAndAccessoryType < ActiveRecord::Migration
  def up
    remove_column :devices, :device_type
    remove_column :accessories, :accessory_type
  end

  def down
    add_column :accessories, :accessory_type, :string
    add_column :devices, :device_type, :string
  end
end
