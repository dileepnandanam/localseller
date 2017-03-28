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

ActiveRecord::Schema.define(version: 20170328043449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_hashes", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bills", force: :cascade do |t|
    t.integer  "shop_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "im_payment_request_id"
    t.string   "im_payment_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.boolean  "deleted",            default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "searchable"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "shoping_cart_id"
    t.integer  "shop_id"
    t.string   "product_id"
    t.boolean  "payed",           default: false
    t.boolean  "payed_out",       default: false
    t.integer  "user_id"
    t.integer  "quantity"
    t.boolean  "shiped",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "bill_id"
  end

  create_table "shoping_carts", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "checked_out",           default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "im_payment_request_id"
    t.string   "im_payment_id"
    t.integer  "shop_id"
    t.boolean  "payed_out",             default: false
    t.integer  "bill_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "phone_number"
    t.string   "pincode"
    t.string   "email"
    t.text     "description"
    t.integer  "lat"
    t.integer  "lngt"
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "instamajo_api_key"
    t.string   "instamajo_auth_token"
    t.boolean  "deleted",              default: false
  end

  add_index "shops", ["permalink"], name: "index_shops_on_permalink", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "usertype"
    t.string   "name"
    t.text     "address"
    t.string   "pincode"
    t.string   "phone_number"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
