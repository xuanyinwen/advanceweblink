class CreateThemeDatas < ActiveRecord::Migration
  def self.up
    create_table :theme_datas do |t|
      t.integer :user_id, :page_id
      t.text :data  #stored as json
      t.timestamps
    end
  end

  def self.down
    drop_table :theme_datas
  end
end
