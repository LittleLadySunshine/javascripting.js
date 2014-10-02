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

ActiveRecord::Schema.define(version: 20141002054757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cohort_exercises", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "cohort_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cohorts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "google_maps_location"
    t.text     "directions"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "pair_feedback_url"
    t.string   "hero"
    t.boolean  "showcase",             default: false, null: false
    t.string   "curriculum_site_url",                  null: false
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "github_repo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "github_repo_name"
    t.string   "tracker_url"
    t.string   "production_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.string   "github_repo_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tracker_project_url"
  end

  add_index "submissions", ["exercise_id"], name: "index_submissions_on_exercise_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_username"
    t.string   "github_id"
    t.integer  "cohort_id"
    t.integer  "role",            default: 0
    t.string   "phone"
    t.string   "twitter"
    t.string   "blog"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "linkedin"
    t.string   "avatar"
    t.string   "shirt_size"
  end

  add_index "users", ["cohort_id"], name: "index_users_on_cohort_id", using: :btree

end
