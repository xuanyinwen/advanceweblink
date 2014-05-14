class AddUserIdToListingGroupData < ActiveRecord::Migration
  def self.up
    add_column :listing_group_datas, :user_id, :integer
  end

  def self.down
    remove_column :listing_group_datas, :user_id
  end
end
