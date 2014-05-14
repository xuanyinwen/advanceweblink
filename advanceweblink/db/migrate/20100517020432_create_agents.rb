class CreateAgents < ActiveRecord::Migration
  def self.up
    create_table :agents do |t|
      
      t.integer :property_id
      t.string :name, :email, :mobile, :work, :home, :fax, :code, :reinz_number, :franchise_id

      t.timestamps
    end
  end

  def self.down
    drop_table :agents
  end
end
