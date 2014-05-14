class AddUserImage < ActiveRecord::Migration
  def self.up
    add_column :users, :image_uid, :string
  end

  def self.down
    remove_column :users, :image_uid
  end
end
