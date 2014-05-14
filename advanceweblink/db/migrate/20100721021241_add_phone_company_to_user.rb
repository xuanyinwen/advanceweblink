class AddPhoneCompanyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :phone_work, :string
    add_column :users, :phone_after_hours, :string
    add_column :users, :phone_mobile, :string
    add_column :users, :phone_fax, :string
    add_column :users, :company, :string
    add_column :users, :tag_line, :string
  end

  def self.down
    remove_column :users, :company
    remove_column :users, :phone_fax
    remove_column :users, :phone_mobile
    remove_column :users, :phone_after_hours
    remove_column :users, :phone_work
    remove_column :users, :tag_line
  end
end
