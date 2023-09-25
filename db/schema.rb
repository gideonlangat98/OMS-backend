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

ActiveRecord::Schema[7.0].define(version: 2023_09_11_073146) do
  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "isadmin", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_in_outs", force: :cascade do |t|
    t.string "name"
    t.string "duration"
    t.integer "staff_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.string "online_state", default: "offline"
    t.string "last_logged"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_name"
    t.text "description"
    t.string "main_email"
    t.string "second_email"
    t.integer "first_contact"
    t.integer "second_contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_articles", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.text "content"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "end_timesheets", force: :cascade do |t|
    t.date "date"
    t.time "end_time"
    t.string "task_detail"
    t.string "progress_details"
    t.string "staff_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.string "agenda"
    t.string "host"
    t.string "trainer"
    t.string "documents"
    t.string "email"
    t.string "meeting_link"
    t.integer "staff_id"
    t.integer "client_id"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string "your_name"
    t.date "date_from"
    t.date "date_to"
    t.integer "days_applied"
    t.string "leaving_type"
    t.text "reason_for_leave"
    t.string "status", default: "pending"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_calculations", force: :cascade do |t|
    t.string "staff_details"
    t.string "type_of_leave"
    t.integer "total_days"
    t.integer "used_days"
    t.integer "available_days"
    t.integer "leave_type_id"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_types", force: :cascade do |t|
    t.string "leave_reason"
    t.integer "days_allowed"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string "f_name"
    t.string "l_name"
    t.string "managers_title"
    t.string "email"
    t.string "password_digest"
    t.boolean "isManager", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.string "channel"
    t.integer "admin_id"
    t.integer "staff_id"
    t.boolean "read", default: false
    t.string "sender_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "bio"
    t.string "avatar"
    t.string "about"
    t.string "location"
    t.string "bio_name"
    t.string "my_email"
    t.string "tech"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.string "progress_by"
    t.string "assignment_name"
    t.string "task_managed"
    t.string "project_managed"
    t.date "assigned_date"
    t.date "start_date"
    t.string "exceeded_by"
    t.string "granted_time"
    t.date "delivery_time"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.text "description"
    t.string "client_details"
    t.string "project_managers"
    t.string "task_managers"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.string "request_by"
    t.string "task_request"
    t.string "request_detail"
    t.date "request_date"
    t.string "request_to"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string "staff_name"
    t.date "joining_date"
    t.string "reporting_to"
    t.string "email"
    t.string "password_digest"
    t.text "designation"
    t.boolean "isStaff", default: true
    t.integer "admin_id"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "start_timesheets", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.string "task_detail"
    t.string "time_limit"
    t.string "staff_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.date "assignment_date"
    t.date "completion_date"
    t.string "task_name"
    t.string "assigned_to"
    t.string "task_manager"
    t.string "project_manager"
    t.string "project_name"
    t.string "task_deadline"
    t.string "avatar_image"
    t.string "completed_files"
    t.string "send_type"
    t.boolean "isSeen", default: false
    t.integer "project_id"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.string "task_detail"
    t.string "progress_details"
    t.string "time_limit"
    t.integer "task_id"
    t.integer "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
