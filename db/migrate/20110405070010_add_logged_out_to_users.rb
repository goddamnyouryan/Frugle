class AddLoggedOutToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :logged_out, :string
  end

  def self.down
    remove_column :users, :logged_out
  end
end
