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

ActiveRecord::Schema.define(version: 20170509150619) do

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",            null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "contact_email"
    t.text     "content",       limit: 65535
    t.boolean  "read_flag",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                      null: false
    t.float    "rate",        limit: 24
    t.string   "area"
    t.string   "address"
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.string   "url"
    t.string   "comment"
    t.text     "detail",      limit: 65535
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.boolean  "delete_flag",               default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "tip_genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "genre_id",                  default: 0, null: false
    t.text     "title",       limit: 65535
    t.text     "detail",      limit: 65535
    t.boolean  "delete_flag"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
