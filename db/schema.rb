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

ActiveRecord::Schema[8.1].define(version: 2025_11_29_032806) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bible_texts", force: :cascade do |t|
    t.string "book", null: false
    t.integer "book_number", null: false
    t.integer "chapter", null: false
    t.datetime "created_at", null: false
    t.text "text", null: false
    t.string "translation", default: "nvi"
    t.datetime "updated_at", null: false
    t.integer "verse", null: false
    t.string "verse_type"
    t.index ["book", "chapter", "verse", "translation"], name: "index_bible_texts_on_verse_lookup"
    t.index ["book_number", "chapter", "verse", "translation"], name: "index_bible_texts_on_book_number_lookup"
  end

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
    t.bigint "prayer_book_id", null: false
    t.integer "rank", null: false
    t.jsonb "transfer_rules", default: {}
    t.datetime "updated_at", null: false
    t.index ["celebration_type"], name: "index_celebrations_on_celebration_type"
    t.index ["fixed_month", "fixed_day"], name: "index_celebrations_on_fixed_month_and_fixed_day"
    t.index ["movable"], name: "index_celebrations_on_movable"
    t.index ["name"], name: "index_celebrations_on_name"
    t.index ["prayer_book_id"], name: "index_celebrations_on_prayer_book_id"
    t.index ["rank"], name: "index_celebrations_on_rank"
  end

  create_table "collects", force: :cascade do |t|
    t.bigint "celebration_id"
    t.datetime "created_at", null: false
    t.string "language"
    t.bigint "prayer_book_id", null: false
    t.string "preface"
    t.bigint "season_id"
    t.string "sunday_reference"
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["celebration_id", "prayer_book_id"], name: "index_collects_on_celebration_id_and_prayer_book_id"
    t.index ["celebration_id"], name: "index_collects_on_celebration_id"
    t.index ["prayer_book_id"], name: "index_collects_on_prayer_book_id"
    t.index ["season_id"], name: "index_collects_on_season_id"
  end

  create_table "completions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date_reference", null: false
    t.integer "duration_seconds"
    t.string "office_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "date_reference", "office_type"], name: "index_completions_unique", unique: true
    t.index ["user_id"], name: "index_completions_on_user_id"
  end

  create_table "fcm_tokens", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "platform"
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "token"], name: "index_fcm_tokens_on_user_id_and_token", unique: true
    t.index ["user_id"], name: "index_fcm_tokens_on_user_id"
  end

  create_table "lectionary_readings", force: :cascade do |t|
    t.bigint "celebration_id"
    t.datetime "created_at", null: false
    t.string "cycle"
    t.string "date_reference"
    t.string "first_reading"
    t.string "gospel"
    t.text "notes"
    t.bigint "prayer_book_id", null: false
    t.string "psalm"
    t.string "reading_type"
    t.string "second_reading"
    t.string "service_type"
    t.datetime "updated_at", null: false
    t.index ["celebration_id"], name: "index_lectionary_readings_on_celebration_id"
    t.index ["date_reference", "service_type", "prayer_book_id"], name: "index_lectionary_readings_on_date_service_prayer_book"
    t.index ["prayer_book_id"], name: "index_lectionary_readings_on_prayer_book_id"
    t.index ["reading_type"], name: "index_lectionary_readings_on_reading_type"
  end

  create_table "life_rule_steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "life_rule_id", null: false
    t.integer "order", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["life_rule_id", "order"], name: "index_life_rule_steps_on_life_rule_id_and_order", unique: true
    t.index ["life_rule_id"], name: "index_life_rule_steps_on_life_rule_id"
  end

  create_table "life_rules", force: :cascade do |t|
    t.integer "adoption_count", default: 0, null: false
    t.boolean "approved", default: false, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon", null: false
    t.boolean "is_public", default: false, null: false
    t.bigint "original_life_rule_id"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["adoption_count"], name: "index_life_rules_on_adoption_count"
    t.index ["approved"], name: "index_life_rules_on_approved"
    t.index ["is_public"], name: "index_life_rules_on_is_public"
    t.index ["original_life_rule_id"], name: "index_life_rules_on_original_life_rule_id"
    t.index ["user_id"], name: "index_life_rules_on_user_id", unique: true
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

  create_table "liturgical_texts", force: :cascade do |t|
    t.string "audio_url"
    t.string "category", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.string "language", default: "pt-BR"
    t.bigint "prayer_book_id", null: false
    t.string "reference"
    t.string "slug", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_liturgical_texts_on_category"
    t.index ["prayer_book_id"], name: "index_liturgical_texts_on_prayer_book_id"
    t.index ["slug", "prayer_book_id"], name: "index_liturgical_texts_on_slug_and_prayer_book_id", unique: true
  end

  create_table "notification_logs", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.jsonb "data", default: {}
    t.text "error_message"
    t.string "notification_type"
    t.boolean "sent", default: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["created_at"], name: "index_notification_logs_on_created_at"
    t.index ["notification_type"], name: "index_notification_logs_on_notification_type"
    t.index ["sent"], name: "index_notification_logs_on_sent"
    t.index ["user_id"], name: "index_notification_logs_on_user_id"
  end

  create_table "prayer_book_user_preferences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "options", default: {}, null: false
    t.bigint "prayer_book_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["options"], name: "index_prayer_book_user_preferences_on_options", using: :gin
    t.index ["prayer_book_id"], name: "index_prayer_book_user_preferences_on_prayer_book_id"
    t.index ["user_id", "prayer_book_id"], name: "index_pb_user_prefs_on_user_and_prayer_book", unique: true
    t.index ["user_id"], name: "index_prayer_book_user_preferences_on_user_id"
  end

  create_table "prayer_books", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.jsonb "features", default: {}, null: false
    t.boolean "is_default"
    t.string "jurisdiction"
    t.string "name"
    t.string "pdf_url"
    t.string "thumbnail_url"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["code"], name: "index_prayer_books_on_code", unique: true
    t.index ["features"], name: "index_prayer_books_on_features", using: :gin
    t.index ["is_default"], name: "index_prayer_books_on_is_default"
  end

  create_table "psalm_cycles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "cycle_type", null: false
    t.integer "day_of_week", null: false
    t.text "notes"
    t.string "office_type", null: false
    t.bigint "prayer_book_id", null: false
    t.jsonb "psalm_numbers", default: [], null: false
    t.datetime "updated_at", null: false
    t.integer "week_number"
    t.index ["cycle_type", "week_number", "day_of_week", "office_type", "prayer_book_id"], name: "index_psalm_cycles_on_cycle_lookup_with_prayer_book", unique: true
    t.index ["prayer_book_id"], name: "index_psalm_cycles_on_prayer_book_id"
  end

  create_table "psalms", force: :cascade do |t|
    t.text "antiphon"
    t.datetime "created_at", null: false
    t.integer "number", null: false
    t.bigint "prayer_book_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.jsonb "verses", default: {}, null: false
    t.index ["number", "prayer_book_id"], name: "index_psalms_on_number_and_prayer_book_id", unique: true
    t.index ["prayer_book_id"], name: "index_psalms_on_prayer_book_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "current_streak", default: 0
    t.string "email", null: false
    t.datetime "last_completed_office_at"
    t.integer "longest_streak", default: 0
    t.string "name"
    t.string "photo_url"
    t.jsonb "preferences", default: {}, null: false
    t.string "provider_uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider_uid"], name: "index_users_on_provider_uid"
  end

  add_foreign_key "celebrations", "prayer_books", on_delete: :restrict
  add_foreign_key "collects", "celebrations"
  add_foreign_key "collects", "liturgical_seasons", column: "season_id"
  add_foreign_key "collects", "prayer_books"
  add_foreign_key "completions", "users"
  add_foreign_key "fcm_tokens", "users"
  add_foreign_key "lectionary_readings", "celebrations"
  add_foreign_key "lectionary_readings", "prayer_books"
  add_foreign_key "life_rule_steps", "life_rules"
  add_foreign_key "life_rules", "life_rules", column: "original_life_rule_id"
  add_foreign_key "life_rules", "users"
  add_foreign_key "liturgical_texts", "prayer_books", on_delete: :restrict
  add_foreign_key "notification_logs", "users"
  add_foreign_key "prayer_book_user_preferences", "prayer_books"
  add_foreign_key "prayer_book_user_preferences", "users"
  add_foreign_key "psalm_cycles", "prayer_books"
  add_foreign_key "psalms", "prayer_books", on_delete: :restrict
end
