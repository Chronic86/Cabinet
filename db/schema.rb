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

ActiveRecord::Schema.define(version: 20160520125638) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "finances", force: :cascade do |t|
    t.integer  "locality_id"
    t.integer  "period_id"
    t.integer  "company_id"
    t.integer  "debt",        limit: 8
    t.integer  "calculation", limit: 8
    t.integer  "payment",     limit: 8
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "information_companies", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "period_id"
    t.string   "director"
    t.string   "phone"
    t.integer  "area"
    t.integer  "count_mkd"
    t.integer  "count_living"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "information_localities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "localities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer  "account",           limit: 8
    t.string   "address"
    t.integer  "debt",              limit: 8
    t.integer  "payment",           limit: 8
    t.string   "last_payment_date"
    t.integer  "locality_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "debt_period"
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
