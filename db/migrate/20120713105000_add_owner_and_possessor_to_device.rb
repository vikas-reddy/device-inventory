class AddOwnerAndPossessorToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :owner, :string
    add_column :devices, :possessor, :string
  end
end
