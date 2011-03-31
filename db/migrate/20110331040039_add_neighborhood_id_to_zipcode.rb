class AddNeighborhoodIdToZipcode < ActiveRecord::Migration
  def self.up
    add_column :zipcodes, :neighborhood_id, :integer
  end

  def self.down
  end
end
