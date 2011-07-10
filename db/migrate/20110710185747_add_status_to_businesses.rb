class AddStatusToBusinesses < ActiveRecord::Migration
  def self.up
    add_column :businesses, :status, :string, {:null => false, :default => "frugle"}
  end

  def self.down
    remove_column :businesses, :status
  end
end
