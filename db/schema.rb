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

ActiveRecord::Schema.define(version: 20160913105929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leave_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "leave_id"
    t.integer  "leave_type_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "status"
    t.integer  "approved_by_id"
    t.integer  "nb_hours"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "range"
    t.string   "period"
    t.index ["leave_id"], name: "index_leave_requests_on_leave_id", using: :btree
    t.index ["leave_type_id"], name: "index_leave_requests_on_leave_type_id", using: :btree
    t.index ["user_id"], name: "index_leave_requests_on_user_id", using: :btree
  end

  create_table "leave_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_leave_types_on_name", unique: true, using: :btree
  end

  create_table "leaves", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "leave_type_id"
    t.integer  "nb_hours"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["leave_type_id"], name: "index_leaves_on_leave_type_id", using: :btree
    t.index ["user_id"], name: "index_leaves_on_user_id", using: :btree
  end

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

  create_table "teams", force: :cascade do |t|
    t.integer  "manager_id"
    t.string   "name"
    t.string   "external_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["manager_id"], name: "index_teams_on_manager_id", using: :btree
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname",                             null: false
    t.string   "login",                                null: false
    t.string   "password_digest"
    t.string   "email",                                null: false
    t.string   "external_id"
    t.integer  "site_id"
    t.boolean  "enabled",         default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "role",            default: "employee"
    t.integer  "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["external_id"], name: "index_users_on_external_id", using: :btree
    t.index ["login"], name: "index_users_on_login", unique: true, using: :btree
    t.index ["role"], name: "index_users_on_role", using: :btree
    t.index ["site_id"], name: "index_users_on_site_id", using: :btree
    t.index ["team_id"], name: "index_users_on_team_id", using: :btree
  end

  add_foreign_key "leave_requests", "leave_types"
  add_foreign_key "leave_requests", "leaves"
  add_foreign_key "leave_requests", "users"
  add_foreign_key "leaves", "leave_types"
  add_foreign_key "leaves", "users"
  add_foreign_key "legal_days", "sites"
  add_foreign_key "users", "sites"
  add_foreign_key "users", "teams"
end
