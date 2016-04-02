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

ActiveRecord::Schema.define(version: 20160401161652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "account_sms_log_entities", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "smsc_login"
    t.string   "smsc_sender"
    t.string   "message"
    t.string   "phones",                   array: true
    t.string   "result",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "account_sms_log_entities", ["account_id"], name: "index_account_sms_log_entities_on_account_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "landings_count",         default: 0,     null: false
    t.string   "ident",                                  null: false
    t.string   "access_key",                             null: false
    t.integer  "clients_count",          default: 0,     null: false
    t.string   "name"
    t.integer  "tariff_id"
    t.string   "smsc_login"
    t.string   "smsc_password"
    t.string   "smsc_sender"
    t.boolean  "smsc_active",            default: false
    t.integer  "sms_log_entities_count", default: 0,     null: false
  end

  add_index "accounts", ["access_key"], name: "index_accounts_on_access_key", unique: true, using: :btree
  add_index "accounts", ["ident"], name: "index_accounts_on_ident", unique: true, using: :btree
  add_index "accounts", ["tariff_id"], name: "index_accounts_on_tariff_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "asset_files", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "landing_id"
    t.integer  "variant_id"
    t.string   "file",                                                null: false
    t.integer  "width"
    t.integer  "height"
    t.integer  "file_size",  limit: 8,                                null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "type",                                                null: false
    t.uuid     "uuid",                 default: "uuid_generate_v4()", null: false
    t.string   "digest",                                              null: false
  end

  add_index "asset_files", ["account_id", "digest"], name: "index_asset_files_on_account_id_and_digest", unique: true, using: :btree
  add_index "asset_files", ["account_id"], name: "index_asset_files_on_account_id", using: :btree
  add_index "asset_files", ["landing_id"], name: "index_asset_files_on_landing_id", using: :btree
  add_index "asset_files", ["variant_id"], name: "index_asset_files_on_variant_id", using: :btree

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
    t.integer  "account_id", null: false
  end

  add_index "clients", ["account_id"], name: "index_clients_on_account_id", using: :btree
  add_index "clients", ["landing_id", "email"], name: "index_clients_on_landing_id_and_email", unique: true, using: :btree
  add_index "clients", ["landing_id", "phone"], name: "index_clients_on_landing_id_and_phone", unique: true, using: :btree
  add_index "clients", ["landing_id"], name: "index_clients_on_landing_id", using: :btree

  create_table "collection_fields", force: :cascade do |t|
    t.integer  "collection_id", null: false
    t.string   "key",           null: false
    t.string   "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "collection_fields", ["collection_id", "key"], name: "index_collection_fields_on_collection_id_and_key", unique: true, using: :btree

  create_table "collections", force: :cascade do |t|
    t.integer  "landing_id",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "leads_count", default: 0, null: false
  end

  add_index "collections", ["landing_id"], name: "index_collections_on_landing_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "user_inviter_id",                    null: false
    t.integer  "account_id",                         null: false
    t.string   "key",                                null: false
    t.string   "role",            default: "master", null: false
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "invites", ["account_id", "phone"], name: "index_invites_on_account_id_and_phone", unique: true, using: :btree
  add_index "invites", ["email", "account_id"], name: "index_invites_on_email_and_account_id", unique: true, using: :btree
  add_index "invites", ["key"], name: "index_invites_on_key", using: :btree

  create_table "landing_views", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "landing_id"
    t.integer  "variant_id"
    t.string   "url",          limit: 4096, null: false
    t.string   "utm_source",   limit: 4096
    t.string   "utm_campaign", limit: 4096
    t.string   "utm_medium",   limit: 4096
    t.string   "utm_term",     limit: 4096
    t.string   "utm_content",  limit: 4096
    t.string   "referer",      limit: 4096
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "viewer_uid"
    t.string   "remote_ip"
    t.string   "user_agent"
  end

  add_index "landing_views", ["account_id"], name: "index_landing_views_on_account_id", using: :btree
  add_index "landing_views", ["landing_id"], name: "index_landing_views_on_landing_id", using: :btree
  add_index "landing_views", ["variant_id"], name: "index_landing_views_on_variant_id", using: :btree

  create_table "landings", force: :cascade do |t|
    t.integer  "account_id",                                      null: false
    t.string   "title",                                           null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "sections_count",   default: 0,                    null: false
    t.integer  "variants_count",   default: 0,                    null: false
    t.integer  "segments_count",   default: 0,                    null: false
    t.boolean  "is_active",        default: true,                 null: false
    t.uuid     "uuid",             default: "uuid_generate_v4()", null: false
    t.integer  "clients_count",    default: 0,                    null: false
    t.string   "path",                                            null: false
    t.string   "head_title"
    t.text     "meta_description"
    t.text     "meta_keywords"
  end

  add_index "landings", ["account_id", "path"], name: "index_landings_on_account_id_and_path", unique: true, using: :btree
  add_index "landings", ["account_id"], name: "index_landings_on_account_id", using: :btree
  add_index "landings", ["uuid"], name: "index_landings_on_uuid", unique: true, using: :btree

  create_table "leads", force: :cascade do |t|
    t.integer  "collection_id"
    t.hstore   "data"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "variant_id"
    t.string   "first_utm_source"
    t.string   "first_utm_campaign"
    t.string   "first_utm_medium"
    t.string   "first_utm_term"
    t.string   "first_utm_content"
    t.string   "first_referer"
    t.string   "last_utm_source"
    t.string   "last_utm_campaign"
    t.string   "last_utm_medium"
    t.string   "last_utm_term"
    t.string   "last_utm_content"
    t.string   "last_referer"
    t.integer  "number",                             null: false
    t.string   "public_number",                      null: false
    t.integer  "landing_id",                         null: false
    t.string   "utm_source"
    t.string   "utm_campaign"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "referer"
    t.string   "viewer_uid"
    t.integer  "client_id"
    t.string   "state",              default: "new", null: false
  end

  add_index "leads", ["client_id"], name: "index_leads_on_client_id", using: :btree
  add_index "leads", ["collection_id"], name: "index_leads_on_collection_id", using: :btree
  add_index "leads", ["landing_id", "public_number"], name: "index_leads_on_landing_id_and_public_number", unique: true, using: :btree
  add_index "leads", ["variant_id"], name: "index_leads_on_variant_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "account_id",                        null: false
    t.integer  "user_id",                           null: false
    t.string   "role",                              null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "email_notification", default: true, null: false
    t.boolean  "sms_notification",   default: true, null: false
  end

  add_index "memberships", ["account_id"], name: "index_memberships_on_account_id", using: :btree
  add_index "memberships", ["user_id", "account_id"], name: "index_memberships_on_user_id_and_account_id", unique: true, using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "phone_confirmations", force: :cascade do |t|
    t.string   "phone",                            null: false
    t.integer  "user_id",                          null: false
    t.boolean  "is_confirmed",     default: false, null: false
    t.string   "pin_code",                         null: false
    t.datetime "pin_requested_at"
    t.datetime "confirmed_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "phone_confirmations", ["user_id"], name: "index_phone_confirmations_on_user_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "block_view",                                           null: false
    t.uuid     "uuid",                  default: "uuid_generate_v4()", null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "variant_id",                                           null: false
    t.text     "content"
    t.integer  "row_order",             default: 0,                    null: false
    t.integer  "background_image_id"
    t.hstore   "node_attributes",       default: {}
    t.hstore   "background_attributes"
    t.text     "form"
  end

  add_index "sections", ["uuid"], name: "index_sections_on_uuid", unique: true, using: :btree
  add_index "sections", ["variant_id", "row_order"], name: "index_sections_on_variant_id_and_row_order", using: :btree

  create_table "segments", force: :cascade do |t|
    t.integer  "landing_id"
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "segments", ["landing_id"], name: "index_segments_on_landing_id", using: :btree

  create_table "tariffs", force: :cascade do |t|
    t.string   "title",                                    null: false
    t.string   "description"
    t.string   "slug",                                     null: false
    t.integer  "price_per_month_cents",    default: 0,     null: false
    t.string   "price_per_month_currency", default: "RUB", null: false
    t.integer  "price_per_site_cents",     default: 0,     null: false
    t.string   "price_per_site_currency",  default: "RUB", null: false
    t.integer  "price_per_lead_cents",     default: 0,     null: false
    t.string   "price_per_lead_currency",  default: "RUB", null: false
    t.integer  "free_days_count",          default: 0,     null: false
    t.integer  "free_leads_count",         default: 0,     null: false
    t.boolean  "hidden",                   default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "tariffs", ["slug"], name: "index_tariffs_on_slug", unique: true, using: :btree
  add_index "tariffs", ["title"], name: "index_tariffs_on_title", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                           null: false
    t.string   "phone"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "email_confirm_token"
    t.datetime "email_confirmed_at"
    t.datetime "phone_confirmed_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  create_table "utm_values", force: :cascade do |t|
    t.integer  "account_id", null: false
    t.integer  "landing_id", null: false
    t.string   "key_type",   null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "utm_values", ["account_id"], name: "index_utm_values_on_account_id", using: :btree
  add_index "utm_values", ["key_type"], name: "index_utm_values_on_key_type", using: :btree
  add_index "utm_values", ["landing_id", "key_type", "value"], name: "index_utm_values_on_landing_id_and_key_type_and_value", unique: true, using: :btree
  add_index "utm_values", ["value"], name: "index_utm_values_on_value", using: :btree

  create_table "variants", force: :cascade do |t|
    t.integer  "landing_id",                                    null: false
    t.string   "title"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_active",      default: true,                 null: false
    t.integer  "sections_count", default: 0,                    null: false
    t.uuid     "uuid",           default: "uuid_generate_v4()", null: false
    t.integer  "leads_count",    default: 0,                    null: false
    t.integer  "account_id",                                    null: false
    t.boolean  "is_boxed",       default: true,                 null: false
    t.string   "theme_name"
  end

  add_index "variants", ["account_id"], name: "index_variants_on_account_id", using: :btree
  add_index "variants", ["landing_id"], name: "index_variants_on_landing_id", using: :btree
  add_index "variants", ["uuid"], name: "index_variants_on_uuid", unique: true, using: :btree

  create_table "viewers", force: :cascade do |t|
    t.string   "uid",        null: false
    t.integer  "landing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "remote_ip"
    t.string   "user_agent"
  end

  add_index "viewers", ["landing_id", "uid"], name: "index_viewers_on_landing_id_and_uid", unique: true, using: :btree

  create_table "web_addresses", force: :cascade do |t|
    t.string   "subdomain",                        null: false
    t.string   "zone",                             null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "use_domain",       default: false, null: false
    t.string   "confirmed_domain"
    t.string   "suggested_domain"
    t.string   "current_domain",                   null: false
    t.integer  "account_id"
  end

  add_index "web_addresses", ["account_id"], name: "index_web_addresses_on_account_id", using: :btree
  add_index "web_addresses", ["zone", "subdomain"], name: "index_web_addresses_on_zone_and_subdomain", unique: true, using: :btree

  add_foreign_key "account_sms_log_entities", "accounts"
  add_foreign_key "accounts", "tariffs"
  add_foreign_key "asset_files", "accounts"
  add_foreign_key "asset_files", "landings"
  add_foreign_key "asset_files", "variants"
  add_foreign_key "authentications", "accounts"
  add_foreign_key "clients", "accounts"
  add_foreign_key "clients", "landings"
  add_foreign_key "collection_fields", "collections"
  add_foreign_key "collections", "landings"
  add_foreign_key "invites", "accounts"
  add_foreign_key "invites", "users", column: "user_inviter_id"
  add_foreign_key "landing_views", "accounts"
  add_foreign_key "landing_views", "landings"
  add_foreign_key "landing_views", "variants"
  add_foreign_key "landings", "accounts"
  add_foreign_key "leads", "clients"
  add_foreign_key "leads", "collections"
  add_foreign_key "leads", "landings"
  add_foreign_key "leads", "variants"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
  add_foreign_key "phone_confirmations", "users"
  add_foreign_key "sections", "asset_files", column: "background_image_id"
  add_foreign_key "segments", "landings"
  add_foreign_key "utm_values", "accounts"
  add_foreign_key "utm_values", "landings"
  add_foreign_key "variants", "accounts"
  add_foreign_key "variants", "landings"
  add_foreign_key "web_addresses", "accounts"
end
