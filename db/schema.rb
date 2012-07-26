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

ActiveRecord::Schema.define(:version => 20120720095850) do

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
    t.string   "make"
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
  end

  create_table "events", :force => true do |t|
    t.string   "event_type"
    t.integer  "device_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requests", :force => true do |t|
    t.string   "device_id"
    t.string   "requestor"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "owner"
    t.string   "state"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
