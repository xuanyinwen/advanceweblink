class AdditionalPropertyFields < ActiveRecord::Migration
  def self.up
    
    add_column :properties, :hide_address, :boolean
    add_column :properties, :advert_heading, :string
    add_column :properties, :advert_text, :text
    add_column :properties, :advert_selling_points, :text
    add_column :properties, :status_code, :string
    add_column :properties, :listing_type, :string

    remove_column :properties, :details
    remove_column :properties, :heading
    remove_column :properties, :selling_points

  end

  def self.down

    add_column :properties, :details, :string
    add_column :properties, :heading, :text
    add_column :properties, :selling_points, :text
    
    remove_column :properties, :hide_address
    remove_column :properties, :advert_heading
    remove_column :properties, :advert_text
    remove_column :properties, :advert_selling_points
    remove_column :properties, :status_code
    remove_column :properties, :listing_type

  end
end
