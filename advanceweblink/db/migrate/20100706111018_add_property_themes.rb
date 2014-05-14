  class AddPropertyThemes < ActiveRecord::Migration
  def self.up
    add_column :themes, :property_line_item, :text
    add_column :themes, :property_show, :text
    add_column :themes, :property_image, :text
  end

  def self.down
    remove_column :themes, :property_image
    remove_column :themes, :property_show
    remove_column :themes, :property_line_item
  end
end
