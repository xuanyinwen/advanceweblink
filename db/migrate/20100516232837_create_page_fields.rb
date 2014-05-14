class CreatePageFields < ActiveRecord::Migration
  def self.up
    create_table :page_fields do |t|
      t.integer :page_id
      t.string  :name, :desc, :options
      t.integer :type, :length
      t.timestamps
    end
  end

  def self.down
    drop_table :page_fields
  end
end
