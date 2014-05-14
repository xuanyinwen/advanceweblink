class AddPropertyFields < ActiveRecord::Migration
  def self.up
    add_column :properties, :ref, :string 
    
    add_column :properties, :listed_at, :datetime
    add_column :properties, :added_to_sales_partner_at, :datetime 
    
    add_column :properties, :street_no, :string
    add_column :properties, :street, :string
    add_column :properties, :suburb, :string
    add_column :properties, :district, :string
    
    add_column :properties, :heading, :string
    add_column :properties, :details, :text
    add_column :properties, :selling_points, :text
    
    add_column :properties, :search_price, :integer
    add_column :properties, :display_price, :string
    
    add_column :properties, :category, :string
    
    add_column :properties, :reaxml_class, :string
    add_column :properties, :reaxml_category, :string
    
    add_column :properties, :status, :string
    
    add_column :properties, :bedrooms, :integer
    add_column :properties, :rates, :string
    add_column :properties, :garaging, :integer
    add_column :properties, :bathrooms, :integer
    add_column :properties, :living_areas, :integer
    
    add_column :properties, :auction_at, :datetime
    add_column :properties, :auction_details, :string
    add_column :properties, :tenure, :string
    
    add_column :properties, :land_area, :float
    add_column :properties, :land_area_unit, :string
    add_column :properties, :land_area_sqm, :integer
    
    add_column :properties, :floor_area, :float
    add_column :properties, :floor_area_unit, :string
    add_column :properties, :floor_area_sqm, :integer
    
    add_column :properties, :gv, :float
    add_column :properties, :lv, :float
    
  end

  def self.down
  end
end
