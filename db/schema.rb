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

ActiveRecord::Schema.define(:version => 20241207011522) do

  create_table "administrators", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "administrators", ["email"], :name => "index_administrators_on_email", :unique => true

  create_table "audit_logs", :force => true do |t|
    t.string   "auditable_type"
    t.integer  "auditable_id"
    t.integer  "administrator_id"
    t.text     "change_data"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "audit_logs", ["administrator_id"], :name => "index_audit_logs_on_administrator_id"
  add_index "audit_logs", ["auditable_type", "auditable_id"], :name => "index_audit_logs_on_auditable_type_and_auditable_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "categories", ["created_by_id"], :name => "index_categories_on_created_by_id"
  add_index "categories", ["updated_by_id"], :name => "index_categories_on_updated_by_id"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true

  create_table "product_categories", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "product_categories", ["product_id", "category_id"], :name => "index_product_categories_on_product_id_and_category_id", :unique => true

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "product_images", ["product_id"], :name => "index_product_images_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",         :precision => 10, :scale => 2
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "products", ["created_by_id"], :name => "index_products_on_created_by_id"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["updated_by_id"], :name => "index_products_on_updated_by_id"

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.decimal  "price_at_sale", :precision => 10, :scale => 2
    t.datetime "purchased_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "purchases", ["customer_id"], :name => "index_purchases_on_customer_id"
  add_index "purchases", ["product_id"], :name => "index_purchases_on_product_id"
  add_index "purchases", ["purchased_at"], :name => "index_purchases_on_purchased_at"

end
