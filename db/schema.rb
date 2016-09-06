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

ActiveRecord::Schema.define(version: 20160901165048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legal_days", force: :cascade do |t|
    t.integer  "year"
    t.datetime "start_date"
    t.string   "name"
    t.integer  "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_legal_days_on_site_id", using: :btree
    t.index ["year"], name: "index_legal_days_on_year", using: :btree
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sites_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",                            null: false
    t.string   "lastname",                             null: false
    t.string   "login",                                null: false
    t.string   "password_digest"
    t.string   "email",                                null: false
    t.string   "external_id"
    t.integer  "site_id"
    t.integer  "manager_id"
    t.boolean  "enabled",         default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "role",            default: "employee"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["external_id"], name: "index_users_on_external_id", unique: true, using: :btree
    t.index ["login"], name: "index_users_on_login", unique: true, using: :btree
    t.index ["manager_id"], name: "index_users_on_manager_id", using: :btree
    t.index ["role"], name: "index_users_on_role", using: :btree
    t.index ["site_id"], name: "index_users_on_site_id", using: :btree
  end

  add_foreign_key "legal_days", "sites"
  add_foreign_key "users", "sites"
  add_foreign_key "users", "users", column: "manager_id"
end
