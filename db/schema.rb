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

ActiveRecord::Schema.define(version: 20150329215129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badgeinputs", force: true do |t|
    t.string   "treehouse_name"
    t.string   "codeschool_name"
    t.string   "codewars_name"
    t.string   "github_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "course_categories", force: true do |t|
    t.integer "course_id"
    t.integer "category_id"
  end

  create_table "courseitems", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "institution"
    t.string   "instructor"
    t.string   "price"
    t.text     "description"
    t.string   "url"
    t.string   "language"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "enrollment"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_courses", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "status"
    t.boolean  "course_creator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hide"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "slug"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
