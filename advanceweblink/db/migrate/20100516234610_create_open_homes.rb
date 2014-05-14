class CreateOpenHomes < ActiveRecord::Migration
  def self.up
    create_table :open_homes do |t|
      t.integer  :property_id
      t.datetime :running_at
      t.integer  :duration
      t.timestamps
    end
  end

  def self.down
    drop_table :open_homes
  end
end
