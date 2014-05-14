class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :theme_id
      t.string :name

      t.string   :raw_file_name
      t.string   :avatar_content_type
      t.integer  :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
