# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_06_121114) do

  create_table "page_views", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "visit_id"
    t.string "title"
    t.string "position"
    t.text "url"
    t.string "time_spent"
    t.decimal "timestamp", precision: 14, scale: 3
    t.index ["visit_id"], name: "index_page_views_on_visit_id"
  end

  create_table "visits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "evid"
    t.string "vendor_site_id"
    t.string "vendor_visit_id"
    t.string "visit_ip"
    t.string "vendor_visitor_id"
  end

end
