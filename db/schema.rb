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

ActiveRecord::Schema.define(version: 20161222154312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider", "uid", "token", "secret"], name: "omniauth_index", unique: true, using: :btree
  end

  create_table "displays", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active_content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "file"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_displays_on_user_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.string   "entry_name"
    t.string   "hashtag"
    t.string   "account_name"
    t.integer  "fill_percentage"
    t.boolean  "account_active"
    t.boolean  "hashtag_active"
    t.integer  "display_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["display_id"], name: "index_entries_on_display_id", using: :btree
  end

  create_table "tweets", force: :cascade do |t|
    t.text     "status"
    t.string   "user_name"
    t.text     "media_url"
    t.datetime "tweet_sent_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "twitter_id"
    t.integer  "entry_id"
    t.index ["entry_id"], name: "index_tweets_on_entry_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "displays", "users"
  add_foreign_key "entries", "displays"
  add_foreign_key "tweets", "entries"
end
