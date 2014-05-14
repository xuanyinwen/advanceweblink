class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :theme_id
      t.text :data # plain html
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
