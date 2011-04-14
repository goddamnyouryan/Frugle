class Removesettingstable < ActiveRecord::Migration
  def self.up
    drop_table(:setting)
  end

  def self.down
  end
end
