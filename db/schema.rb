# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_20_011002) do
  create_table "buffet_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_buffet_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buffet_owners_on_reset_password_token", unique: true
  end

  create_table "buffet_payment_methods", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_payment_methods_on_buffet_id"
    t.index ["payment_method_id"], name: "index_buffet_payment_methods_on_payment_method_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "district"
    t.string "city"
    t.string "state_code"
    t.string "zip_code"
    t.string "description"
    t.integer "buffet_owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_owner_id"], name: "index_buffets_on_buffet_owner_id"
  end

  create_table "event_categories", force: :cascade do |t|
    t.integer "category"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_categories_on_event_id"
  end

  create_table "event_features", force: :cascade do |t|
    t.integer "event_id"
    t.integer "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_features_on_event_id"
    t.index ["feature_id"], name: "index_event_features_on_feature_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.integer "default_duration"
    t.text "menu"
    t.integer "buffet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "features", force: :cascade do |t|
    t.integer "feature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buffet_payment_methods", "buffets"
  add_foreign_key "buffet_payment_methods", "payment_methods"
  add_foreign_key "buffets", "buffet_owners"
end
