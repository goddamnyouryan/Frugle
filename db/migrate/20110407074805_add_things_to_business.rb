class AddThingsToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :address2, :string
    add_column :businesses, :hear_about, :string
  end

  def self.down
    remove_column :businesses, :hear_about
    remove_column :businesses, :address2
  end
end
