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

ActiveRecord::Schema.define(version: 20141031005718) do

  create_table "accounts", force: true do |t|
    t.string   "Name"
    t.string   "Nikkei_ID"
    t.string   "Interest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "nickname"
    t.string   "image"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "uid"
  end

  create_table "articles", force: true do |t|
    t.string   "headline",                     null: false
    t.string   "category"
    t.string   "link"
    t.string   "img"
    t.text     "content",          limit: 255
    t.date     "capturedDate"
    t.boolean  "honbunFlg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "send_article_flg"
    t.boolean  "kidoku_flg"
    t.date     "published_date"
    t.integer  "favorite"
    t.string   "kiji_id"
    t.integer  "retweet_num"
  end

  create_table "articles_communities", force: true do |t|
    t.integer  "article_id"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "article_id"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "community_id"
    t.string   "account_id"
  end

  create_table "communities", force: true do |t|
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities_members", force: true do |t|
    t.integer  "community_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "account_id"
    t.integer  "article_id"
    t.boolean  "favorite_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "read_histories", force: true do |t|
    t.integer  "article_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
