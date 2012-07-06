class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :serial_num
      t.string :type
      t.string :make
      t.string :model
      t.string :os
      t.string :os_version
      t.string :environment
      t.string :project
      t.string :phone_num
      t.string :service_provider
      t.string :mac_addr
      t.string :ip_addr
      t.integer :owner_id
      t.integer :possesser_id

      t.timestamps
    end
  end
end
