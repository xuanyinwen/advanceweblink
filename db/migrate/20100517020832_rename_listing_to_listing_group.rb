class RenameListingToListingGroup < ActiveRecord::Migration
  def self.up
    rename_table :listings, :listing_groups
  end

  def self.down
    rename_table :listing_groups, :listings
  end
end
