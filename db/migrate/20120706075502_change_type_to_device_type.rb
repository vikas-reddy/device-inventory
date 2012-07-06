class ChangeTypeToDeviceType < ActiveRecord::Migration
  def up
	rename_column :devices, :type, :device_type
  end

  def down
	rename_column :devices, :device_type, :type
  end
end
