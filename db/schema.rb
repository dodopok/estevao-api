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

ActiveRecord::Schema[8.1].define(version: 2025_12_29_215548) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audio_generation_sessions", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "current_text_id"
    t.string "current_voice_key"
    t.text "error_log"
    t.integer "failed_count", default: 0
    t.string "prayer_book_code", null: false
    t.integer "processed_count", default: 0
    t.datetime "started_at"
    t.string "status", default: "running", null: false
    t.integer "total_texts", default: 0
    t.datetime "updated_at", null: false
    t.string "voice_keys", default: [], array: true
    t.index ["prayer_book_code", "status"], name: "index_audio_generation_sessions_on_prayer_book_code_and_status"
    t.index ["prayer_book_code"], name: "index_audio_generation_sessions_on_prayer_book_code"
    t.index ["status"], name: "index_audio_generation_sessions_on_status"
  end

  create_table "bible_texts", force: :cascade do |t|
    t.string "book", null: false
    t.integer "book_number", null: false
    t.integer "chapter", null: false
    t.datetime "created_at", null: false
    t.text "text", null: false
    t.string "translation", default: "nvi"
    t.datetime "updated_at", null: false
    t.integer "verse", null: false
    t.index ["book", "chapter", "verse", "translation"], name: "index_bible_texts_on_verse_lookup"
    t.index ["book_number", "chapter", "verse", "translation"], name: "index_bible_texts_on_book_number_lookup"
  end

  create_table "bible_versions", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "full_name"
    t.boolean "is_active", default: true
    t.boolean "is_recommended", default: false
    t.string "language", default: "pt-BR"
    t.string "license"
    t.string "name", null: false
    t.string "publisher"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["code"], name: "index_bible_versions_on_code", unique: true
    t.index ["is_active", "is_recommended"], name: "index_bible_versions_on_is_active_and_is_recommended"
    t.index ["language"], name: "index_bible_versions_on_language"
  end

  create_table "celebrations", force: :cascade do |t|
    t.string "calculation_rule"
    t.boolean "can_be_transferred", default: true, null: false
    t.integer "celebration_type", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "description_year"
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
    t.index ["calculation_rule"], name: "index_celebrations_on_calculation_rule"
    t.index ["celebration_type"], name: "index_celebrations_on_celebration_type"
    t.index ["fixed_month", "fixed_day"], name: "index_celebrations_on_fixed_month_and_fixed_day"
    t.index ["movable"], name: "index_celebrations_on_movable"
    t.index ["name", "prayer_book_id"], name: "index_celebrations_on_name_and_prayer_book_id", unique: true
    t.index ["prayer_book_id", "can_be_transferred"], name: "index_celebrations_on_prayer_book_and_transferable"
    t.index ["prayer_book_id", "fixed_month", "fixed_day"], name: "index_celebrations_on_prayer_book_date", where: "(movable = false)"
    t.index ["prayer_book_id", "movable"], name: "index_celebrations_on_prayer_book_and_movable"
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

  create_table "journals", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.date "date_reference", null: false
    t.string "entry_type", null: false
    t.string "office_type"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "date_reference", "entry_type", "office_type"], name: "index_journals_on_user_date_type_office"
    t.index ["user_id", "date_reference"], name: "index_journals_on_user_id_and_date_reference"
    t.index ["user_id"], name: "index_journals_on_user_id"
  end

  create_table "lectionary_readings", force: :cascade do |t|
    t.bigint "celebration_id"
    t.datetime "created_at", null: false
    t.string "cycle"
    t.string "date_reference"
    t.string "first_reading"
    t.string "first_reading_abbreviated"
    t.string "first_reading_alternative"
    t.string "gospel"
    t.string "gospel_abbreviated"
    t.string "gospel_alternative"
    t.text "notes"
    t.bigint "prayer_book_id", null: false
    t.string "psalm"
    t.string "psalm_alternative"
    t.string "reading_type"
    t.string "second_reading"
    t.string "second_reading_abbreviated"
    t.string "second_reading_alternative"
    t.string "service_type"
    t.datetime "updated_at", null: false
    t.index ["celebration_id"], name: "index_lectionary_readings_on_celebration_id"
    t.index ["cycle", "service_type", "prayer_book_id", "date_reference"], name: "index_lectionary_readings_on_common_lookup"
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
    t.index "lower((title)::text)", name: "index_life_rules_on_lower_title"
    t.index ["adoption_count"], name: "index_life_rules_on_adoption_count"
    t.index ["approved"], name: "index_life_rules_on_approved"
    t.index ["is_public", "approved"], name: "index_life_rules_on_public_approved", where: "((is_public = true) AND (approved = true))"
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
    t.string "audio_generation_status", default: "pending"
    t.string "audio_url"
    t.jsonb "audio_urls", default: {}, null: false
    t.string "category", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.string "language", default: "pt-BR"
    t.bigint "prayer_book_id", null: false
    t.string "reference"
    t.string "slug", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["audio_generation_status"], name: "index_liturgical_texts_on_audio_generation_status"
    t.index ["audio_urls"], name: "index_liturgical_texts_on_audio_urls", using: :gin
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

  create_table "prayer_books", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.jsonb "features", default: {}, null: false
    t.string "image_url"
    t.boolean "is_recommended"
    t.string "jurisdiction"
    t.string "language", default: "pt-BR", null: false
    t.string "name"
    t.integer "order", default: 0, null: false
    t.string "pdf_url"
    t.boolean "premium_required", default: false, null: false
    t.string "thumbnail_url"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["code"], name: "index_prayer_books_on_code", unique: true
    t.index ["features"], name: "index_prayer_books_on_features", using: :gin
    t.index ["is_recommended"], name: "index_prayer_books_on_is_recommended"
    t.index ["language", "code"], name: "index_prayer_books_on_language_and_code"
    t.index ["language"], name: "index_prayer_books_on_language"
    t.index ["premium_required", "is_recommended"], name: "index_prayer_books_on_premium_required_and_is_recommended"
    t.index ["premium_required"], name: "index_prayer_books_on_premium_required"
  end

  create_table "preference_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "icon"
    t.string "key", null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.bigint "prayer_book_id", null: false
    t.datetime "updated_at", null: false
    t.index ["prayer_book_id", "key"], name: "index_preference_categories_on_prayer_book_id_and_key", unique: true
    t.index ["prayer_book_id", "position"], name: "index_preference_categories_on_prayer_book_id_and_position"
    t.index ["prayer_book_id"], name: "index_preference_categories_on_prayer_book_id"
  end

  create_table "preference_definitions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "default_value"
    t.jsonb "depends_on"
    t.text "description"
    t.string "key", null: false
    t.string "name", null: false
    t.jsonb "options", default: []
    t.integer "position", default: 0, null: false
    t.string "pref_type", null: false
    t.bigint "preference_category_id", null: false
    t.boolean "required", default: false
    t.datetime "updated_at", null: false
    t.jsonb "validation_rules", default: {}
    t.index ["pref_type"], name: "index_preference_definitions_on_pref_type"
    t.index ["preference_category_id", "key"], name: "idx_pref_definitions_on_category_and_key", unique: true
    t.index ["preference_category_id", "position"], name: "idx_pref_definitions_on_category_and_position"
    t.index ["preference_category_id"], name: "index_preference_definitions_on_preference_category_id"
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

  create_table "shared_offices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.datetime "expires_at", null: false
    t.string "office_type", null: false
    t.string "prayer_book_code", null: false
    t.jsonb "preferences", default: {}
    t.bigint "seed", null: false
    t.string "short_code", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["date", "office_type", "prayer_book_code"], name: "idx_on_date_office_type_prayer_book_code_ae0f27ea4d"
    t.index ["expires_at"], name: "index_shared_offices_on_expires_at"
    t.index ["short_code"], name: "index_shared_offices_on_short_code", unique: true
    t.index ["user_id"], name: "index_shared_offices_on_user_id"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.integer "byte_size", null: false
    t.datetime "created_at", null: false
    t.binary "key", null: false
    t.bigint "key_hash", null: false
    t.binary "value", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "user_onboardings", force: :cascade do |t|
    t.bigint "bible_version_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.string "mode", default: "basic", null: false
    t.boolean "onboarding_completed", default: true
    t.bigint "prayer_book_id", null: false
    t.jsonb "preferences", default: {}, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["bible_version_id"], name: "index_user_onboardings_on_bible_version_id"
    t.index ["onboarding_completed"], name: "index_user_onboardings_on_onboarding_completed"
    t.index ["prayer_book_id"], name: "index_user_onboardings_on_prayer_book_id"
    t.index ["preferences"], name: "index_user_onboardings_on_preferences", using: :gin
    t.index ["user_id"], name: "index_user_onboardings_on_user_id", unique: true
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
    t.datetime "premium_expires_at"
    t.string "provider_uid"
    t.string "revenue_cat_user_id"
    t.string "timezone", default: "America/Sao_Paulo", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["premium_expires_at"], name: "index_users_on_premium_expires_at"
    t.index ["provider_uid"], name: "index_users_on_provider_uid"
    t.index ["revenue_cat_user_id"], name: "index_users_on_revenue_cat_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "celebrations", "prayer_books", on_delete: :restrict
  add_foreign_key "collects", "celebrations"
  add_foreign_key "collects", "liturgical_seasons", column: "season_id"
  add_foreign_key "collects", "prayer_books"
  add_foreign_key "completions", "users"
  add_foreign_key "fcm_tokens", "users"
  add_foreign_key "journals", "users"
  add_foreign_key "lectionary_readings", "celebrations"
  add_foreign_key "lectionary_readings", "prayer_books"
  add_foreign_key "life_rule_steps", "life_rules"
  add_foreign_key "life_rules", "life_rules", column: "original_life_rule_id"
  add_foreign_key "life_rules", "users"
  add_foreign_key "liturgical_texts", "prayer_books", on_delete: :restrict
  add_foreign_key "notification_logs", "users"
  add_foreign_key "preference_categories", "prayer_books"
  add_foreign_key "preference_definitions", "preference_categories"
  add_foreign_key "psalm_cycles", "prayer_books"
  add_foreign_key "psalms", "prayer_books", on_delete: :restrict
  add_foreign_key "shared_offices", "users"
  add_foreign_key "user_onboardings", "bible_versions"
  add_foreign_key "user_onboardings", "prayer_books"
  add_foreign_key "user_onboardings", "users"
end
