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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150123231622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "service_date"
    t.boolean  "completed",    default: false
    t.boolean  "paid",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "canceled",     default: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "appointment_id"
    t.decimal  "quote",            precision: 8, scale: 2
    t.integer  "serviceable_id"
    t.string   "serviceable_type"
    t.text     "notes"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "num_of_providers"
  end

  create_table "home_cleanings", force: :cascade do |t|
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "kitchens"
    t.integer  "livingrooms"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "laundries", force: :cascade do |t|
    t.integer "loads"
    t.integer "ironed"
    t.integer "home_cleaning_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.integer  "age"
    t.string   "email"
    t.string   "phone"
    t.string   "password_hash"
  end

end
