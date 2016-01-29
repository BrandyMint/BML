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

ActiveRecord::Schema.define(version: 20160129132451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "landings_count", default: 0, null: false
    t.string   "ident",                      null: false
    t.string   "access_key",                 null: false
  end

  add_index "accounts", ["access_key"], name: "index_accounts_on_access_key", unique: true, using: :btree
  add_index "accounts", ["ident"], name: "index_accounts_on_ident", unique: true, using: :btree

  create_table "asset_files", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "landing_id"
    t.integer  "landing_version_id"
    t.string   "file",                                                        null: false
    t.integer  "width"
    t.integer  "height"
    t.integer  "file_size",          limit: 8,                                null: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "type",                                                        null: false
    t.uuid     "uuid",                         default: "uuid_generate_v4()", null: false
    t.string   "digest",                                                      null: false
  end

  add_index "asset_files", ["account_id", "digest"], name: "index_asset_files_on_account_id_and_digest", unique: true, using: :btree
  add_index "asset_files", ["account_id"], name: "index_asset_files_on_account_id", using: :btree
  add_index "asset_files", ["landing_id"], name: "index_asset_files_on_landing_id", using: :btree
  add_index "asset_files", ["landing_version_id"], name: "index_asset_files_on_landing_version_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.text     "auth_hash",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["account_id"], name: "index_authentications_on_account_id", using: :btree
  add_index "authentications", ["provider", "uid", "account_id"], name: "index_authentications_on_provider_and_uid_and_account_id", unique: true, using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "landing_id", null: false
    t.string   "name",       null: false
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clients", ["landing_id"], name: "index_clients_on_landing_id", using: :btree

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

  create_table "landing_versions", force: :cascade do |t|
    t.integer  "landing_id",                                    null: false
    t.string   "title"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_active",      default: true,                 null: false
    t.integer  "sections_count", default: 0,                    null: false
    t.uuid     "uuid",           default: "uuid_generate_v4()", null: false
  end

  add_index "landing_versions", ["landing_id"], name: "index_landing_versions_on_landing_id", using: :btree
  add_index "landing_versions", ["uuid"], name: "index_landing_versions_on_uuid", unique: true, using: :btree

  create_table "landings", force: :cascade do |t|
    t.integer  "account_id",                                    null: false
    t.string   "title",                                         null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "sections_count", default: 0,                    null: false
    t.integer  "versions_count", default: 0,                    null: false
    t.integer  "segments_count", default: 0,                    null: false
    t.boolean  "is_active",      default: true,                 null: false
    t.uuid     "uuid",           default: "uuid_generate_v4()", null: false
    t.integer  "clients_count",  default: 0,                    null: false
  end

  add_index "landings", ["account_id"], name: "index_landings_on_account_id", using: :btree
  add_index "landings", ["uuid"], name: "index_landings_on_uuid", unique: true, using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "block_type",                                           null: false
    t.string   "block_view",                                           null: false
    t.uuid     "uuid",                  default: "uuid_generate_v4()", null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "landing_version_id",                                   null: false
    t.text     "content"
    t.integer  "row_order",             default: 0,                    null: false
    t.integer  "background_image_id"
    t.hstore   "node_attributes",       default: {}
    t.hstore   "background_attributes"
  end

  add_index "sections", ["landing_version_id", "row_order"], name: "index_sections_on_landing_version_id_and_row_order", using: :btree
  add_index "sections", ["uuid"], name: "index_sections_on_uuid", unique: true, using: :btree

  create_table "segments", force: :cascade do |t|
    t.integer  "landing_id"
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "segments", ["landing_id"], name: "index_segments_on_landing_id", using: :btree

  create_table "subdomains", force: :cascade do |t|
    t.string   "subdomain",                        null: false
    t.string   "zone",                             null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "use_domain",       default: false, null: false
    t.string   "confirmed_domain"
    t.string   "suggested_domain"
    t.string   "current_domain",                   null: false
    t.integer  "landing_id",                       null: false
  end

  add_index "subdomains", ["zone", "subdomain"], name: "index_subdomains_on_zone_and_subdomain", unique: true, using: :btree

  add_foreign_key "asset_files", "accounts"
  add_foreign_key "asset_files", "landing_versions"
  add_foreign_key "asset_files", "landings"
  add_foreign_key "authentications", "accounts"
  add_foreign_key "clients", "landings"
  add_foreign_key "collection_items", "collections"
  add_foreign_key "collections", "landings"
  add_foreign_key "landing_versions", "landings"
  add_foreign_key "landings", "accounts"
  add_foreign_key "sections", "asset_files", column: "background_image_id"
  add_foreign_key "segments", "landings"
  add_foreign_key "subdomains", "landings"
end
