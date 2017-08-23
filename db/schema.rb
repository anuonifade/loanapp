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

ActiveRecord::Schema.define(version: 20170823101710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_details", force: :cascade do |t|
    t.string "bank_name"
    t.string "account_number"
    t.string "sort_code"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_bank_details_on_profile_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.decimal "amount"
    t.string "start_month"
    t.string "start_year"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_contributions_on_profile_id"
  end

  create_table "guarantors", force: :cascade do |t|
    t.bigint "profile_id"
    t.integer "loan_id"
    t.integer "borrower_id"
    t.integer "guarantor_one_id"
    t.integer "guarantor_two_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_guarantors_on_loan_id"
    t.index ["profile_id"], name: "index_guarantors_on_profile_id"
  end

  create_table "loan_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.decimal "amount"
    t.decimal "monthly_deduction"
    t.bigint "profile_id"
    t.bigint "loan_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_type_id"], name: "index_loans_on_loan_type_id"
    t.index ["profile_id"], name: "index_loans_on_profile_id"
  end

  create_table "officers", force: :cascade do |t|
    t.string "position"
    t.text "description"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_officers_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "staff_id"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "gender"
    t.string "phone"
    t.date "dob"
    t.string "year_of_employment"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "nationality"
    t.string "designation"
    t.string "thrift_account"
    t.string "department"
    t.string "location"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "witnesses", force: :cascade do |t|
    t.bigint "profile_id"
    t.integer "loan_id"
    t.integer "borrower_id"
    t.integer "guarantor_one_id"
    t.integer "guarantor_two_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_witnesses_on_loan_id"
    t.index ["profile_id"], name: "index_witnesses_on_profile_id"
  end

  add_foreign_key "bank_details", "profiles"
  add_foreign_key "contributions", "profiles"
  add_foreign_key "guarantors", "loans"
  add_foreign_key "guarantors", "profiles"
  add_foreign_key "loans", "loan_types"
  add_foreign_key "loans", "profiles"
  add_foreign_key "officers", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "witnesses", "loans"
  add_foreign_key "witnesses", "profiles"
end
