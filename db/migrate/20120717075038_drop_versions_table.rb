class DropVersionsTable < ActiveRecord::Migration
  def up
    drop_table :versions
  end

  def down
    create_table "versions", :force => true do |t|
      t.string   "item_type",  :null => false
      t.integer  "item_id",    :null => false
      t.string   "event",      :null => false
      t.string   "whodunnit"
      t.text     "object"
      t.datetime "created_at"
    end
  end
end
