class AddCategoryCodeToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :category_code, :string
  end

  def self.down
    remove_column :properties, :category_code
  end
end
