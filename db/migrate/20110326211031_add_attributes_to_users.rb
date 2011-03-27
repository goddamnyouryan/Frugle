class AddAttributesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sex, :string
    add_column :users, :birthday, :datetime
    add_column :users, :role, :string, :default => "user"
  end

  def self.down
  end
end
