class AddPropertyOfColumnToDevices < ActiveRecord::Migration
  def up
    add_column :devices, :property_of, :string
  end

  def down
    remove_column :devices, :property_of
  end
end
