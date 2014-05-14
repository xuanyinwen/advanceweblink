class RemoveProfiles < ActiveRecord::Migration
  def self.up
    drop_table :profiles
  end

  def self.down
    create_table :profiles do |t|

      t.integer :user_id
      t.text :about, :helpful_links

      t.timestamps
    end
  end
end