class AddCategoriesToBusines < ActiveRecord::Migration
  def self.up
    add_column :businesses, :category_id, :integer
    add_column :businesses, :subcategory_id, :integer
  end

  def self.down
  end
end
