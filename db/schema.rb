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

ActiveRecord::Schema.define(version: 20150602123525) do

  create_table "articles", force: :cascade do |t|
    t.string   "language",     limit: 10
    t.string   "title",        limit: 150
    t.text     "tags",         limit: 65535
    t.text     "description",  limit: 65535
    t.text     "content",      limit: 65535
    t.string   "poster",       limit: 70
    t.text     "slug",         limit: 65535
    t.integer  "status",       limit: 1
    t.integer  "created_by",   limit: 4
    t.integer  "published_by", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "member_details", force: :cascade do |t|
    t.integer "member_id",     limit: 4
    t.float   "income",        limit: 24
    t.integer "childs",        limit: 2
    t.text    "child_details", limit: 65535
    t.string  "contact",       limit: 50
    t.text    "address",       limit: 65535
  end

  create_table "member_referrers", force: :cascade do |t|
    t.integer  "member_id",       limit: 4
    t.string   "invitation_code", limit: 25
    t.string   "email",           limit: 50
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "oauth_uid",      limit: 25
    t.string   "oauth_provider", limit: 25
    t.string   "account_name",   limit: 60
    t.string   "email",          limit: 50
    t.string   "password",       limit: 60
    t.integer  "title",          limit: 1
    t.integer  "gender",         limit: 1
    t.string   "first_name",     limit: 25
    t.string   "last_name",      limit: 25
    t.date     "birth_date"
    t.integer  "member_type",    limit: 1
    t.string   "language",       limit: 10
    t.integer  "newsletter",     limit: 1
    t.integer  "promotion",      limit: 1
    t.string   "recovery_uid",   limit: 65
    t.datetime "recovery_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
