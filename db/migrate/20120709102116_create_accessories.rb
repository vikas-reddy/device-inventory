class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.string :accessory_type
      t.text :description
      t.string :manufacturer
      t.integer :device_id

      t.timestamps
    end
  end
end
