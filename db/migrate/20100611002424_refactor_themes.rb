class RefactorThemes < ActiveRecord::Migration
  def self.up
    
    drop_table :assets
    drop_table :pages
    drop_table :page_datas
    drop_table :page_fields
    drop_table :themes

    create_table :themes do |t|
      t.string :name
      t.text :content
      t.timestamps
    end
    
  end

  def self.down

    create_table "assets", :force => true do |t|
      t.integer  "theme_id"
      t.string   "name"
      t.string   "raw_file_name"
      t.string   "raw_content_type"
      t.integer  "raw_file_size"
      t.datetime "raw_updated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "page_datas", :force => true do |t|
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "page_field_id"
      t.string   "value"
    end

    create_table "page_fields", :force => true do |t|
      t.integer  "page_id"
      t.string   "name"
      t.string   "desc"
      t.string   "options"
      t.integer  "type"
      t.integer  "length"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "pages", :force => true do |t|
      t.integer  "theme_id"
      t.text     "html"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "themes", :force => true do |t|
      t.string   "name"
      t.boolean  "default"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end
