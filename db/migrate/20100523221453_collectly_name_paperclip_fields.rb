class CollectlyNamePaperclipFields < ActiveRecord::Migration
  def self.up
    rename_column :assets, :avatar_content_type, :raw_content_type
    rename_column :assets, :avatar_file_size,    :raw_file_size
    rename_column :assets, :avatar_updated_at,   :raw_updated_at
  end

  def self.down
    rename_column :assets, :raw_content_type, :avatar_content_type
    rename_column :assets, :raw_file_size,    :avatar_file_size
    rename_column :assets, :raw_updated_at,   :avatar_updated_at
  end
end
