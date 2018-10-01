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

ActiveRecord::Schema.define(version: 20180930203951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_details", force: :cascade do |t|
    t.string "bank_name"
    t.string "account_number"
    t.string "sort_code"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_name"
    t.index ["profile_id"], name: "index_bank_details_on_profile_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "start_month"
    t.string "start_year"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "amount", precision: 20, scale: 2
    t.index ["profile_id"], name: "index_contributions_on_profile_id"
  end

  create_table "loan_repayments", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "month"
    t.integer "year"
    t.bigint "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_repayments_on_loan_id"
  end

  create_table "loan_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "loan_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guarantor_one_id"
    t.integer "guarantor_two_id"
    t.string "start_month"
    t.integer "start_year"
    t.decimal "amount", precision: 20, scale: 2
    t.decimal "expected_amount", precision: 20, scale: 2
    t.decimal "monthly_deduction", precision: 20, scale: 2
    t.integer "duration"
    t.decimal "yearly_deduction"
    t.boolean "finished_payment", default: false
    t.datetime "finished_payment_date"
    t.integer "approved_by"
    t.datetime "approved_date"
    t.datetime "guarantor_one_approved_date"
    t.datetime "guarantor_two_approved_date"
    t.integer "guarantor_one_status", default: 1
    t.integer "guarantor_two_status", default: 1
    t.integer "status", default: 1
    t.index ["loan_type_id"], name: "index_loans_on_loan_type_id"
    t.index ["profile_id"], name: "index_loans_on_profile_id"
  end

  create_table "monthly_contributions", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "month"
    t.integer "year"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_monthly_contributions_on_profile_id"
  end

  create_table "next_of_kins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "nationality"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "relationship"
    t.index ["profile_id"], name: "index_next_of_kins_on_profile_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "gender"
    t.string "phone"
    t.date "dob"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "nationality"
    t.string "designation"
    t.string "department"
    t.string "location"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year_of_employment"
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
    t.bigint "role_id", default: 3
    t.boolean "activated", default: false
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
  add_foreign_key "loan_repayments", "loans"
  add_foreign_key "loans", "loan_types"
  add_foreign_key "loans", "profiles"
  add_foreign_key "monthly_contributions", "profiles"
  add_foreign_key "next_of_kins", "profiles"
  add_foreign_key "officers", "profiles"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "witnesses", "loans"
  add_foreign_key "witnesses", "profiles"
end
