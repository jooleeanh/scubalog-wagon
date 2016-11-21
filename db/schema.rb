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

ActiveRecord::Schema.define(version: 20161121154814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "buddies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "dive_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dive_id"], name: "index_buddies_on_dive_id", using: :btree
    t.index ["user_id"], name: "index_buddies_on_user_id", using: :btree
  end

  create_table "dives", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "divesite_id"
    t.datetime "datetime"
    t.string   "type"
    t.integer  "tank_size"
    t.integer  "bottom_time"
    t.integer  "start_air"
    t.integer  "end_air"
    t.float    "max_depth"
    t.float    "avg_depth"
    t.float    "min_temp"
    t.float    "max_temp"
    t.text     "comments"
    t.integer  "enjoyment"
    t.integer  "visibility"
    t.text     "polygon",        default: [],              array: true
    t.integer  "review_rating"
    t.text     "review_content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["divesite_id"], name: "index_dives_on_divesite_id", using: :btree
    t.index ["user_id"], name: "index_dives_on_user_id", using: :btree
  end

  create_table "divesites", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "diffulty"
    t.float    "max_depth"
    t.float    "avg_depth"
    t.boolean  "freshwater", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "equipment_sets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "mask"
    t.string   "snorkel"
    t.string   "fins"
    t.string   "wetsuit"
    t.string   "computer"
    t.string   "bcd"
    t.string   "regulator"
    t.float    "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_equipment_sets_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "divesite_id"
    t.datetime "datetime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["divesite_id"], name: "index_events_on_divesite_id", using: :btree
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participations_on_event_id", using: :btree
    t.index ["user_id"], name: "index_participations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "buddies", "dives"
  add_foreign_key "buddies", "users"
  add_foreign_key "dives", "divesites"
  add_foreign_key "dives", "users"
  add_foreign_key "equipment_sets", "users"
  add_foreign_key "events", "divesites"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
end
