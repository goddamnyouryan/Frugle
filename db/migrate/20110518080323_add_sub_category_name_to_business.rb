class AddSubCategoryNameToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :subcategory_name, :string
  end

  def self.down
    remove_column :businesses, :subcategory_name
  end
end
