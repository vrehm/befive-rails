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

ActiveRecord::Schema.define(version: 20161019143818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "event_id"
    t.integer  "member_id"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_activities_on_event_id", using: :btree
    t.index ["member_id"], name: "index_activities_on_member_id", using: :btree
    t.index ["team_id"], name: "index_activities_on_team_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "location_id"
    t.string   "category"
    t.datetime "datetime"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "date"
    t.time     "time"
    t.string   "opponent"
    t.index ["location_id"], name: "index_events_on_location_id", using: :btree
    t.index ["team_id"], name: "index_events_on_team_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "team_id"
    t.index ["team_id"], name: "index_invitations_on_team_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logos", force: :cascade do |t|
    t.string   "color"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "pending",    default: false
    t.boolean  "validated",  default: false
    t.index ["team_id"], name: "index_members_on_team_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "recipient_email"
    t.text     "content"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "recipient_first_name"
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "sent",         default: false
    t.boolean  "pending",      default: false
    t.boolean  "validated",    default: false
    t.boolean  "refused",      default: false
    t.boolean  "waiting_list", default: false
    t.index ["event_id"], name: "index_participations_on_event_id", using: :btree
    t.index ["user_id"], name: "index_participations_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_relationships_on_team_id", using: :btree
    t.index ["user_id"], name: "index_relationships_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "logo_id"
    t.integer  "location_id"
    t.index ["location_id"], name: "index_teams_on_location_id", using: :btree
    t.index ["logo_id"], name: "index_teams_on_logo_id", using: :btree
    t.index ["user_id"], name: "index_teams_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "position"
    t.date     "birthdate"
    t.boolean  "has_team",               default: false
    t.boolean  "manager",                default: false
    t.string   "height"
    t.string   "weight"
    t.string   "favorite_foot"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "events"
  add_foreign_key "activities", "members"
  add_foreign_key "activities", "teams"
  add_foreign_key "activities", "users"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "locations"
  add_foreign_key "events", "teams"
  add_foreign_key "events", "users"
  add_foreign_key "invitations", "teams"
  add_foreign_key "invitations", "users"
  add_foreign_key "members", "teams"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
  add_foreign_key "relationships", "teams"
  add_foreign_key "relationships", "users"
  add_foreign_key "teams", "locations"
  add_foreign_key "teams", "logos"
  add_foreign_key "teams", "users"
end
