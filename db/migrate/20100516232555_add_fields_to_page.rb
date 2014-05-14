class AddFieldsToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :fields, :text  #stored as json
  end

  def self.down
    remove_column :pages, :fields
  end
end
