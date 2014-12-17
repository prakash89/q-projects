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

ActiveRecord::Schema.define(version: 20131110125601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "pretty_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree

  create_table "link_types", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "theme",       limit: 56
    t.string   "button_text", limit: 56
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_links", force: true do |t|
    t.integer  "link_type_id"
    t.integer  "project_id"
    t.text     "url"
    t.boolean  "under_construction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_links", ["link_type_id"], name: "index_project_links_on_link_type_id", using: :btree
  add_index "project_links", ["project_id"], name: "index_project_links_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "pretty_url"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username",          limit: 32,  null: false
    t.string   "email",                         null: false
    t.text     "biography"
    t.string   "phone",             limit: 16
    t.string   "skype",             limit: 128
    t.string   "linkedin",          limit: 128
    t.string   "city",              limit: 128
    t.string   "state",             limit: 128
    t.string   "country",           limit: 128
    t.string   "department",        limit: 128
    t.string   "designation",       limit: 128
    t.string   "profile_image_url", limit: 512
    t.integer  "q_auth_uid"
    t.string   "auth_token"
    t.string   "user_type"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
