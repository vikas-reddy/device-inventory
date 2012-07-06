class AddStatusColumnToDevices < ActiveRecord::Migration
  def up
    add_column :devices, :status, :string
  end
  def down
    remove_column :devices, :status
  end
end
