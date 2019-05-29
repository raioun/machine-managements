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

ActiveRecord::Schema.define(version: 20190428014043) do

  create_table "branches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_branches_on_company_id", using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "type1"
    t.string   "type2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orderers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.string   "family_name"
    t.string   "first_name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["customer_id"], name: "index_orderers_on_customer_id", using: :btree
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "out_date"
    t.string   "out_time"
    t.date     "in_date"
    t.string   "in_time"
    t.integer  "status",            limit: 1, default: 0, null: false
    t.integer  "project_id"
    t.integer  "orderer_id"
    t.integer  "rental_machine_id"
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["orderer_id"], name: "index_orders_on_orderer_id", using: :btree
    t.index ["project_id"], name: "index_orders_on_project_id", using: :btree
    t.index ["rental_machine_id"], name: "index_orders_on_rental_machine_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["customer_id"], name: "index_projects_on_customer_id", using: :btree
  end

  create_table "rental_machines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.integer  "machine_id"
    t.integer  "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_rental_machines_on_branch_id", using: :btree
    t.index ["machine_id"], name: "index_rental_machines_on_machine_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "branches", "companies"
  add_foreign_key "orderers", "customers"
  add_foreign_key "orders", "orderers"
  add_foreign_key "orders", "projects"
  add_foreign_key "orders", "rental_machines"
  add_foreign_key "orders", "users"
  add_foreign_key "projects", "customers"
  add_foreign_key "rental_machines", "branches"
  add_foreign_key "rental_machines", "machines"
end
