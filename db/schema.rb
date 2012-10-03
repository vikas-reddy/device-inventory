# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121003102758) do

  create_table "accessories", :force => true do |t|
    t.text     "description"
    t.string   "manufacturer"
    t.integer  "device_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "accessory_type_id"
  end

  create_table "accessory_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "administrators", :force => true do |t|
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "device_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "serial_num"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "os"
    t.string   "os_version"
    t.string   "environment"
    t.string   "project"
    t.string   "phone_num"
    t.string   "service_provider"
    t.string   "mac_addr"
    t.string   "ip_addr"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "state"
    t.string   "device_photo_file_name"
    t.string   "device_photo_content_type"
    t.integer  "device_photo_file_size"
    t.integer  "device_type_id"
    t.string   "owner"
    t.string   "possessor"
    t.string   "property_of"
    t.string   "label"
    t.string   "imei"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "events", :force => true do |t|
    t.string   "event_type"
    t.integer  "device_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "comments"
  end

  create_table "requests", :force => true do |t|
    t.string   "device_id"
    t.string   "requestor"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "owner"
    t.string   "state"
    t.date     "from_date"
    t.date     "to_date"
  end

end
