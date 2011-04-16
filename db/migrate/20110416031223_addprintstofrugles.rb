class Addprintstofrugles < ActiveRecord::Migration
  def self.up
    add_column :frugles, :prints, :integer, :default => 0
  end

  def self.down
  end
end
