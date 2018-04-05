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

ActiveRecord::Schema.define(version: 20180405135803) do

  create_table "alternatives", force: :cascade do |t|
    t.integer "task_id"
    t.string "name"
    t.decimal "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_alternatives_on_task_id"
  end

  create_table "crit_scales", force: :cascade do |t|
    t.integer "criterium_id"
    t.string "name"
    t.decimal "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_crit_scales_on_criterium_id"
  end

  create_table "crit_values", force: :cascade do |t|
    t.integer "criteruim_id"
    t.integer "alternative_id"
    t.integer "crit_scale_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alternative_id"], name: "index_crit_values_on_alternative_id"
    t.index ["crit_scale_id"], name: "index_crit_values_on_crit_scale_id"
    t.index ["criteruim_id"], name: "index_crit_values_on_criteruim_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.integer "task_id"
    t.text "description"
    t.string "name"
    t.integer "criterium_id"
    t.decimal "rank"
    t.integer "ismin"
    t.decimal "idealvalue"
    t.integer "ws_method_id"
    t.integer "ord"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["criterium_id"], name: "index_criteria_on_criterium_id"
    t.index ["task_id"], name: "index_criteria_on_task_id"
    t.index ["ws_method_id"], name: "index_criteria_on_ws_method_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ws_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
