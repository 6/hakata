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

ActiveRecord::Schema.define(:version => 20120313203254) do

  create_table "activities", :force => true do |t|
    t.string   "verb"
    t.integer  "user_id"
    t.integer  "list_id"
    t.integer  "mnemonic_id"
    t.integer  "fact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "criteria", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "elements", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "fact_id"
    t.string    "type"
    t.string    "value"
  end

  create_table "facts", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "field_id"
    t.string    "name"
    t.text      "description"
    t.text      "definition"
  end

  create_table "fields", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "description"
  end

  create_table "listizations", :force => true do |t|
    t.integer   "fact_id"
    t.integer   "list_id"
    t.integer   "position"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.text      "description"
  end

  create_table "lists_targets", :id => false, :force => true do |t|
    t.integer "list_id"
    t.integer "target_id"
  end

  create_table "mnemonics", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fact_id"
    t.integer  "user_id"
    t.boolean  "best"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "neurons",                      :default => 0
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

  create_table "votes", :force => true do |t|
    t.text      "body"
    t.integer   "user_id"
    t.integer   "mnemonic_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "up"
  end

end
