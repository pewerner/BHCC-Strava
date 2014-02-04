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

ActiveRecord::Schema.define(:version => 20140131115909) do

  create_table "bhcc_accesses", :force => true do |t|
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "username"
    t.string   "userid"
  end

  create_table "ride_data", :force => true do |t|
    t.string   "ride_id"
    t.integer  "athlete_id"
    t.float    "distance"
    t.float    "moving_time"
    t.float    "total_elevation_gain"
    t.datetime "start_date",           :limit => 255
    t.string   "location_city"
    t.string   "trainer"
    t.float    "average_speed"
    t.float    "max_speed"
    t.float    "calories"
    t.float    "total_work"
    t.float    "max_power"
    t.float    "avg_power"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "username"
  end

  create_table "rides", :force => true do |t|
    t.integer  "ride_id"
    t.integer  "rider_id"
    t.string   "rider_name"
    t.float    "moving_time"
    t.float    "elevation_gain"
    t.float    "distance"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
