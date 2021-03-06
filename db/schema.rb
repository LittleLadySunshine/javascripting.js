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

ActiveRecord::Schema.define(version: 20141212165034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_plan_entries", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "cohort_id",   null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "assessments", force: true do |t|
    t.integer  "user_id",        null: false
    t.integer  "rubric_id",      null: false
    t.integer  "assessor_id",    null: false
    t.date     "date",           null: false
    t.json     "questions_json", null: false
    t.json     "responses_json", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_project_features", force: true do |t|
    t.integer  "class_project_id",             null: false
    t.integer  "category",         default: 0, null: false
    t.string   "name",                         null: false
    t.integer  "position",                     null: false
    t.text     "stories"
    t.text     "wireframes"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "class_project_features", ["class_project_id", "name", "category"], name: "index_category_feature_name", unique: true, using: :btree
  add_index "class_project_features", ["class_project_id", "position"], name: "index_class_project_features_on_class_project_id_and_position", unique: true, using: :btree

  create_table "class_projects", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "class_projects", ["name"], name: "index_class_projects_on_name", unique: true, using: :btree

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
    t.boolean  "showcase",                            default: false, null: false
    t.integer  "curriculum_id"
    t.boolean  "show_employment_ribbon",              default: false, null: false
    t.string   "calendar_url",           limit: 1000
    t.text     "prereqs"
    t.integer  "greenhouse_job_id",      limit: 8
  end

  add_index "cohorts", ["curriculum_id"], name: "index_cohorts_on_curriculum_id", using: :btree
  add_index "cohorts", ["greenhouse_job_id"], name: "index_cohorts_on_greenhouse_job_id", unique: true, using: :btree

  create_table "curriculum_units", force: true do |t|
    t.string   "name",                null: false
    t.integer  "position",            null: false
    t.text     "objectives",          null: false
    t.text     "assessment",          null: false
    t.text     "essential_questions"
    t.text     "rationale"
    t.text     "activities"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "curriculum_id",       null: false
  end

  add_index "curriculum_units", ["curriculum_id"], name: "index_curriculum_units_on_curriculum_id", using: :btree
  add_index "curriculum_units", ["name", "curriculum_id"], name: "index_curriculum_units_on_name_and_curriculum_id", using: :btree
  add_index "curriculum_units", ["position", "curriculum_id"], name: "index_curriculum_units_on_position_and_curriculum_id", using: :btree

  create_table "curriculums", force: true do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "curriculums", ["name"], name: "index_curriculums_on_name", using: :btree

  create_table "daily_plans", force: true do |t|
    t.integer  "cohort_id",   null: false
    t.date     "date",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "daily_plans", ["date", "cohort_id"], name: "index_daily_plans_on_date_and_cohort_id", unique: true, using: :btree

  create_table "employments", force: true do |t|
    t.integer  "user_id",                     null: false
    t.string   "company_name",                null: false
    t.string   "city"
    t.string   "company_type"
    t.boolean  "active",       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "epics", force: true do |t|
    t.integer  "class_project_id",             null: false
    t.integer  "category",         default: 0, null: false
    t.string   "name",                         null: false
    t.integer  "position",                     null: false
    t.text     "stories"
    t.text     "wireframes"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "label"
  end

  add_index "epics", ["class_project_id", "name", "category"], name: "index_category_epic_name", unique: true, using: :btree
  add_index "epics", ["class_project_id", "position"], name: "index_epics_on_class_project_id_and_position", unique: true, using: :btree

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "github_repo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "greenhouse_applications", force: true do |t|
    t.integer  "cohort_id",        null: false
    t.json     "application_json", null: false
    t.json     "candidate_json",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_plans", force: true do |t|
    t.string   "name",        null: false
    t.text     "objectives"
    t.text     "assessment"
    t.text     "activity"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lesson_plans", ["name"], name: "index_lesson_plans_on_name", unique: true, using: :btree

  create_table "lessons", force: true do |t|
    t.integer  "cohort_id"
    t.integer  "lesson_plan_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentors", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "first_name",   null: false
    t.string   "last_name",    null: false
    t.string   "email",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  create_table "pairings", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "pair_id",    null: false
    t.text     "feedback",   null: false
    t.date     "paired_on",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pairings", ["pair_id"], name: "index_pairings_on_pair_id", using: :btree
  add_index "pairings", ["user_id", "pair_id", "paired_on"], name: "index_pairings_on_user_id_and_pair_id_and_paired_on", using: :btree

  create_table "planned_lessons", force: true do |t|
    t.integer  "curriculum_unit_id", null: false
    t.integer  "lesson_plan_id",     null: false
    t.integer  "position",           null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "planned_lessons", ["curriculum_unit_id", "lesson_plan_id"], name: "index_planned_lessons_on_curriculum_unit_id_and_lesson_plan_id", unique: true, using: :btree
  add_index "planned_lessons", ["curriculum_unit_id", "position"], name: "index_planned_lessons_on_curriculum_unit_id_and_position", unique: true, using: :btree

  create_table "rubrics", force: true do |t|
    t.string   "name",           null: false
    t.json     "questions_json", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rubrics", ["name"], name: "index_rubrics_on_name", unique: true, using: :btree

  create_table "staffings", force: true do |t|
    t.integer  "cohort_id",  null: false
    t.integer  "user_id",    null: false
    t.integer  "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "staffings", ["cohort_id", "user_id"], name: "index_staffings_on_cohort_id_and_user_id", unique: true, using: :btree
  add_index "staffings", ["status"], name: "index_staffings_on_status", using: :btree

  create_table "stories", force: true do |t|
    t.integer  "epic_id",     null: false
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "position",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["epic_id", "position"], name: "index_stories_on_epic_id_and_position", unique: true, using: :btree
  add_index "stories", ["epic_id", "title"], name: "index_stories_on_epic_id_and_title", unique: true, using: :btree

  create_table "student_projects", force: true do |t|
    t.integer  "user_id",                          null: false
    t.string   "name",                             null: false
    t.text     "description"
    t.string   "github_url"
    t.string   "tracker_url"
    t.string   "production_url"
    t.string   "screenshot"
    t.boolean  "code_climate",     default: false, null: false
    t.boolean  "travis",           default: false, null: false
    t.text     "technical_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "class_project_id"
  end

  create_table "student_stories", force: true do |t|
    t.integer  "class_project_id",             null: false
    t.integer  "epic_id",                      null: false
    t.integer  "story_id",                     null: false
    t.integer  "user_id",                      null: false
    t.string   "current_state",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pivotal_tracker_id", limit: 8, null: false
  end

  add_index "student_stories", ["story_id", "user_id"], name: "index_student_stories_on_story_id_and_user_id", unique: true, using: :btree

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

  create_table "tracker_statuses", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "delivered",        default: 0, null: false
    t.integer  "accepted",         default: 0, null: false
    t.integer  "rejected",         default: 0, null: false
    t.integer  "started",          default: 0, null: false
    t.integer  "finished",         default: 0, null: false
    t.integer  "unstarted",        default: 0, null: false
    t.integer  "unscheduled",      default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "class_project_id",             null: false
  end

  add_index "tracker_statuses", ["user_id", "class_project_id"], name: "index_tracker_statuses_on_user_id_and_class_project_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_username"
    t.string   "github_id"
    t.integer  "cohort_id"
    t.integer  "role",                              default: 0
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
    t.integer  "status",                            default: 0, null: false
    t.integer  "greenhouse_candidate_id", limit: 8
    t.string   "pivotal_tracker_token"
  end

  add_index "users", ["cohort_id"], name: "index_users_on_cohort_id", using: :btree
  add_index "users", ["greenhouse_candidate_id"], name: "index_users_on_greenhouse_candidate_id", unique: true, using: :btree
  add_index "users", ["status"], name: "index_users_on_status", using: :btree

  create_table "writeup_topics", force: true do |t|
    t.integer  "cohort_id",                  null: false
    t.string   "subject",                    null: false
    t.text     "description"
    t.boolean  "active",      default: true, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "writeups", force: true do |t|
    t.integer  "writeup_topic_id",                 null: false
    t.integer  "user_id",                          null: false
    t.text     "response",                         null: false
    t.boolean  "read",             default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "writeups", ["writeup_topic_id", "user_id"], name: "index_writeups_on_writeup_topic_id_and_user_id", using: :btree

end
