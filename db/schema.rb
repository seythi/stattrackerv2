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

ActiveRecord::Schema.define(version: 20160622184114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "pcs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "pcs", ["campaign_id"], name: "index_pcs_on_campaign_id", using: :btree
  add_index "pcs", ["user_id"], name: "index_pcs_on_user_id", using: :btree

  create_table "stats", force: :cascade do |t|
    t.string   "label"
    t.integer  "value"
    t.string   "conts"
    t.boolean  "dmonly"
    t.integer  "pc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stats", ["pc_id"], name: "index_stats_on_pc_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "campaigns", "users"
  add_foreign_key "pcs", "campaigns"
  add_foreign_key "pcs", "users"
  add_foreign_key "stats", "pcs"
end
