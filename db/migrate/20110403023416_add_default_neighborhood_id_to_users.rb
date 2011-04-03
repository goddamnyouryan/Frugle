class AddDefaultNeighborhoodIdToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :neighborhood_id
    add_column :users, :neighborhood_id, :integer, :default => 1
  end

  def self.down
  end
end
