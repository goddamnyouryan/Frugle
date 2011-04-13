class AddCrapToBusinesses < ActiveRecord::Migration
  def self.up
    add_column :businesses, :contact_name, :string
    add_column :businesses, :contact_number, :string
    add_column :businesses, :role, :string
  end

  def self.down
    remove_column :businesses, :role
    remove_column :businesses, :contact_number
    remove_column :businesses, :contact_name
  end
end
