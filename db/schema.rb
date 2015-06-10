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

ActiveRecord::Schema.define(version: 20150610153253) do

  create_table "article_images", force: :cascade do |t|
    t.integer  "article_id",         limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.boolean  "isCover",            limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

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

  create_table "banners", force: :cascade do |t|
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "order",              limit: 4
    t.text     "url",                limit: 65535
    t.text     "description",        limit: 65535
    t.string   "name",               limit: 255
    t.string   "locale",             limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name_en_US",         limit: 255
    t.string   "name_zh_CN",         limit: 255
    t.string   "name_zh_HK",         limit: 255
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name_en_US",         limit: 255
    t.string   "name_zh_CN",         limit: 255
    t.string   "name_zh_HK",         limit: 255
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.text     "desciption_en_US",   limit: 65535
    t.text     "description_zh_CN",  limit: 65535
    t.text     "description_zh_HK",  limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
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
    t.string   "oauth_provider", limit: 25
  end

  create_table "page_images", force: :cascade do |t|
    t.integer  "page_id",            limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.boolean  "isCover",            limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "browser_title", limit: 255
    t.text     "browser_url",   limit: 65535
    t.string   "locale",        limit: 255
    t.text     "content",       limit: 65535
    t.integer  "status",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id",         limit: 4
    t.string   "cover_file_name",    limit: 255
    t.string   "cover_content_type", limit: 255
    t.integer  "cover_file_size",    limit: 4
    t.datetime "cover_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "sku",                        limit: 255
    t.text     "description_en_US",          limit: 65535
    t.text     "description_zh_CN",          limit: 65535
    t.text     "description_zh_HK",          limit: 65535
    t.string   "name_en_US",                 limit: 255
    t.string   "name_zh_CN",                 limit: 255
    t.string   "name_zh_HK",                 limit: 255
    t.integer  "brand_id",                   limit: 4
    t.text     "short_description_en_US",    limit: 65535
    t.text     "short_description_zh_CN",    limit: 65535
    t.text     "short_description_zh_HK",    limit: 65535
    t.float    "unit_price",                 limit: 24
    t.float    "discounted_price",           limit: 24
    t.string   "discount_description_en_US", limit: 255
    t.string   "discount_description_zh_CN", limit: 255
    t.string   "discount_description_zh_HK", limit: 255
    t.integer  "status",                     limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "shopping_cart_items", force: :cascade do |t|
    t.integer  "product_id",       limit: 4
    t.float    "unit_price",       limit: 24
    t.integer  "qty",              limit: 4
    t.integer  "shopping_cart_id", limit: 4
    t.integer  "coupon_id",        limit: 4
    t.float    "sub_total",        limit: 24
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.text     "cookies",    limit: 65535
    t.float    "total",      limit: 24
    t.integer  "status",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
