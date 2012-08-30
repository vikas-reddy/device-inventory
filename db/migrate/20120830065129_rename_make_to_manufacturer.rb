class RenameMakeToManufacturer < ActiveRecord::Migration
  def change
    rename_column :devices, :make, :manufacturer
  end
end
