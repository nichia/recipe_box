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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180706172624) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string  "name"
    t.integer "quantity"
    t.text    "content"
    t.integer "recipe_id"
  end

  create_table "instructions", force: :cascade do |t|
    t.text    "content"
    t.integer "recipe_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text    "content"
    t.integer "user_id"
    t.integer "recipe_id"
  end

  create_table "recipe_categories", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "category_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "prep_time"
    t.integer "cook_time"
    t.string  "yield"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
