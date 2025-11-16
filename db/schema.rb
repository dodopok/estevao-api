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

ActiveRecord::Schema[8.1].define(version: 2025_11_16_025902) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "celebrations", force: :cascade do |t|
    t.string "calculation_rule"
    t.boolean "can_be_transferred", default: true, null: false
    t.integer "celebration_type", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "fixed_day"
    t.integer "fixed_month"
    t.string "latin_name"
    t.string "liturgical_color"
    t.boolean "movable", default: false, null: false
    t.string "name", null: false
    t.integer "rank", null: false
    t.jsonb "transfer_rules", default: {}
    t.datetime "updated_at", null: false
    t.index ["celebration_type"], name: "index_celebrations_on_celebration_type"
    t.index ["fixed_month", "fixed_day"], name: "index_celebrations_on_fixed_month_and_fixed_day"
    t.index ["movable"], name: "index_celebrations_on_movable"
    t.index ["name"], name: "index_celebrations_on_name"
    t.index ["rank"], name: "index_celebrations_on_rank"
  end

  create_table "collects", force: :cascade do |t|
    t.bigint "celebration_id"
    t.datetime "created_at", null: false
    t.string "language"
    t.string "preface"
    t.bigint "season_id"
    t.string "sunday_reference"
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["celebration_id"], name: "index_collects_on_celebration_id"
    t.index ["season_id"], name: "index_collects_on_season_id"
  end

  create_table "lectionary_readings", force: :cascade do |t|
    t.bigint "celebration_id", null: false
    t.datetime "created_at", null: false
    t.string "cycle"
    t.string "date_reference"
    t.string "first_reading"
    t.string "gospel"
    t.text "notes"
    t.string "psalm"
    t.string "second_reading"
    t.string "service_type"
    t.datetime "updated_at", null: false
    t.index ["celebration_id"], name: "index_lectionary_readings_on_celebration_id"
  end

  create_table "liturgical_colors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "hex_code"
    t.string "name"
    t.datetime "updated_at", null: false
    t.text "usage_description"
  end

  create_table "liturgical_seasons", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "collects", "celebrations"
  add_foreign_key "collects", "liturgical_seasons", column: "season_id"
  add_foreign_key "lectionary_readings", "celebrations"
end
