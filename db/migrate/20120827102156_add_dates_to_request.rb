class AddDatesToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :from_date, :date
    add_column :requests, :to_date, :date
  end
end
