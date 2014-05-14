class RenamePageDataToHtml < ActiveRecord::Migration
  def self.up
    rename_column :pages, :data, :html
  end

  def self.down
    rename_column :pages, :html, :data
  end
end
