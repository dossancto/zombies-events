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

ActiveRecord::Schema[7.0].define(version: 2023_07_11_010648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "submit_videos", force: :cascade do |t|
    t.string "player_name"
    t.string "discord_user"
    t.string "instagram"
    t.string "twitter"
    t.string "category"
    t.text "gameplay_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twitch_videos", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.integer "view_count"
    t.string "published_at"
    t.string "url"
    t.integer "duration"
    t.string "language"
    t.string "user_login"
    t.string "user_name"
  end

end
