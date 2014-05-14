class LinkPageDataToPageField < ActiveRecord::Migration
  def self.up
    remove_column :page_datas, :page_id
    
    add_column :page_datas, :page_field_id, :integer
    add_column :page_datas, :value, :string
    
  end

  def self.down
    remove_column :page_datas, :value
    remove_column :page_datas, :page_field_id

    add_column :page_datas, :page_id, :integer
  end
end
