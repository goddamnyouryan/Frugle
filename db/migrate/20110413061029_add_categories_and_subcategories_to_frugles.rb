class AddCategoriesAndSubcategoriesToFrugles < ActiveRecord::Migration
  def self.up
    add_column :frugles, :category_id, :integer
    add_column :frugles, :subcategory_id, :integer
  end

  def self.down
    remove_column :frugles, :subcategory_id
    remove_column :frugles, :category_id
  end
end
