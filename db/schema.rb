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

ActiveRecord::Schema.define(version: 20141114174711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alignments", force: true do |t|
    t.integer  "project_id"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alignments", ["goal_id"], name: "index_alignments_on_goal_id", using: :btree
  add_index "alignments", ["project_id"], name: "index_alignments_on_project_id", using: :btree

  create_table "goals", force: true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goals", ["organization_id", "created_at"], name: "index_goals_on_organization_id_and_created_at", using: :btree
  add_index "goals", ["organization_id"], name: "index_goals_on_organization_id", using: :btree

  create_table "inpairments", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "task_id"
  end

  add_index "inpairments", ["task_id"], name: "index_inpairments_on_task_id", using: :btree
  add_index "inpairments", ["user_id"], name: "index_inpairments_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "responsible_role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id"], name: "index_memberships_on_project_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "organizations", ["ancestry"], name: "index_organizations_on_ancestry", using: :btree

  create_table "projects", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.boolean  "is_strategic",                   default: false, null: false
    t.integer  "status",                         default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_critical",                    default: false
    t.integer  "price_cents",          limit: 8, default: 0
    t.text     "alias"
    t.text     "remark"
    t.datetime "estimated_start_date"
    t.datetime "estimated_end_date"
    t.datetime "real_start_date"
    t.datetime "real_end_date"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.text     "description"
    t.datetime "deadline"
    t.integer  "complexity",     default: 0, null: false
    t.integer  "score",          default: 0, null: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "assigned_to_id"
    t.integer  "state_id"
    t.datetime "real_deadline"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
