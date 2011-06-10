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

ActiveRecord::Schema.define(:version => 20110610075436) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "zipcode_id"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.string   "website"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "neighborhood_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address2"
    t.string   "hear_about"
    t.string   "contact_name"
    t.string   "contact_number"
    t.string   "role"
    t.string   "verification"
  end

  add_index "businesses", ["id"], :name => "index_businesses_on_id"
  add_index "businesses", ["neighborhood_id"], :name => "index_businesses_on_neighborhood_id"
  add_index "businesses", ["user_id"], :name => "index_businesses_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["id"], :name => "index_categories_on_id"

  create_table "categorizations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["id"], :name => "index_categorizations_on_id"
  add_index "categorizations", ["user_id"], :name => "index_categorizations_on_user_id"

  create_table "email_settings", :force => true do |t|
    t.boolean  "newsletter"
    t.string   "businesses_following"
    t.string   "recommendations"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "categories_following"
  end

  add_index "email_settings", ["id"], :name => "index_email_settings_on_id"
  add_index "email_settings", ["user_id"], :name => "index_email_settings_on_user_id"

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["business_id"], :name => "index_follows_on_business_id"
  add_index "follows", ["id"], :name => "index_follows_on_id"
  add_index "follows", ["user_id"], :name => "index_follows_on_user_id"

  create_table "frugles", :force => true do |t|
    t.integer  "business_id"
    t.string   "discount"
    t.text     "details"
    t.boolean  "mobile"
    t.integer  "quantity"
    t.integer  "views"
    t.datetime "start"
    t.datetime "end"
    t.string   "verification"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cost"
    t.string   "percentage"
    t.string   "product"
    t.boolean  "other_offer"
    t.boolean  "visit"
    t.boolean  "altered"
    t.string   "customers"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "prints",         :default => 0
  end

  add_index "frugles", ["business_id"], :name => "index_frugles_on_business_id"
  add_index "frugles", ["category_id"], :name => "index_frugles_on_category_id"
  add_index "frugles", ["id"], :name => "index_frugles_on_id"
  add_index "frugles", ["subcategory_id"], :name => "index_frugles_on_subcategory_id"
  add_index "frugles", ["verification"], :name => "index_frugles_on_verification"

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
    t.integer  "zoom",                    :default => 13, :null => false
  end

  add_index "neighborhoods", ["id"], :name => "index_neighborhoods_on_id"
  add_index "neighborhoods", ["name"], :name => "index_neighborhoods_on_name"

  create_table "reps", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.integer  "neighborhood_id"
    t.string   "subcategory_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",           :default => "inactive", :null => false
    t.text     "notes"
    t.string   "frugle"
    t.string   "contact_name"
    t.boolean  "contacted",        :default => false,      :null => false
    t.string   "email"
    t.integer  "business_id"
  end

  create_table "saveds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "frugle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "saveds", ["frugle_id"], :name => "index_saveds_on_frugle_id"
  add_index "saveds", ["id"], :name => "index_saveds_on_id"
  add_index "saveds", ["user_id"], :name => "index_saveds_on_user_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "subcategories", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"
  add_index "subcategories", ["id"], :name => "index_subcategories_on_id"

  create_table "subcategorizations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategorizations", ["id"], :name => "index_subcategorizations_on_id"
  add_index "subcategorizations", ["subcategory_id"], :name => "index_subcategorizations_on_subcategory_id"
  add_index "subcategorizations", ["user_id"], :name => "index_subcategorizations_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tokens", ["id"], :name => "index_user_tokens_on_id"
  add_index "user_tokens", ["user_id"], :name => "index_user_tokens_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",     :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",     :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.datetime "birthday"
    t.string   "role",                                :default => "user"
    t.integer  "neighborhood_id",                     :default => 1
    t.string   "logged_out"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["neighborhood_id"], :name => "index_users_on_neighborhood_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zipcodes", :force => true do |t|
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "neighborhood_id"
  end

  add_index "zipcodes", ["id"], :name => "index_zipcodes_on_id"
  add_index "zipcodes", ["neighborhood_id"], :name => "index_zipcodes_on_neighborhood_id"
  add_index "zipcodes", ["zip"], :name => "index_zipcodes_on_zip"

end
