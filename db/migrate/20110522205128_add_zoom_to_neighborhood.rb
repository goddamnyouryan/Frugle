class AddZoomToNeighborhood < ActiveRecord::Migration
  def self.up
    add_column :neighborhoods, :zoom, :integer, { :null => false, :default => 13}
  end

  def self.down
    remove_column :neighborhoods, :zoom
  end
end
