class CreateSettings < ActiveRecord::Migration
  def self.up
    
    create_table :settings do |t|
      t.integer :max_property_age
      t.timestamps
    end
    
    Setting.create :max_property_age => 14  # days
    
  end

  def self.down
    drop_table :settings
  end
end
