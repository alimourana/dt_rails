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

ActiveRecord::Schema[7.1].define(version: 2025_09_04_205526) do
  create_table "billing_rates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "origin", null: false
    t.string "destination", null: false
    t.decimal "rate", precision: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "citernes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "plate_number", null: false
    t.string "chassis_number", null: false
    t.string "capacity", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chassis_number"], name: "index_citernes_on_chassis_number", unique: true
    t.index ["plate_number"], name: "index_citernes_on_plate_number", unique: true
  end

  create_table "delivery_notes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "number", null: false
    t.string "status", null: false
    t.string "origin", null: false
    t.string "destination", null: false
    t.string "gasoline_quantity", null: false
    t.string "diesel_quantity", null: false
    t.string "total_quantity", null: false
    t.string "missing_quantity", null: false
    t.string "missing_description", null: false
    t.string "updated_by", null: false
    t.string "created_by", null: false
    t.date "issued_date", null: false
    t.date "delivery_date", null: false
    t.date "return_date", null: false
    t.bigint "employee_id"
    t.bigint "truck_id"
    t.bigint "citernes_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citernes_id"], name: "index_delivery_notes_on_citernes_id"
    t.index ["employee_id"], name: "index_delivery_notes_on_employee_id"
    t.index ["number"], name: "index_delivery_notes_on_number", unique: true
    t.index ["truck_id"], name: "index_delivery_notes_on_truck_id"
  end

  create_table "documents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "file_path"
    t.string "document_type"
    t.string "number"
    t.string "status"
    t.date "delivery_date"
    t.date "expiry_date"
    t.bigint "employee_id"
    t.bigint "truck_id"
    t.bigint "citernes_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citernes_id"], name: "index_documents_on_citernes_id"
    t.index ["employee_id"], name: "index_documents_on_employee_id"
    t.index ["truck_id"], name: "index_documents_on_truck_id"
  end

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "matricule", null: false
    t.string "department"
    t.string "position"
    t.string "status"
    t.string "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matricule"], name: "index_employees_on_matricule", unique: true
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "oauth_access_grants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "call_count", default: 0, null: false
    t.bigint "owner_id"
    t.string "owner_type"
    t.datetime "last_used_at"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_oauth_applications_on_created_by_id"
    t.index ["name", "owner_id", "owner_type"], name: "index_oauth_applications_on_name_and_owner_id_and_owner_type", unique: true
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "trucks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "make", null: false
    t.string "model", null: false
    t.string "plate_number", null: false
    t.string "status", null: false
    t.string "vin", null: false
    t.bigint "employee_id", null: false
    t.bigint "citernes_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citernes_id"], name: "index_trucks_on_citernes_id"
    t.index ["employee_id"], name: "index_trucks_on_employee_id"
    t.index ["plate_number"], name: "index_trucks_on_plate_number", unique: true
    t.index ["vin"], name: "index_trucks_on_vin", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "encrypted_password"
    t.string "phone_number"
    t.string "address_line"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "role", default: "user"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "delivery_notes", "citernes", column: "citernes_id"
  add_foreign_key "delivery_notes", "employees"
  add_foreign_key "delivery_notes", "trucks"
  add_foreign_key "documents", "citernes", column: "citernes_id"
  add_foreign_key "documents", "employees"
  add_foreign_key "documents", "trucks"
  add_foreign_key "employees", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "trucks", "citernes", column: "citernes_id"
  add_foreign_key "trucks", "employees"
end
