class AddOwnerToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :owner, :string
    rename_column :requests, :username, :requestor
  end
end
