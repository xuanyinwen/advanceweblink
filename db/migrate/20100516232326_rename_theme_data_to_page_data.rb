class RenameThemeDataToPageData < ActiveRecord::Migration
  def self.up
    rename_table :theme_datas, :page_datas
  end

  def self.down
    rename_table :page_datas, :theme_datas
  end
end
