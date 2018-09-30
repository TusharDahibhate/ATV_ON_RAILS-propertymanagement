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

ActiveRecord::Schema.define(version: 2018_09_29_230409) do

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.text "address"
    t.integer "employee_count"
    t.integer "foundation_year"
    t.string "revenue"
    t.text "synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "househunters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "phone"
    t.string "contact_method"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_househunters_on_users_id"
  end

  create_table "houses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "companies_id"
    t.text "location"
    t.string "area"
    t.integer "year_built"
    t.string "style"
    t.integer "list_prize"
    t.integer "floor_count"
    t.boolean "basement"
    t.string "owner_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_houses_on_companies_id"
  end

  create_table "inquiries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.bigint "users_id"
    t.bigint "houses_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["houses_id"], name: "index_inquiries_on_houses_id"
    t.index ["users_id"], name: "index_inquiries_on_users_id"
  end

  create_table "realtors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "company_id"
    t.integer "phone_number"
    t.bigint "users_id"
    t.bigint "companies_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_realtors_on_companies_id"
    t.index ["users_id"], name: "index_realtors_on_users_id"
  end

  create_table "realtors_houses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "realtors_id"
    t.bigint "houses_id"
    t.index ["houses_id"], name: "index_realtors_houses_on_houses_id"
    t.index ["realtors_id"], name: "index_realtors_houses_on_realtors_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email_id"
    t.string "password"
    t.boolean "is_admin"
    t.boolean "is_realtor"
    t.boolean "is_househunter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "househunters", "users", column: "users_id"
  add_foreign_key "houses", "companies", column: "companies_id"
  add_foreign_key "inquiries", "houses", column: "houses_id"
  add_foreign_key "inquiries", "users", column: "users_id"
  add_foreign_key "realtors", "companies", column: "companies_id"
  add_foreign_key "realtors", "users", column: "users_id"
  add_foreign_key "realtors_houses", "houses", column: "houses_id"
  add_foreign_key "realtors_houses", "realtors", column: "realtors_id"
end
