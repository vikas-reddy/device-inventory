class AddImeiToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :imei, :string
  end
end
