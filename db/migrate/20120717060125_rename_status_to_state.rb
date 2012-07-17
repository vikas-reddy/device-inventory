class RenameStatusToState < ActiveRecord::Migration
  def change
    rename_column :devices, :status, :state
  end
end
