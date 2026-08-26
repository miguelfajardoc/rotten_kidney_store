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

ActiveRecord::Schema[8.0].define(version: 2026_08_26_160205) do
  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "klass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_kinds", force: :cascade do |t|
    t.string "name"
    t.string "material"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_kinds_sizes", id: false, force: :cascade do |t|
    t.integer "product_kind_id", null: false
    t.integer "size_id", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "stock"
    t.decimal "price"
    t.decimal "cost"
    t.string "aditional_info"
    t.integer "character_id", null: false
    t.integer "product_kind_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_products_on_character_id"
    t.index ["product_kind_id"], name: "index_products_on_product_kind_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "products", "characters"
  add_foreign_key "products", "product_kinds"
  add_foreign_key "sessions", "users"
end
