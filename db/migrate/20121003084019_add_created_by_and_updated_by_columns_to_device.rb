class AddCreatedByAndUpdatedByColumnsToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :created_by, :string
    add_column :devices, :updated_by, :string
  end
end
