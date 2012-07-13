class RemoveOwnerIdAndPossesserIdFromDevice < ActiveRecord::Migration
  def up
    remove_column :devices, :owner_id
    remove_column :devices, :possesser_id
  end

  def down
    add_column :devices, :possesser_id, :integer
    add_column :devices, :owner_id, :integer
  end
end
