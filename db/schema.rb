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

ActiveRecord::Schema.define(version: 20150125024723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recommender_id"
    t.string   "resume"
  end

  create_table "apps", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.date     "date_of_birth"
    t.string   "ethnicity"
    t.string   "school_name"
    t.string   "school_address"
    t.string   "school_city"
    t.string   "school_state"
    t.string   "school_zip_code"
    t.string   "school_country"
    t.string   "grade_level"
    t.string   "email"
    t.string   "phone_number"
    t.text     "personal_statement"
    t.text     "supplemental_question_1"
    t.text     "supplemental_question_2"
    t.text     "supplemental_question_3"
    t.text     "supplemental_question_4"
    t.text     "supplemental_question_5"
    t.float    "gpa"
    t.integer  "sat_score"
    t.integer  "act_score"
    t.integer  "toefl_score"
    t.string   "recommender_email"
    t.integer  "applicant_id"
  end

  add_index "apps", ["applicant_id"], name: "index_apps_on_applicant_id", using: :btree

  create_table "recommenders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.integer  "recommender_id"
    t.string   "resume"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
