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

ActiveRecord::Schema.define(version: 20141126060325) do

  create_table "attachments", force: true do |t|
    t.text     "description"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type"

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "position",    default: 100
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id"

  create_table "categories_items", id: false, force: true do |t|
    t.integer "item_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "connections", force: true do |t|
    t.integer "item_id"
    t.integer "connected_id"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "body"
    t.text     "preview"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "image_thumb_height",  limit: 255
    t.integer  "image_thumb_width",   limit: 255
    t.integer  "image_large_height",  limit: 255
    t.integer  "image_large_width",   limit: 255
    t.boolean  "featured"
    t.integer  "image_banner_height"
    t.integer  "image_banner_width"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
