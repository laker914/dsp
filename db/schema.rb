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

ActiveRecord::Schema.define(:version => 20120317044647) do

  create_table "calcs", :force => true do |t|
    t.string   "company"
    t.string   "yearmonth",  :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "ccode",                                                        :null => false
    t.string   "ccname",                                                       :null => false
    t.string   "caddress",       :limit => 200,                                :null => false
    t.string   "contact"
    t.string   "job"
    t.string   "phone"
    t.string   "telphone"
    t.string   "fax"
    t.string   "py_code",                                                      :null => false
    t.string   "c_method",                                                     :null => false
    t.string   "org_code",                                                     :null => false
    t.string   "c_type",                                                       :null => false
    t.decimal  "insure_base",                   :precision => 18, :scale => 2
    t.decimal  "provident_base",                :precision => 18, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "city_name"
  end

  create_table "company_accounts", :force => true do |t|
    t.integer  "city_id"
    t.string   "city_name"
    t.integer  "hukou"
    t.integer  "item_id"
    t.decimal  "fix_value",     :precision => 10, :scale => 2
    t.decimal  "rate",          :precision => 10, :scale => 2
    t.integer  "company_type"
    t.decimal  "company_lower", :precision => 10, :scale => 2
    t.decimal  "company_limit", :precision => 10, :scale => 2
    t.integer  "company_round"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "employees", :force => true do |t|
    t.string   "empname"
    t.string   "empidn"
    t.integer  "sex"
    t.string   "job"
    t.datetime "bargain_begin"
    t.datetime "bargain_end"
    t.string   "emp_month"
    t.decimal  "insure_base",    :precision => 10, :scale => 2
    t.decimal  "provident_base", :precision => 10, :scale => 2
    t.integer  "hukou"
    t.string   "telphone"
    t.string   "insure_card"
    t.string   "lose_card"
    t.integer  "national"
    t.datetime "job_begin"
    t.integer  "education"
    t.integer  "company"
    t.string   "py_code"
    t.integer  "is_insure"
    t.integer  "is_provident"
    t.string   "c_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "hire_date",                                     :null => false
    t.string   "address"
    t.string   "remark"
  end

  create_table "infomations", :force => true do |t|
    t.string   "open_bank"
    t.string   "bank_account"
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "rmb",          :precision => 18, :scale => 2, :default => 50.0
  end

  create_table "insure_programs", :force => true do |t|
    t.string   "insure_name"
    t.string   "py_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insure_results", :force => true do |t|
    t.string   "yearmonth"
    t.integer  "emp_id"
    t.string   "emp_name"
    t.integer  "company"
    t.integer  "hukou"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insure_results_subs", :force => true do |t|
    t.integer  "main_id"
    t.integer  "insure_type"
    t.decimal  "insure_base",  :precision => 10, :scale => 2
    t.decimal  "insure_money", :precision => 10, :scale => 2
    t.integer  "insure_item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_accounts", :force => true do |t|
    t.integer  "city_id"
    t.string   "city_name"
    t.integer  "item_id",                                       :null => false
    t.integer  "hukou",                                         :null => false
    t.decimal  "fix_value",      :precision => 10, :scale => 2
    t.decimal  "rate",           :precision => 10, :scale => 2
    t.integer  "personal_type"
    t.decimal  "personal_limit", :precision => 10, :scale => 2
    t.decimal  "personal_lower", :precision => 10, :scale => 2
    t.integer  "personal_round"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "pcode"
    t.string   "pname"
    t.string   "py_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "tcode"
    t.string   "tvalue"
    t.string   "tname"
    t.integer  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",           :null => false
    t.string   "hashed_password", :null => false
    t.string   "login_name"
    t.integer  "sex"
    t.string   "email",           :null => false
    t.string   "login_ip"
    t.string   "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",            :null => false
  end

end
