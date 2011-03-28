class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :zip
      t.string :phone
      t.string :website
      t.text :info
      t.timestamps
    end
  end

  def self.down
    drop_table :businesses
  end
end
