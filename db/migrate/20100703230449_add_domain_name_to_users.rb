class AddDomainNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :domain_name, :string
  end

  def self.down
    remove_column :users, :domain_name
  end
end
