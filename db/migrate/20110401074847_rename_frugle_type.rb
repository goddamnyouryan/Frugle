class RenameFrugleType < ActiveRecord::Migration
  def self.up
    rename_column(:frugles, :type, :discount)
    add_column(:frugles, :cost, :string)
  end

  def self.down
  end
end
