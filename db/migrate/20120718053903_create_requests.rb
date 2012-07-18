class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :device_id
      t.string :username

      t.timestamps
    end
  end
end
