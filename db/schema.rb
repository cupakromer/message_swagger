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

ActiveRecord::Schema[7.0].define(version: 2022_03_11_141521) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "depots", force: :cascade do |t|
    t.string "receiver_type", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_type", "receiver_id"], name: "index_depots_on_receiver", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "depot_id", null: false
    t.string "content", limit: 4000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["depot_id"], name: "index_messages_on_depot_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle", limit: 120, null: false
    t.string "name", limit: 400, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((handle)::text)", name: "index_users_on_LOWER_handle", unique: true
  end

  add_foreign_key "messages", "depots"
  add_foreign_key "messages", "users", column: "author_id", on_delete: :cascade
end
