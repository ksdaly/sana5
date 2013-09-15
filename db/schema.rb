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

ActiveRecord::Schema.define(version: 20130915204557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "health_profiles", force: true do |t|
    t.integer  "user_id"
    t.boolean  "male",                                           default: false
    t.date     "dob",                                                            null: false
    t.integer  "weight",                                                         null: false
    t.integer  "height",                                                         null: false
    t.integer  "systolic_bp",                                                    null: false
    t.integer  "diastolic_bp",                                                   null: false
    t.boolean  "antihypertensive_drugs",                         default: false
    t.boolean  "steroid_drugs",                                  default: false
    t.boolean  "diabetes",                                       default: false
    t.boolean  "parent_with_diabetes",                           default: false
    t.boolean  "sibling_with_diabetes",                          default: false
    t.boolean  "smoker",                                         default: false
    t.boolean  "exsmoker",                                       default: false
    t.decimal  "cardiovascular_risk",    precision: 5, scale: 2
    t.decimal  "diabetes_risk",          precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",   null: false
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
