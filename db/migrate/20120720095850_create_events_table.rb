class CreateEventsTable < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string  :event_type
      t.integer :device_id
      
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
