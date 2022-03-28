# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_03_26_052925) do
  create_table "buildings", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buildings_work_permits", force: :cascade do |t|
    t.integer "building_id"
    t.integer "work_permit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_buildings_work_permits_on_building_id"
    t.index ["work_permit_id"], name: "index_buildings_work_permits_on_work_permit_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hazards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hazards_work_permits", force: :cascade do |t|
    t.integer "hazard_id"
    t.integer "work_permit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hazard_id"], name: "index_hazards_work_permits_on_hazard_id"
    t.index ["work_permit_id"], name: "index_hazards_work_permits_on_work_permit_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "badge"
    t.string "job_title"
    t.string "department"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "work_permits", force: :cascade do |t|
    t.integer "number"
    t.string "status"
    t.string "work_location"
    t.text "work_description"
    t.text "notes"
    t.date "start_date"
    t.date "end_date"
    t.string "category"
    t.boolean "needs_bypass"
    t.string "seh_representative"
    t.string "alternative_contact"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_work_permits_on_company_id"
  end

  add_foreign_key "work_permits", "companies"
end
