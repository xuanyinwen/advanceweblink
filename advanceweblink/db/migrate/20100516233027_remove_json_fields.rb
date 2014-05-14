class RemoveJsonFields < ActiveRecord::Migration
  def self.up
    remove_column :pages, :fields
    remove_column :page_datas, :data
  end

  def self.down
    add_column :page_datas, :data, :text
    add_column :pages, :fields, :text
  end
end
