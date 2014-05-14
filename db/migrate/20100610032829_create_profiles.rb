class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|

      t.integer :user_id
      t.text :about, :helpful_links

      t.timestamps
    end
    
    User.all.each do |user|
      user.send 'setup_profile'
    end
    
    
  end

  def self.down
    drop_table :profiles
  end
end
