# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100721093017) do

  create_table "agents", :force => true do |t|
    t.integer  "property_id"
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "work"
    t.string   "home"
    t.string   "fax"
    t.string   "code"
    t.string   "reinz_number"
    t.string   "franchise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "property_id"
    t.boolean  "default"
    t.string   "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "listing_group_datas", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "listing_groups", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_homes", :force => true do |t|
    t.integer  "property_id"
    t.datetime "running_at"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "title"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "listing_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref"
    t.datetime "listed_at"
    t.datetime "added_to_sales_partner_at"
    t.string   "street_no"
    t.string   "street"
    t.string   "suburb"
    t.string   "district"
    t.integer  "search_price"
    t.string   "display_price"
    t.string   "category"
    t.string   "reaxml_class"
    t.string   "reaxml_category"
    t.string   "status"
    t.integer  "bedrooms"
    t.string   "rates"
    t.integer  "garaging"
    t.integer  "bathrooms"
    t.integer  "living_areas"
    t.datetime "auction_at"
    t.string   "auction_details"
    t.string   "tenure"
    t.float    "land_area"
    t.string   "land_area_unit"
    t.integer  "land_area_sqm"
    t.float    "floor_area"
    t.string   "floor_area_unit"
    t.integer  "floor_area_sqm"
    t.float    "gv"
    t.float    "lv"
    t.string   "category_code"
    t.boolean  "hide_address"
    t.string   "advert_heading"
    t.text     "advert_text"
    t.text     "advert_selling_points"
    t.string   "status_code"
    t.string   "listing_type"
  end

  create_table "settings", :force => true do |t|
    t.integer  "max_property_age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "property_line_item"
    t.text     "property_show"
    t.text     "property_image"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.integer  "theme_id"
    t.string   "guid"
    t.string   "image_uid"
    t.string   "name"
    t.string   "domain_name"
    t.string   "phone_work"
    t.string   "phone_after_hours"
    t.string   "phone_mobile"
    t.string   "phone_fax"
    t.string   "company"
    t.string   "tag_line"
  end

end
