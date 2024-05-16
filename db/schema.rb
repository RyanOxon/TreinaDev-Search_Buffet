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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_234732) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.boolean "active", default: true
    t.index ["buffet_owner_id"], name: "index_buffets_on_buffet_owner_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "event_categories", force: :cascade do |t|
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_features", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_features_on_event_id"
    t.index ["feature_id"], name: "index_event_features_on_feature_id"
  end

  create_table "event_prices", force: :cascade do |t|
    t.integer "price_type"
    t.integer "base_value"
    t.integer "extra_per_person"
    t.integer "extra_per_hour"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_prices_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.integer "default_duration"
    t.text "menu"
    t.boolean "exclusive_address"
    t.integer "buffet_id", null: false
    t.integer "event_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "photo_id"
    t.boolean "active", default: true
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
    t.index ["event_category_id"], name: "index_events_on_event_category_id"
  end

  create_table "features", force: :cascade do |t|
    t.integer "feature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "holder_images", force: :cascade do |t|
    t.string "holder_type", null: false
    t.integer "holder_id", null: false
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.datetime "uploaded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["holder_type", "holder_id"], name: "index_holder_images_on_holder"
    t.index ["user_type", "user_id"], name: "index_holder_images_on_user"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "order_id", null: false
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.datetime "posted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_messages_on_order_id"
    t.index ["user_type", "user_id"], name: "index_messages_on_user"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "customer_id", null: false
    t.date "date"
    t.integer "people_count"
    t.string "code"
    t.string "details"
    t.string "address"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade do |t|
    t.integer "score"
    t.text "comment"
    t.integer "buffet_id", null: false
    t.integer "customer_id", null: false
    t.date "rated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_rates_on_buffet_id"
    t.index ["customer_id"], name: "index_rates_on_customer_id"
  end

  create_table "service_proposals", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "payment_method_id", null: false
    t.integer "status", default: 0
    t.integer "value"
    t.integer "extra_fee", default: 0
    t.integer "discount", default: 0
    t.string "description"
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_service_proposals_on_order_id"
    t.index ["payment_method_id"], name: "index_service_proposals_on_payment_method_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buffet_payment_methods", "buffets"
  add_foreign_key "buffet_payment_methods", "payment_methods"
  add_foreign_key "buffets", "buffet_owners"
  add_foreign_key "event_features", "events"
  add_foreign_key "event_features", "features"
  add_foreign_key "event_prices", "events"
  add_foreign_key "events", "buffets"
  add_foreign_key "events", "event_categories"
  add_foreign_key "messages", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "events"
  add_foreign_key "rates", "buffets"
  add_foreign_key "rates", "customers"
  add_foreign_key "service_proposals", "orders"
  add_foreign_key "service_proposals", "payment_methods"
end
