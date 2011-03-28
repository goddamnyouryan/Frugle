class Adduseridtobusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :user_id, :integer
  end

  def self.down
  end
end
