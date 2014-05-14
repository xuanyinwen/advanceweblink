class AddThemeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :theme_id, :integer
  end

  def self.down
    remove_column :users, :theme_id
  end
end
