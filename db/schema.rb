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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130822233031) do

  create_table "addresses", :force => true do |t|
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.integer "zip"
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "companies", :force => true do |t|
    t.integer  "case_id"
    t.string   "trade_name"
    t.string   "legal_name"
    t.integer  "flsa_cl_violtn_count"
    t.integer  "flsa_cl_minor_count"
    t.float    "flsa_cl_cmp_assd_amt"
    t.float    "flsa_cmp_assd_amt"
    t.datetime "findings_start_date"
    t.datetime "findings_end_date"
    t.string   "flsa_repeat_violator"
    t.integer  "flsa_violation_count"
    t.integer  "flsa_ee_atp_count"
    t.float    "bw_atp_amt"
    t.float    "flsa_mw_bw_atp_amt"
    t.float    "flsa_ot_bw_atp_amt"
    t.float    "flsa_15a3_bw_atp_amt"
    t.string   "foursquare_id"
    t.integer  "address_id"
    t.integer  "industry_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "mspa_violtn_cnt"
    t.float    "mspa_bw_atp_amt"
    t.integer  "mspa_ee_atp_cnt"
    t.float    "mspa_cmp_assd_amt"
    t.integer  "fmla_violtn_cnt"
    t.float    "fmla_bw_atp_amt"
    t.integer  "fmla_ee_atp_cnt"
    t.float    "fmla_cmp_assd_amt"
    t.integer  "h1b_violtn_cnt"
    t.integer  "h1b_bw_atp_amt"
    t.integer  "h1b_ee_atp_cnt"
    t.float    "h1b_cmp_assd_amt"
  end

  add_index "companies", ["address_id"], :name => "index_companies_on_address_id"
  add_index "companies", ["industry_id"], :name => "index_companies_on_industry_id"

  create_table "industries", :force => true do |t|
    t.integer  "naic_code"
    t.string   "naic_code_description"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "default_city"
    t.string   "default_state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
