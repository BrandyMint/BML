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

ActiveRecord::Schema.define(version: 20160119114342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "landings_count", default: 0, null: false
  end

  create_table "collection_items", force: :cascade do |t|
    t.integer  "collection_id"
    t.hstore   "data"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "collection_items", ["collection_id"], name: "index_collection_items_on_collection_id", using: :btree

  create_table "collections", force: :cascade do |t|
    t.integer  "landing_id",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "items_count", default: 0, null: false
  end

  add_index "collections", ["landing_id"], name: "index_collections_on_landing_id", using: :btree

  create_table "landings", force: :cascade do |t|
    t.integer  "account_id",                 null: false
    t.string   "title"
    t.datetime "version"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "sections_count", default: 0, null: false
  end

  add_index "landings", ["account_id"], name: "index_landings_on_account_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "landing_id",              null: false
    t.string   "block_type",              null: false
    t.string   "block_view",              null: false
    t.uuid     "uuid",                    null: false
    t.hstore   "data",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "sections", ["landing_id"], name: "index_sections_on_landing_id", using: :btree

  add_foreign_key "collection_items", "collections"
  add_foreign_key "collections", "landings"
  add_foreign_key "landings", "accounts"
  add_foreign_key "sections", "landings"
end
