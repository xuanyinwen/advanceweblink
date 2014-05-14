class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.integer :property_id
      t.boolean :default
      t.string :image_uid
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
