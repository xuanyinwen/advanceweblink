class RenameListingIdToListingGroupId < ActiveRecord::Migration
  def self.up
    rename_column :properties, :listing_id, :listing_group_id
  end

  def self.down
    rename_column :properties, :listing_group_id, :listing_id
  end
end
