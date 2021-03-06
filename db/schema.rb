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

ActiveRecord::Schema.define(version: 2018_06_08_231515) do

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "native_id", null: false
    t.bigint "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_posts_on_site_id"
  end

  create_table "sites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "domain", null: false
    t.string "url", null: false
    t.string "icon_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_child_meta", default: false, null: false
    t.string "api_parameter", null: false
    t.string "link_color"
  end

  create_table "stages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "post_id", null: false
    t.text "data", limit: 4294967295, collation: "utf8mb4_unicode_ci"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stages_on_name"
    t.index ["post_id"], name: "index_stages_on_post_id"
  end

  add_foreign_key "posts", "sites"
  add_foreign_key "stages", "posts"
end
