class AddLatAndLngToNeighborhood < ActiveRecord::Migration
  def self.up
    add_column :neighborhoods, :latitude, :float
    add_column :neighborhoods, :longitude, :float
  end

  def self.down
    remove_column :neighborhoods, :longitude
    remove_column :neighborhoods, :latitude
  end
end
