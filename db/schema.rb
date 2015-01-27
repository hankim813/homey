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

ActiveRecord::Schema.define(version: 20150127083811) do

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
    t.float    "time_required"
  end

  create_table "car_washes", force: :cascade do |t|
    t.integer  "cars"
    t.boolean  "water_provided"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer  "driver_id"
    t.string   "model"
    t.integer  "wheel_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "owned"
  end

  create_table "chefs", force: :cascade do |t|
    t.string   "cuisine"
    t.integer  "serving_size"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contractors", force: :cascade do |t|
    t.integer  "type"
    t.text     "problem_description"
    t.text     "problem_frequency"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.integer  "day_or_night"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "gardenings", force: :cascade do |t|
    t.float    "acres"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guards", force: :cascade do |t|
    t.integer  "security_id"
    t.integer  "type"
    t.integer  "hours_required"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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

  create_table "office_cleanings", force: :cascade do |t|
    t.integer  "sqft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "kitchen"
  end

  create_table "securities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_providers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.string   "service"
    t.integer  "years_experience"
    t.string   "phone"
    t.string   "address"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "birthday"
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
